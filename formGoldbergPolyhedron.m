
function [faceCenter,faceRadius,GPData] = formGoldbergPolyhedron(a,b,radius,makePlots)

    if nargin < 4
        makePlots = 1;
    else
        makePlots = makePlots;
    end
    
    lSide = a^2 + b^2 + a*b;
    
    global ONE
    ONE = 1;
    
    % Begin with golden ratio
    PHI = (1+sqrt(5)) / 2;
    
    
    % Form the 20 vertices of the icosahedron
    icoData.V = [ [0, PHI, -1]; [-PHI, 1, 0]; [-1, 0, -PHI]; [1, 0, -PHI]; [PHI, 1, 0]; ...
                  [0, PHI, 1]; [-1, 0, PHI]; [-PHI, -1, 0]; [0, -PHI, -1]; [PHI, -1, 0]; ...
                   [1, 0, PHI]; [0, -PHI, 1]];
    icoData.F = [ [ 0, 2, 1 ]; [ 0, 3, 2 ]; [ 0, 4, 3 ]; [ 0, 5, 4 ]; [ 0, 1, 5 ]; ...
                  [ 7, 6, 1 ]; [ 8, 7, 2 ]; [ 9, 8, 3 ]; [ 10, 9, 4 ]; [ 6, 10, 5 ]; ...
                  [ 2, 7, 1 ]; [ 3, 8, 2 ];[ 4, 9, 3 ]; [ 5, 10, 4 ]; [ 1, 6, 5 ]; ...
                  [ 11, 6, 7 ]; [ 11, 7, 8 ]; [ 11, 8, 9 ]; [ 11, 9, 10 ]; [ 11, 10, 6 ]  ];
    
    %edgematch =  [ [1, "B"], [2, "B"], [3, "B"], [4, "B"], [0, "B"], [10, "O", 14, "A"], [11, "O", 10, "A"], [12, "O", 11, "A"], [13, "O", 12, "A"], [14, "O", 13, "A"],...
    %         [0, "O"], [1, "O"], [2, "O"], [3, "O"], [4, "O"], [19, "B", 5, "A"], [15, "B", 6, "A"], [16, "B", 7, "A"], [17, "B", 8, "A"], [18, "B", 9, "A"] ]; 
    
    icoData.edgematch  = [cell({[1 "B"]}); cell({[2 "B"]}); cell({[3 "B"]}); cell({[4 "B"]}); cell({[0 "B"]}); ...
                          cell({[10 "O" 14 "A"]});  cell({[11 "O" 10 "A"]});  cell({[12 "O" 11 "A"]});  ...
                          cell({[13 "O" 12 "A"]});  cell({[14 "O" 13 "A"]}); cell({[0 "O"]}); cell({[1 "O"]}); ...
                          cell({[2 "O"]}); cell({[3 "O"]}); cell({[4 "O"]}); cell({[19 "B" 5 "A"]}); ...
                          cell({[15 "B" 6 "A"]}); cell({[16 "B" 7 "A"]}); cell({[17 "B" 8 "A"]}); cell({[18 "B" 9 "A"]}) ];
    
    GDmnData.V = [ [0, PHI, -1]; [-PHI, 1, 0]; [-1, 0, -PHI]; [1, 0, -PHI]; [PHI, 1, 0]; ...
                   [0, PHI, 1]; [-1, 0, PHI]; [-PHI, -1, 0]; [0, -PHI, -1]; [PHI, -1, 0]; ...
                   [1, 0, PHI]; [0, -PHI, 1]];
    GDmnData.F = [];
    
    GPData.V = [];
    GPData.F = {};
    
    % Create the primary triangle
    P = CreatePrimary(a,b);
    
    % Set Indices
    vecToIdx = setIndices(icoData,P,a,b);
    
    innerFacets = InnerFacets(P,a,b);
    [vertexTypes, isoVecsABOB] = EdgeVecsABOB(P,a,b);
    
    isoVecsOBOA = ABOBtoOBOA(vertexTypes,isoVecsABOB,a,b);
    isoVecsBAOA = ABOBtoBAOA(vertexTypes,isoVecsABOB,a,b);
    
    % Calc coeffs
    coau = (a+b)/lSide;
    cobu = -b/lSide;
    coav = -sqrt(3)/3*(a-b)/lSide;
    cobv = sqrt(3)/3*(2*a+b)/lSide;
    
    for f = 0:20-1
        [mapped(f+ONE,:,:),GDmnData] = MapToFace(icoData,GDmnData,f,P,vecToIdx,coau,coav,cobu,cobv);
        GDmnData = InnerToGDmnData(GDmnData,innerFacets,vecToIdx,f);
        if icoData.edgematch{f+ONE}{1+ONE} == 'B'
            GDmnData = ABOBtoGDmnDATA(GDmnData,icoData,isoVecsABOB,vertexTypes,vecToIdx,f);
        end
        if icoData.edgematch{f+ONE}{1+ONE} == 'O'
            GDmnData = OBOAtoGDmnDATA(GDmnData,icoData,isoVecsOBOA,vertexTypes,vecToIdx,f);
        end
        if length(icoData.edgematch{f+ONE}) > 2
            if icoData.edgematch{f+ONE}{3+ONE} == 'A'
                GDmnData = BAOAtoGDmnDATA(GDmnData,icoData,isoVecsBAOA,vertexTypes,vecToIdx,f);
            end
        end
    end
    
    % Create Goldberg polyhedron
    GPData = GDtoGP(GDmnData,GPData);
    
    %radius = norm([PHI 1 0]);
    for i=1:length(GPData.V)
        sf = norm(GPData.V(i,:));
        scaledV(i,:) = GPData.V(i,:)*radius/sf;
    end
    
    % Determine the centers and radius of each hexagon and pentagon of 
    % the Goldberg polyhedron
    for i=1:length(GPData.F)
        faceCenter(i,:) = sum(scaledV(GPData.F{i}+1,:),1)/length(GPData.F{i});
        faceRadius(i)= mean(vecnorm(scaledV(GPData.F{i}+1,:)-faceCenter(i,:),2,2));
    end
    
    for i=1:length(GPData.F)
        % Separate pentagons and hexagons
        if length(GPData.F{i}) == 5           
            Pentagons.F(i,:) = GPData.F{i};
        else
            Hexagons.F(i,:) = GPData.F{i};
        end
    end
    
    if makePlots == 1
        % Scale the size of the icosahedron
        sf = 1;
        V2 = icoData.V./norm(icoData.V(1,:))*sf;
        figure;
            hold on; 
            axis equal;
            view(3);
            
            patch('Vertices', icoData.V, 'Faces', icoData.F+ONE, 'FaceColor', [.5 .5 .5]);
            %patch('Vertices', V2, 'Faces', icoData.F+ONE, 'FaceColor', [0 .5 1]);
            
            k=1;
            for i=1:size(mapped,1)
                for j = 1:size(mapped,2)
                    scatter3(mapped(i,j,1),mapped(i,j,2),mapped(i,j,3),'bo','MarkerFaceColor','b')
                    k=k+1;
                end
            end
            for i=1:size(icoData.V,1)
                scatter3(icoData.V(i,1),icoData.V(i,2),icoData.V(i,3),'ro','MarkerFaceColor','r')
            end
            xlabel('x');ylabel('y');zlabel('z');title('Subdivided Icosahedron')
        
        figure;
            hold on; 
            axis equal;
            view(3);
            
            % radius = 2;
            radius = norm([PHI 1 0]);
            for i=1:length(GDmnData.V)
                sf = norm(GDmnData.V(i,:));
                scaledGDV(i,:) = GDmnData.V(i,:)*radius/sf;
            end
            %patch('Vertices', GDmnData.V, 'Faces', GDmnData.F+ONE, 'FaceColor', [0 1 1]);
            patch('Vertices', scaledGDV, 'Faces', GDmnData.F+ONE, 'FaceColor', [.5 .5 .5]);
            k=1;
            for i=1:size(mapped,1)
                for j = 1:size(mapped,2)
                    scatter3(mapped(i,j,1),mapped(i,j,2),mapped(i,j,3),'ro','MarkerFaceColor','r')
                    k=k+1;
                end
            end
            xlabel('x');ylabel('y');zlabel('z');title('Geodesic Mesh about Icosahedron')
        
        % Plot the Goldberg Polyhedron
        figure;
            hold on; 
            axis equal;
            view(3);
            

        
           
            patch('Vertices', scaledV, 'Faces', Pentagons.F+ONE, 'FaceColor', [0 1 1]);
            patch('Vertices', scaledV, 'Faces', Hexagons.F+ONE, 'FaceColor', [0 0 1]);
            for i=1:size(mapped,1)
                for j = 1:size(mapped,2)
            %        scatter3(mapped(i,j,1),mapped(i,j,2),mapped(i,j,3),'ro','MarkerFaceColor','r')
                    k=k+1;
                end
            end
            for i=1:size(faceCenter,1)
                scatter3(faceCenter(i,1),faceCenter(i,2),faceCenter(i,3),'yo','MarkerFaceColor','y')
            end
            xlabel('x');ylabel('y');zlabel('z');title('Goldberg Polyhedron G(2,2)')
    end
