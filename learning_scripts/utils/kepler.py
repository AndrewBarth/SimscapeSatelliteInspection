import numpy as np
from utils import findc2c3
'''
    % ------------------------------------------------------------------------------
    %
    %                           function kepler
    %
    %  this function solves keplers problem for orbit determination and returns a
    %    future geocentric equatorial (ijk) position and velocity vector.  the
    %    solution uses universal variables.
    %
    %  author        : david vallado                  719-573-2600   22 jun 2002
    %
    %  revisions
    %    vallado     - fix some mistakes                             13 apr 2004
    %
    %  inputs          description                    range / units
    %    ro          - ijk position vector - initial  km
    %    vo          - ijk velocity vector - initial  km / s
    %    dtsec       - length of time to propagate    s
    %
    %  outputs       :
    %    r           - ijk position vector            km
    %    v           - ijk velocity vector            km / s
    %    error       - error flag                     'ok', ...
    %
    %  locals        :
    %    f           - f expression
    %    g           - g expression
    %    fdot        - f dot expression
    %    gdot        - g dot expression
    %    xold        - old universal variable x
    %    xoldsqrd    - xold squared
    %    xnew        - new universal variable x
    %    xnewsqrd    - xnew squared
    %    znew        - new value of z
    %    c2new       - c2(psi) function
    %    c3new       - c3(psi) function
    %    dtsec       - change in time                 s
    %    timenew     - new time                       s
    %    rdotv       - result of ro dot vo
    %    a           - semi or axis                   km
    %    alpha       - reciprocol  1/a
    %    sme         - specific mech energy           km2 / s2
    %    period      - time period for satellite      s
    %    s           - variable for parabolic case
    %    w           - variable for parabolic case
    %    h           - angular momentum vector
    %    temp        - temporary real*8 value
    %    i           - index
    %
    %  coupling      :
    %    mag         - magnitude of a vector
    %    findc2c3    - find c2 and c3 functions
    %
    %  references    :
    %    vallado       2004, 95-103, alg 8, ex 2-4
    %
    % [r, v] =  kepler  ( ro, vo, dtsec );

    % Modification History
    %     Nov  1, 2023 - Andrew Barth - used numpy syntax for constants instead of 
    %                                   Matlab, included some constants from constmath.m
    % ------------------------------------------------------------------------------
'''
# Port from Matlab

