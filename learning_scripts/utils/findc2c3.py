import numpy as np
'''
% ------------------------------------------------------------------------------
%
%                           function findc2c3
%
%  this function calculates the c2 and c3 functions for use in the universal
%    variable calculation of z.
%
%  author        : david vallado                  719-573-2600   27 may 2002
%
%  revisions
%                -
%
%  inputs          description                    range / units
%    znew        - z variable                     rad2
%
%  outputs       :
%    c2new       - c2 function value
%    c3new       - c3 function value
%
%  locals        :
%    sqrtz       - square root of znew
%
%  coupling      :
%    sinh        - hyperbolic sine
%    cosh        - hyperbolic cosine
%
%  references    :
%    vallado       2001, 70-71, alg 1
%
% [c2new,c3new] = findc2c3 ( znew );
% ------------------------------------------------------------------------------
'''
# Port from Matlab file

def findc2c3(znew):

    small =     0.000001

    #% -------------------------  implementation   -----------------
    if ( znew > small ):
        sqrtz = np.sqrt( znew )
        c2new = (1.0 -np.cos( sqrtz )) / znew
        c3new = (sqrtz-np.sin( sqrtz )) / ( sqrtz**3 )
    else:
        if ( znew < -small ):
            sqrtz = np.sqrt( -znew )
            c2new = (1.0 -np.cosh( sqrtz )) / znew
            c3new = (np.sinh( sqrtz ) - sqrtz) / ( sqrtz**3 )
        else:
            c2new = 0.5
            c3new = 1.0 /6.0

    return c2new,c3new