end

function P = CreatePrimary(m,n)
    global ONE

    % Create primary triangle
    P.vertices(1,:) = [0,0];
    P.vertices(2,:) = [m,n];
    P.vertices(3,:) = [-n, m+n];
    
    idx = 3;
    for y=n:m
        %for x = 0:(m+1-y-1)
        for x = 0:(m+1-y-1)
            idx = idx+1;
            P.vertices(idx,:) = [x,y];
        end
    end
    
    if n>0
        % g = m;
        % m1 = 1;
        % n1 = 0;
        % if n~= 0
        %     g = HCF(m,n);
        % end
        % g = max(m,n);
        % m1 = m / g;
        % n1 = n / g;
        % for i = 1:g-1
        %     idx = idx+1;
        %     P.vertices(idx,:) = [i*m1, i*n1];
        %     idx = idx+1;
        %     P.vertices(idx,:) = [-i*n1, i*(m1+n1)];
        %     idx = idx+1;
        %     P.vertices(idx,:) = [m - i*(m1+n1), n + i*m1];
        % end
        ratio = m/n;
        
        for y=0:n-1
            for x=0:(y*ratio)
                idx=idx+1;
                P.vertices(idx,:) = [x,y];
                idx=idx+1;
                P.vertices(idx,:) = [(m-x-y), (n+x)];
                idx=idx+1;
                P.vertices(idx,:) = [(y-n), (m+n-x-y)];
            end
        end
    end

    P.vertices = sortrows(P.vertices,[2 1]);

    % Find the min and max x values for each integer y value
    P.maxVal = -inf(1,m+n+1);
    P.minVal = inf(1,m+n+1);
    x=0;
    y=0;
    P.nVertices = length(P.vertices);
    for i = 1:P.nVertices
        x = P.vertices(i,1);
        y = P.vertices(i,2);    
        if mod(y, 1) == 0
            idx = find(P.vertices(:,2)==y);
            P.minVal(y+ONE) = min(x,P.minVal(y+ONE));
            P.maxVal(y+ONE) = max(x,P.maxVal(y+ONE));
        end
    end
    
     origin = [0 0];
     size = 0.5;
     for i = 1:P.nVertices
         P.cartesian(i,1) = origin(1) + 2*P.vertices(i,1) * size + P.vertices(i,2)*size;
         P.cartesian(i,2) = origin(2) + sqrt(3)*P.vertices(i,2)*size;
     end
