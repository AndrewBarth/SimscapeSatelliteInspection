

% credit = out.creditOut.Data(:,1,end);
idx = 1;
credit = agentData{idx}.Benchmark2_RL_Eval.cubesat.coverage(end,:);

nAgents = 0;
if ~isempty(agentData{idx})
    cubesatRelPosition{1} = agentData{idx}.Benchmark2_RL_Eval.cubesat.position;
    nAgents = nAgents + 1;
    lText{nAgents} = strcat('Deputy',num2str(nAgents));
end
if ~isempty(agentData2{idx})
    cubesatRelPosition{2} = agentData2{idx}.Benchmark2_RL_Eval.cubesat.position;
    nAgents = nAgents + 1;
    lText{nAgents} = strcat('Deputy',num2str(nAgents));
end
if ~isempty(agentData3{idx})
    cubesatRelPosition{3} = agentData3{idx}.Benchmark2_RL_Eval.cubesat.position;
    nAgents = nAgents + 1;
    lText{nAgents} = strcat('Deputy',num2str(nAgents));
end
if ~isempty(agentData4{idx})
    cubesatRelPosition{4} = agentData4{idx}.Benchmark2_RL_Eval.cubesat.position;
    nAgents = nAgents + 1;
    lText{nAgents} = strcat('Deputy',num2str(nAgents));
end

clear GPData
if ~exist('GPData')
    %loadInspectionParams;
    GBa = 2;
    GBb = 2;

    sf = 1;
    % Use golden ratio for radius
    PHI = (1+sqrt(5)) / 2;
    radius = sf*norm([PHI 1 0]);
    
    makePlots = 0;
    [faceCenter,faceRadius,GPData] = formGoldbergPolyhedron(GBa,GBb,radius,makePlots);
    nFaces = length(faceCenter);
end

ONE = 1;
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

% Track credit
nInspectedperAgent = zeros(nAgents,1);
for i=1:nAgents
    nInspectedperAgent(i) = int32(sum(credit(:)==i));
    fprintf('Agent %d inspected %d faces\n',i,nInspectedperAgent(i))
end




% Plot the Goldberg Polyhedron
figure;
    hold on; 
    axis equal;
    view(3);
    C=colororder;

    for i=1:nAgents
        plot3(cubesatRelPosition{i}(:,1),cubesatRelPosition{i}(:,2),cubesatRelPosition{i}(:,3),'color',C(i,:))
    end 

    for i=1:nFaces
        if credit(i) > 0
            patch('Vertices', scaledV, 'Faces', GPData.F{i}+ONE, 'FaceColor', C(credit(i),:));
        else
            patch('Vertices', scaledV, 'Faces', GPData.F{i}+ONE, 'FaceColor', 'k');
        end
    end

    titleStr = ['Inspection Coverage for a Goldberg Polyhedron G(' num2str(GBa) ',' num2str(GBb) ')'];
    xlabel('x (m)');ylabel('y (m)');zlabel('z (m)');title(titleStr)
    legend(lText,'Location','NorthEast')