def kepler( ro, vo, dtseco ):
    # Added variable initialization
    r = np.zeros(3)
    v = np.zeros(3)
    #%function [r,v,errork] =  kepler  ( ro,vo, dtseco, fid );

    #% -------------------------  implementation   -----------------
    #% set constants and intermediate printouts
    #constmath;
    # the following 3 values were copied from constmath.m
    small = 1.0e-10
    infinite  = 999999.9
    undefined = 999999.1

    re         = 6378.137         #% km
    mu         = 398600.4418      #% km3/s2
    velkmps = np.sqrt(mu / re)
    show = 'n'
    numiter    =    50

    #if show =='y':
    #    fprintf(1,' ro %16.8f %16.8f %16.8f km \n',ro )
    #    fprintf(1,' vo %16.8f %16.8f %16.8f km/s \n',vo )
    #    fprintf(1,' ro %16.8f %16.8f %16.8f ER \n',ro/re )
    #    fprintf(1,' vo %16.8f %16.8f %16.8f ER/TU \n',vo/velkmps )

    #% --------------------  initialize values   -------------------
    ktr   = 0
    xold  = 0.0
    znew  = 0.0
    errork = '      ok'
    dtsec = dtseco
    nrev = 0
    smu = np.sqrt(mu)

    if ( np.abs( dtseco ) > small ):
        magro = np.linalg.norm( ro )
        magvo = np.linalg.norm( vo )
        rdotv= np.dot( ro,vo )

        #% -------------  find sme, alpha, and a  ------------------
        sme= ( (magvo**2)*0.5  ) - ( mu /magro )
        alpha= -sme*2.0/mu

        if ( np.abs( sme ) > small ):
            a= -mu / ( 2.0 *sme )
        else:
            a= infinite
        if ( np.abs( alpha ) < small ):   #% parabola
            alpha= 0.0

        #if show =='y':
        #    fprintf(1,' sme %16.8f  a %16.8f alp  %16.8f ER \n',sme/(mu/re), a/re, alpha*re )
        #    fprintf(1,' sme %16.8f  a %16.8f alp  %16.8f km \n',sme, a, alpha )
        #    fprintf(1,' ktr      xn        psi           r          xn+1        dtn \n' )

        #% ------------   setup initial guess for x  ---------------
        #% -----------------  circle and ellipse -------------------
        if ( alpha >= small ):
            period= 2*np.pi * np.sqrt( np.abs(a)**3.0/mu  )
            #% ------- next if needed for 2body multi-rev ----------
            if ( np.abs( dtseco ) > np.abs( period ) ):
                #% including the truncation will produce vertical lines that are parallel
                #% (plotting chi vs time)
                dtsec = np.fmod( dtseco, period )
                nrev = np.floor(dtseco/period)
            xold = smu *dtsec * alpha
        else:
            #% --------------------  parabola  ---------------------
            if ( np.abs( alpha ) < small ):
                h = np.cross( ro,vo )
                magh = np.linalg.norm(h);
                p= magh*magh/mu
                s= 0.5  * (0.5*np.pi - np.atan( 3.0 *np.sqrt( mu / (p*p*p) )* dtsec ) )
                w= np.atan( np.tan( s )^(1.0 /3.0 ) )
                xold = np.sqrt(p) * ( 2.0 *np.cot(2.0 *w) )
                alpha= 0.0
            else:
                #% ------------------  hyperbola  ------------------
                temp= -2.0 * mu * dtsec / \
                    ( a*( rdotv + np.sign(dtsec)*np.sqrt(-mu*a)* \
                    (1.0 -magro*alpha) ) )
                xold= np.sign(dtsec) * np.sqrt(-a) *np.log(temp)

        ktr= 1
        dtnew = -10.0
        #% conv for dtsec to x units
        tmp = 1.0 / smu

        while ((np.abs(dtnew*tmp - dtsec) >= small) and (ktr < numiter)):
            xoldsqrd = xold*xold
            znew     = xoldsqrd * alpha

            #% ------------- find c2 and c3 functions --------------
            [c2new, c3new] = findc2c3.findc2c3( znew )

            #% ------- use a newton iteration for new values -------
            rval = xoldsqrd*c2new + rdotv*tmp *xold*(1.0 -znew*c3new) + \
                magro*( 1.0  - znew*c2new )
            dtnew= xoldsqrd*xold*c3new + rdotv*tmp*xoldsqrd*c2new + \
                magro*xold*( 1.0  - znew*c3new )

            #% ------------- calculate new value for x -------------
            temp1 = ( dtsec*smu - dtnew ) / rval
            xnew = xold + temp1

            #% ----- check if the univ param goes negative. if so, use bissection
            if (xnew < 0.0 and dtsec > 0.0):
                xnew = xold*0.5
             
            #if show =='y':
            #    fprintf(1,'kep %3i %11.7f %11.7f %11.7f %11.7f %11.7f \n', 
            #        ktr,xold,znew,rval,xnew,dtnew*tmp)
            #    fprintf(1,'%3i %11.7f %11.7f %11.7f %11.7f %11.7f %11.7f %11.7f \n', 
            #        ktr,xold/sqrt(re),znew,c2new, c3new, rval/re,xnew/sqrt(re),dtnew/sqrt(mu))
  
            ktr = ktr + 1
            xold = xnew

        if ( ktr >= numiter ):
            errork= 'knotconv'
            #fprintf(1,'kep not conv in %2i iter %11.3f \n',numiter, dtseco )
            for i in range(3):
                v[i]= 0.0
                r[i]= v[i]
        else:
            #% --- find position and velocity vectors at new time --
            xnewsqrd = xnew*xnew
            f = 1.0  - ( xnewsqrd*c2new / magro )
            g = dtsec - xnewsqrd*xnew*c3new/np.sqrt(mu)

            for i in range(3):
                r[i]= f*ro[i] + g*vo[i]
            magr = np.linalg.norm( r )
            gdot = 1.0  - ( xnewsqrd*c2new / magr )
            fdot = ( np.sqrt(mu)*xnew / ( magro*magr ) ) * ( znew*c3new-1.0  )
            for i in range(3):
                v[i]= fdot*ro[i] + gdot*vo[i]

            temp= f*gdot - fdot*g
            if ( np.abs(temp-1.0 ) > 0.00001  ):
                errork= 'fandg'

            #if show =='y':
            #    fprintf(1,'f %16.8f g %16.8f fdot %16.8f gdot %16.8f \n',f, g, fdot, gdot )
            #    tusec = np.sqrt(re**3/mu)
            #    fprintf(1,'f %16.8f g %16.8f fdot %16.8f gdot %16.8f \n',f, g/tusec, fdot*tusec, gdot )
            #    fprintf(1,'r1 %16.8f %16.8f %16.8f km \n',r )
            #    fprintf(1,'v1 %16.8f %16.8f %16.8f km/s \n',v )
            #    fprintf(1,'r1 %16.8f %16.8f %16.8f ER \n',r/re )
            #    fprintf(1,'v1 %16.8f %16.8f %16.8f ER/TU \n',v/velkmps )
    else:
        #% ----------- set vectors to incoming since 0 time --------
        for i in range(3):
            r[i]= ro[i]
            v[i]= vo[i]


    return r, v