end

% Set Indices
function vecToIdx = setIndices(icoData,P,m,n)
    global ONE

    indexCount = 12; % 12 vertices already assigned
    %const vecToIdx = {}; % maps iso-vectors to indexCount;
    vecToIdx = dictionary();
    
    g = m;
    m1 = 1;
    n1 = 0;
    if n ~=0
        g = HCF(m,n);
    end
    m1 = m / g;
    n1 = n / g;

    fr = 0;  % face to the right of current face
    rot = ''; % rotation about which vertes for fr
    O = 0;
    A = 0;
    B = 0;
    OR = 0;
    AR = 0;
    BR = 0;
    Ovec = [0, 0];
    Avec = [m, n];
    Bvec = [-n, m + n];
    OAvec = [0, 0];
    ABvec = [0, 0];
    OBvec = [0, 0];
    temp = 0;
    tempR = 0;
    verts = [];
    idx = '';
    idxR = '';
    
    %/***edges AB to OB***** rotation about B*/
    for f = 0:20-1  % f current face

        verts = icoData.F(f+ONE,:);
        O = verts(3);
        A = verts(2);
        B = verts(1);

        dictKey = strcat(string(f),'|',string(Ovec(1)),'|',string(Ovec(2)));
        if ~isConfigured(vecToIdx)
            vecToIdx(dictKey) = O;
        else
            if ~isKey(vecToIdx,dictKey)
                vecToIdx(dictKey) = O;
            end
        end

        dictKey = strcat(string(f),'|',string(Avec(1)),'|',string(Avec(2)));
        if ~isKey(vecToIdx,dictKey)
             vecToIdx(dictKey) = A;
        end

        dictKey = strcat(string(f),'|',string(Bvec(1)),'|',string(Bvec(2)));
        if ~isKey(vecToIdx,dictKey)
             vecToIdx(dictKey) = B;
        end

        fr  = icoData.edgematch{f+ONE}{1};
        rot = icoData.edgematch{f+ONE}{2};
        if (rot == "B")
            for i = 1:g-1 
                ABvec(1) = m - i * (m1 + n1);
                ABvec(2) = n + i * m1;
                OBvec(1) = -i * n1;
                OBvec(2) = i * (m1 + n1);
                dictKey  = strcat(string(f),'|',string(ABvec(1)), '|',string(ABvec(2)));
                dictKeyR = strcat(string(fr),'|',string(OBvec(1)), '|',string(OBvec(2)));
                [vecToIdx,indexCount] = matchIdx(dictKey,dictKeyR,vecToIdx,indexCount);
            end
        end
        if (rot == "O")
            for i = 1:g-1 
                OBvec(1) = -i * n1;
                OBvec(2) = i * (m1 + n1);
                OAvec(1) = i * m1;
                OAvec(2) = i * n1;

                dictKey  = strcat(string(f),'|',string(OBvec(1)), '|',string(OBvec(2)));
                dictKeyR = strcat(string(fr),'|',string(OAvec(1)), '|',string(OAvec(2)));
                [vecToIdx,indexCount] = matchIdx(dictKey,dictKeyR,vecToIdx,indexCount);
            end
        end

        if length(icoData.edgematch{f+ONE}) > 2
            fr = icoData.edgematch{f+ONE}{3};
            rot = icoData.edgematch{f+ONE}{4};       
            if (rot == "A")
                for i = 1:g-1 
                    OAvec(1) = i * m1;
                    OAvec(2) = i * n1;
                    ABvec(1) = m - (g - i) * (m1 + n1);  %reversed for BA
                    ABvec(2) = n + (g - i) * m1; %reversed for BA
                    dictKey  = strcat(string(f),'|',string(OAvec(1)), '|',string(OAvec(2)));
                    dictKeyR = strcat(string(fr),'|',string(ABvec(1)), '|',string(ABvec(2)));
                    [vecToIdx,indexCount] = matchIdx(dictKey,dictKeyR,vecToIdx,indexCount);
                end
            end
        end

         for i = 1:P.nVertices
             dictKey  = strcat(string(f),'|',string(P.vertices(i,1)), '|',string(P.vertices(i,2)));
             if ~isKey(vecToIdx,dictKey) 
                 
                 vecToIdx(dictKey) = indexCount;
                 indexCount = indexCount+1;
             end
         end

    end
