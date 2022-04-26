% Script to plot an animated version of of the hopping robot

clear xmidBase ymidBase xmid ymid h_x h_y h1 xpos ypos jointAngle prevAngle
htable = figure;

saveVideo = 0;
if saveVideo == 1
    v = VideoWriter('HoppingRobot.mp4','MPEG-4');
    open(v);
end

scale = 2;
ax = axes('XLim',[-scale scale],'YLim',[-scale scale]);
grid on

nPts = length(geometry);
%nPts = 1;
for i = 1:nPts
    % Store the time histories of the base and each link
    baseVec(:,i)    = geometry(i).rBase;
    jointVec(:,:,i) = geometry(i).pVec;
    linkVec(:,:,i)  = geometry(i).rVec;
    xposBase(i)  = geometry(i).rBase(1);
    yposBase(i)  = geometry(i).rBase(2);
end

stateVec = x0;
psiBase = stateVec(6,:);

% Define the base to be drawn
xmidBase = geometry(1).rBase(1);
ymidBase = geometry(1).rBase(2);

h(1) = rectangle('Position',[xmidBase-Base_a ymidBase-Base_b 2*Base_a 2*Base_b],'Curvature',[1 1],'FaceColor',[135,206,250]/255);
h(2) = line(xmidBase,ymidBase);
h(2).Marker = 'x';
h(2).Color = [0 0 0];
t = hgtransform('Parent',ax);
set(h,'Parent',t)
Rz = eye(4);
Tcent1 = eye(4);
Tcent2 = eye(4);


Link_Width = 0.04;

for i = 1:nLink
    % Set the initial joint location
    xmid(i) = jointVec(i,1,1);
    ymid(i) = jointVec(i,2,1);

    % Define the center of the link
    h_x(i) = Link_Length(i)/2;
    h_y(i) = Link_Width/2;
    % Position the link
    %h1(i) = rectangle('Position',[xmid(i) ymid(i)-h_y(i) Link_Length(i) Link_Width],'FaceColor',[1 1 1]);
    h1(i) = rectangle('Position',[xmid(i) ymid(i)-h_y(i) Link_Width Link_Length(i)],'FaceColor',[1 1 1]);
    
    % Set up a transform for each link
    tLink(i) = hgtransform('Parent',ax);
    set(h1(i),'Parent',tLink(i));
    TransLink(i,:,:) = eye(4);
    RzLink(i,:,:) = eye(4);
    T1centLink(i,:,:) = eye(4);
    T2centLink(i,:,:) = eye(4);
end



prevAngle(1,:) = psiBase;
for i=1:nLink
    xpos(i,:)  = jointVec(i,1,:);
    ypos(i,:)  = jointVec(i,2,:);

    jointAngle(i,:)     = stateVec(6+i,:) + prevAngle(i,:);
    prevAngle(i+1,:) = jointAngle(i,:);
end



% Initialize the time annotation
if exist('htext') delete(htext); end
txt = sprintf('Time: %.1f  sec\n',time(1));
htext = text(0.2*scale,0.8*scale,txt);

j = 0;
for i = 1:nPts
    
    % Print the simulation time
    txt = sprintf('Time: %.1f  sec\n',time(i));
    set(htext,'String',txt);
  
    if i == 1 || mod(i,3) == 0
       
        % Define 2 transforms to move the center of rotation to the center
        % of the bodies
         T1cent  = makehgtform('translate',[-xmidBase -ymidBase 0]);
    %      T2cent = makehgtform('translate',[xmid ymid 0]);
         for k = 1:nLink
             T1centLink(k,:,:) = makehgtform('translate',[-xmid(k) -ymid(k) 0]);
         end

        % Translate the bodies to the current xy position
        Trans  = makehgtform('translate',[xposBase(i)  yposBase(i)  0]);
        for k = 1:nLink
            TransLink(k,:,:) = makehgtform('translate',[xpos(k,i) ypos(k,i) 0]);
        end

        % Rotate the bodies about the z axis
        Rz  = makehgtform('zrotate',psiBase(i));
        for k = 1:nLink
            RzLink(k,:,:) = makehgtform('zrotate',jointAngle(k,i));
        end

        % Concatenate the transforms and
        % set the transform Matrix property
    %     set(t,'Matrix',Trans*T2cent*Rz*T1cent)
        set(t,'Matrix',Trans*Rz*T1cent);
        for k=1:nLink
            set(tLink(k),'Matrix',squeeze(TransLink(k,:,:))*squeeze(RzLink(k,:,:))*squeeze(T1centLink(k,:,:)));
        end
        
    %     drawnow
    end
    if i == 1 || mod(i,10) == 0
        j = j+1;

        plotframe(j) = getframe;
        if saveVideo == 1
            writeVideo(v,plotframe(j));
        end
    end
    pause(0.1)

    
end
if saveVideo == 1
    close(v);
end
pause(1)


