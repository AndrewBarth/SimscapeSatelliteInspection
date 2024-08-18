
pos_base_control = out_control.base_state.translation.position.Data;
ori_base_control = out_control.base_state.rotation.euler.Data;
angv_base_control = out_control.base_state.rotation.angular_rate.Data;
data_time_control = out_control.base_state.translation.position.Time;

pos_base_nocontrol = out_nocontrol.base_state.translation.position.Data;
ori_base_nocontrol = out_nocontrol.base_state.rotation.euler.Data;
angv_base_nocontrol = out_nocontrol.base_state.rotation.angular_rate.Data;
data_time_nocontrol = out_nocontrol.base_state.translation.position.Time;

co = get(gca,'colororder');

% figure for base positions and orientation, co-plotted
figure;
subplot(2,1,1)
for i=1:2
    p1_1(i) = plot(data_time_control,pos_base_control(:,1),'Color',co(1,:)); hold all;
    p1_2(i) = plot(data_time_control,pos_base_control(:,2),'Color',co(2,:));
    p1_3(i) = plot(data_time_control,pos_base_control(:,3),'Color',co(4,:));

    p2_1(i) = plot(data_time_nocontrol,pos_base_nocontrol(:,1),'Color',co(1,:),'LineStyle','--'); 
    p2_2(i) = plot(data_time_nocontrol,pos_base_nocontrol(:,2),'Color',co(2,:),'LineStyle','--');
    p3_3(i) = plot(data_time_nocontrol,pos_base_nocontrol(:,3),'Color',co(4,:),'LineStyle','--');
end
xlabel('Time (s)'); ylabel('Base Position (m)')
title('Base Positions')
legend([p1_1(1) p1_2(1) p1_3(1)],'X Axis','Y Axis','Z Axis','location','best')
grid on; grid minor
ah1 = axes('position',get(gca,'position'),'visible','off');
legend(ah1, [p1_1(2) p2_1(2)], {'Control','No Control'}, 'Location','SouthWest');


subplot(2,1,2)
for i=1:2
    p1_1(i) = plot(data_time_control,ori_base_control(:,1)*rtd,'Color',co(1,:)); hold all;
    p1_2(i) = plot(data_time_control,ori_base_control(:,2)*rtd,'Color',co(2,:));
    p1_3(i) = plot(data_time_control,ori_base_control(:,3)*rtd,'Color',co(4,:));
    
    p2_1(i) = plot(data_time_nocontrol,ori_base_nocontrol(:,1)*rtd,'Color',co(1,:),'LineStyle','--');
    p2_2(i) = plot(data_time_nocontrol,ori_base_nocontrol(:,2)*rtd,'Color',co(2,:),'LineStyle','--');
    p2_3(i) = plot(data_time_nocontrol,ori_base_nocontrol(:,3)*rtd,'Color',co(4,:),'LineStyle','--');
end
xlabel('Time (s)'); ylabel('Base Orientation (deg)')
title('Base Orientation')
legend([p1_1(1) p1_2(1) p1_3(1)],'X Axis','Y Axis','Z Axis','location','best')
grid on; grid minor
ah2 = axes('position',get(gca,'position'),'visible','off');
legend(ah2, [p1_1(2) p2_1(2)], {'Control','No Control'}, 'Location','SouthWest');