end

function [new_vecToIdx,new_indexCount] = matchIdx(idx, idxR, vecToIdx, indexCount) 
        new_indexCount = indexCount;
        new_vecToIdx = vecToIdx;
        if ~(isKey(vecToIdx,idx) || isKey(vecToIdx,idxR)) 
            new_vecToIdx(idx) = indexCount;
            new_vecToIdx(idxR) = indexCount;
            new_indexCount = new_indexCount + 1;
      
        elseif (isKey(vecToIdx,idx) && ~isKey(vecToIdx,idxR))
            new_vecToIdx(idxR) = vecToIdx(idx);
    
        elseif (isKey(vecToIdx,idxR) && ~isKey(vecToIdx,idx)) 
            new_vecToIdx(idx) = vecToIdx(idxR);
        end
end

function [mapped,GDmnData] = MapToFace(icoData,GDmnData,f,P,vecToIdx,coau,coav,cobu,cobv)
    global ONE

    F = icoData.F(f+ONE,:);
    Oidx = F(3);
    Aidx = F(2);
    Bidx = F(1);

    O = icoData.V(Oidx+ONE,:);
    A = icoData.V(Aidx+ONE,:);
    B = icoData.V(Bidx+ONE,:);

    OA = A - O;
    OB = B - O;

    u = OA*coau + OB*cobu;
    v = OA*coav + OB*cobv;

    tempVec = [0 0 0];

    for i = 1:length(P.cartesian)
        tempVec = u*P.cartesian(i,1) + v*P.cartesian(i,2) + O;
        mapped(i,:) = [tempVec(1) tempVec(2) tempVec(3)];
        dictKey  = strcat(string(f),'|',string(P.vertices(i,1)), '|',string(P.vertices(i,2)));
        GDmnData.V(vecToIdx(dictKey)+ONE,:) = [tempVec(1) tempVec(2) tempVec(3)];
    end

