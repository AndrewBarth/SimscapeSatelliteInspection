
coverage = out.coverageOut.Data(:,1,end);
credit = out.creditOut.Data(:,1,end);

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


    % Plot the Goldberg Polyhedron
figure;
    hold on; 
    axis equal;
    view(3);
    C=colororder;

    plot3(out.cubesatRelState.Cubesat1_RelState.Rel_Position.Data(:,1),out.cubesatRelState.Cubesat1_RelState.Rel_Position.Data(:,2),out.cubesatRelState.Cubesat1_RelState.Rel_Position.Data(:,3),'color',C(1,:))
    plot3(out.cubesatRelState.Cubesat2_RelState.Rel_Position.Data(:,1),out.cubesatRelState.Cubesat2_RelState.Rel_Position.Data(:,2),out.cubesatRelState.Cubesat2_RelState.Rel_Position.Data(:,3),'color',C(2,:))
    plot3(out.cubesatRelState.Cubesat3_RelState.Rel_Position.Data(:,1),out.cubesatRelState.Cubesat3_RelState.Rel_Position.Data(:,2),out.cubesatRelState.Cubesat3_RelState.Rel_Position.Data(:,3),'color',C(3,:))
    plot3(out.cubesatRelState.Cubesat4_RelState.Rel_Position.Data(:,1),out.cubesatRelState.Cubesat4_RelState.Rel_Position.Data(:,2),out.cubesatRelState.Cubesat4_RelState.Rel_Position.Data(:,3),'color',C(4,:))
    for i=1:client.nFaces
        if coverage(i) == 1
            patch('Vertices', scaledV, 'Faces', GPData.F{i}+ONE, 'FaceColor', C(credit(i),:));
        else
            patch('Vertices', scaledV, 'Faces', GPData.F{i}+ONE, 'FaceColor', 'k');
        end
    end

    % for i=1:size(faceCenter,1)
    %     scatter3(faceCenter(i,1),faceCenter(i,2),faceCenter(i,3),'yo','MarkerFaceColor','y')
    % end
    xlabel('x');ylabel('y');zlabel('z');title('Goldberg Polyhedron G(4,2)')

    % for i=1:client.nFaces
    %     if coverage(i) == 1
    %         if i<=nPentagons
    %             patch('Vertices', V, 'Faces', F5(i,:), 'FaceColor', C(credit(i),:));
    %         else
    %             patch('Vertices', V, 'Faces', F6(i-nPentagons,:), 'FaceColor', C(credit(i),:));
    %         end
    %     else
    %         if i<=nPentagons
    %             patch('Vertices', V, 'Faces', F5(i,:), 'FaceColor', 'k');
    %         else
    %             patch('Vertices', V, 'Faces', F6(i,:), 'FaceColor', 'k');
    %         end
    %     end
    % end