end

function hcf = HCF(m, n)
    r = mod(m,n);
    if r == 0
        hcf = n;
        return;
    else
        hcf = HCF(n,r);
    end
end

function vec_out = rotate60deg(vec1,vec2)
    vec_out(1) = vec2(1) + vec2(2) - vec1(2);
    vec_out(2) = vec1(1) + vec1(2) - vec2(1);
end
function vec_out = rotateNeg60deg(vec1,vec2)
    vec_out(1) = vec1(1) + vec1(2) - vec2(2);
    vec_out(2) = vec2(1) + vec2(2) - vec1(1);
end
function vec_out = rotate120Sides(vec_in,m,n)
    vec_out(1) = m - vec_in(1) - vec_in(2);
    vec_out(2) = n + vec_in(1);
end
function vec_out = rotateNeg120Sides(vec_in,m,n)
    vec_out(1) = vec_in(2) - n;
    vec_out(2) = m + n - vec_in(1) - vec_in(2);
end

function innerFacets = InnerFacets(P,m,n)
    global ONE
% % Inner Facets
    innerFacets = {};
    i = 1;
    for y = 0:(n + m + 1) - 1
        for x = P.minVal(y+ONE):P.maxVal(y+ONE)
            if (x < P.maxVal(y+ONE) && x < P.maxVal(y + 1 + ONE) + 1)
                innerFacets{i} = [strcat('|',string(x), '|',string(y)),strcat('|',string(x),'|',string(y+1)),strcat('|',string(x+1),'|',string(y))];
%                 this.innerFacets.push(["|" + x + "|" + y, "|" + x + "|" + (y + 1), "|" + (x + 1) + "|" + y]);
                i=i+1;
            end

            if ( y > 0 && x <  P.maxVal(y - 1 + ONE) && x + 1 < P.maxVal(y + ONE) + 1) 
                innerFacets{i} = [strcat('|',string(x), '|',string(y)),strcat('|',string(x+1),'|',string(y)),strcat('|',string(x+1),'|',string(y-1))];
                i=i+1;
            end
        end
    end
end

function [vertexTypes, isoVecsABOB] = EdgeVecsABOB(P,m,n)
    global ONE
    vertexTypes = [];
    isoVecsABOB = {};

    B = [-n, m + n];
    i = 1;
    for y = 1:(m + n)-1
        point = [P.minVal(y+ONE) y];
        prev = [P.minVal(y - 1 +ONE), y - 1];
        next = [P.minVal(y + 1+ONE), y + 1];
        
        pointR = rotate60deg(point,B);
        prevR  = rotate60deg(prev,B);
        nextR  = rotate60deg(next,B);

        maxPoint = [P.maxVal(pointR(2) +ONE), pointR(2)];
        maxPrev = [P.maxVal(pointR(2) - 1 +ONE), pointR(2) - 1];
        maxLeftPrev = [P.maxVal(pointR(2) - 1 +ONE) - 1, pointR(2) - 1];

        if ((pointR(1) ~= maxPoint(1)) || (pointR(2) ~= maxPoint(2)))
            if (pointR(1) ~= maxPrev(1))  % type2
                %up
                vertexTypes(i,:) = [1, 0, 0];
                isoVecsABOB(i,:) = cell({point, maxPrev, maxLeftPrev});
                i=i+1;
                %down
                vertexTypes(i,:) = [1, 0, 0];
                isoVecsABOB(i,:,:) = cell({point, maxLeftPrev, maxPoint});
                i=i+1;
  
            elseif (pointR(2) == nextR(2)) % type1
                %up
                vertexTypes(i,:) = [1, 1, 0];
                isoVecsABOB(i,:) = cell({point, prev, maxPrev});
                i=i+1;
                %down
                vertexTypes(i,:) = [1, 0, 1];
                isoVecsABOB(i,:) = cell({point, maxPrev, next});
                i=i+1;

            else  % type 0
                %up
                vertexTypes(i,:) = [1, 1, 0];
                isoVecsABOB(i,:) = cell({point, prev, maxPrev});
                i=i+1;
                %down
                vertexTypes(i,:) = [1, 0, 0];
                isoVecsABOB(i,:) = cell({point, maxPrev, maxPoint});
                i=i+1;

            end
        end
    end
end

function [isoVecsOBOA] = ABOBtoOBOA(vertexTypes,isoVecsABOB,m,n)

    isoVecsOBOA = {};
    point = [0,0];
    
    % Shifted to account for 1-based indexing
    for i = 1:length(isoVecsABOB)
        temp = [];
        for j = 1:3
            point = isoVecsABOB{i,j};
            if vertexTypes(i,j) == 0
                point = rotateNeg120Sides(point,m,n);
            end
            temp(j,:) = point;
        end
        isoVecsOBOA(i,:) = cell({temp(1,:),temp(2,:),temp(3,:)});
    end
end

function isoVecsBAOA = ABOBtoBAOA(vertexTypes,isoVecsABOB,m,n)
    isoVecsBAOA = {};
    point = [0,0];
    
    % Shifted to account for 1-based indexing
    for i = 1:length(isoVecsABOB)
        temp = [];
        for j = 1:3
            point = isoVecsABOB{i,j};
            if vertexTypes(i,j) == 1
                point = rotate120Sides(point,m,n);
            end
            temp(j,:) = point;
        end
        isoVecsBAOA(i,:) = cell({temp(1,:),temp(2,:),temp(3,:)});
    end
end

function GDmnData = InnerToGDmnData(GDmnData,innerFacets,vecToIdx,f) 
    global ONE
    % Shifted to account for 1-based indexing
    idx = length(GDmnData.F)+1;
    for i = 1:length(innerFacets)
        for j = 1:3
            dictKey = strcat(string(f),innerFacets{i}{j});
            GDmnData.F(idx,j) = vecToIdx(dictKey);
        end
        idx=idx+1;
    end
end
    
function GDmnData = ABOBtoGDmnDATA(GDmnData,icoData,isoVecsABOB,vertexTypes,vecToIdx,f)
    global ONE
    fr = icoData.edgematch{f+ONE}{0+ONE};
    % Shifted to account for 1-based indexing
    idx = length(GDmnData.F)+1;
    for i = 1:length(isoVecsABOB)
        for j = 1:3
            if vertexTypes(i,j) == 0
                dictKey(j) = strcat(string(f),'|', string(isoVecsABOB{i,j}(1)),'|',string(isoVecsABOB{i,j}(2)));
            else 
                dictKey(j) = strcat(string(fr),'|', string(isoVecsABOB{i,j}(1)),'|',string(isoVecsABOB{i,j}(2)));
            end
        end
        
        GDmnData.F(idx,:) = [vecToIdx(dictKey(1)),vecToIdx(dictKey(2)),vecToIdx(dictKey(3))];
        idx=idx+1;
    end
end

function GDmnData = OBOAtoGDmnDATA(GDmnData,icoData,isoVecsOBOA,vertexTypes,vecToIdx,f)
    global ONE
    fr = icoData.edgematch{f+ONE}{0+ONE};
     % Shifted to account for 1-based indexing
    idx = length(GDmnData.F)+1;
    for i = 1:length(isoVecsOBOA)
        for j = 1:3
            if vertexTypes(i,j) == 1
                dictKey(j) = strcat(string(f),'|', string(isoVecsOBOA{i,j}(1)),'|',string(isoVecsOBOA{i,j}(2)));
            else 
                dictKey(j) = strcat(string(fr),'|', string(isoVecsOBOA{i,j}(1)),'|',string(isoVecsOBOA{i,j}(2)));
            end
        end
        GDmnData.F(idx,:) = [vecToIdx(dictKey(1)),vecToIdx(dictKey(2)),vecToIdx(dictKey(3))];
        idx=idx+1;
    end
end

function GDmnData = BAOAtoGDmnDATA(GDmnData,icoData,isoVecsBAOA,vertexTypes,vecToIdx,f)
    global ONE
    fr = icoData.edgematch{f+ONE}{2+ONE};
    % Shifted to account for 1-based indexing
    idx = length(GDmnData.F)+1;
    for i = 1:length(isoVecsBAOA)
        for j = 1:3
            if vertexTypes(i,j) == 1
                dictKey(j) = strcat(string(f),'|', string(isoVecsBAOA{i,j}(1)),'|',string(isoVecsBAOA{i,j}(2)));
            else 
                dictKey(j) = strcat(string(fr),'|', string(isoVecsBAOA{i,j}(1)),'|',string(isoVecsBAOA{i,j}(2)));
            end
        end
        GDmnData.F(idx,:) = [vecToIdx(dictKey(1)),vecToIdx(dictKey(2)),vecToIdx(dictKey(3))];
        idx=idx+1;
    end
end

% //Puts vertices of a face for GP in correct order for mesh construction
function dualFaces  = setOrder(m, faces, data)
    global ONE
    dualFaces = [];

    % Pop the last value from the faces array
    face = faces(end);
    faces(end) = [];
    dualFaces(1) = face;
    index = find(data.F(face+ONE,:) == m,1);
    %%%index = mod((index + 2), 3); %index to vertex included in adjacent face
    index = mod((index + 1), 3); %index to vertex included in adjacent face
    v = data.F(face+ONE,index+ONE);
    f = 0;
    vIndex = 0;
    while ~isempty(faces)
        face = faces(f+ONE);
        if ~isempty(find(data.F(face+ONE,:) == v,1)) % v is a vertex of face f
            %%%index = mod(find(data.F(face+ONE,:) == v,1) + 1, 3);
            index = mod(find(data.F(face+ONE,:) == v,1), 3);
%              index = (data.face[face].indexOf(v) + 1) % 3;
            v = data.F(face+ONE,index+ONE);
            dualFaces(end+1) = face;
            faces(f+ONE) = [];
%              faces.splice(f, 1);
            f = 0;
        else
            f = f+1;
        end
    end 
end

 %convert geodesic to Goldberg by forming the dual
 function GPData = GDtoGP(GDdata,GPData)
     global ONE
  
     % Number of vertices and faces in the geodesic data set
     nV = length(GDdata.V);
     nF = length(GDdata.F);
     % map = int16.empty(nV,3,0);
     map = cell(nV,1);

     % Shifted to account for 1-based indexing
     % for v = 1:nV 
     %     map[v] = new Set();
     % end
     for f = 1:nF
         for i = 1:3
             if ~ismember(f-1,map{GDdata.F(f,i)+ONE})
                if isempty(map{GDdata.F(f,i)+ONE})
                    map{GDdata.F(f,i)+ONE} = f-1;
                else
                    map{GDdata.F(f,i)+ONE}(end+1) = f-1;
                end
             end
         end
     end
   
     cx = 0;
     cy = 0;
     cz = 0;
     face = [];
     vertex = [];
     for m = 0:length(map)-1
         GPData.F{m+ONE} = setOrder(m, map{m+ONE}, GDdata);
         for n = 1:length(map{m+ONE})
           el = map{m+ONE}(n);
 %         map[m].forEach((el) => {
           cx = 0;
           cy = 0;
           cz = 0;
           face = GDdata.F(el+ONE,:);
           % Shifted to account for 1-based indexing
           for i = 1:3
               vertex = GDdata.V(face(i)+ONE,:);
               cx = cx + vertex(1);
               cy = cy + vertex(2);
               cz = cz + vertex(3);
           end
           GPData.V(el+ONE,:) = [cx / 3, cy / 3, cz / 3];  
         end

     end
 end
