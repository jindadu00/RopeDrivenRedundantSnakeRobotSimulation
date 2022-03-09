function [] = drawRobot(theta)
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明
    global H

    T=zeros(4,4,24);

    T1 =[cos(theta(1)), -sin(theta(1)), 0, 0;
    sin(theta(1)),  cos(theta(1)), 0, 0;
              0,            0, 1, 0;
              0,            0, 0, 1];
    T(:,:,1)=T1;

    T2 =[ cos(theta(2)), -sin(theta(2)), 0, 0;
               0,            0, 1, 0;
    -sin(theta(2)), -cos(theta(2)), 0, 0;
               0,            0, 0, 1];

    T(:,:,2)=T1*T2;

    for i =1:11
        T(:,:,i*2+1)=T(:,:,i*2)*...
        [cos(theta(i*2+1)), -sin(theta(i*2+1)),  0, H;
              0,            0, -1, 0;
        sin(theta(i*2+1)),  cos(theta(i*2+1)),  0, 0;
              0,            0,  0, 1];

        T(:,:,i*2+2)=T(:,:,i*2+1)*...
        [cos(theta(i*2+2)), -sin(theta(i*2+2)),  0, 0;
              0,            0, 1, 0;
        -sin(theta(i*2+2)),  -cos(theta(i*2+2)),  0, 0;
              0,            0,  0, 1];
    end

    r0=[0;0;0];
    r3 = T(1:3,4,3);
    r5 = T(1:3,4,5);
    r7 = T(1:3,4,7);
    r9 = T(1:3,4,9);
    r11 = T(1:3,4,11);
    r13 = T(1:3,4,13);
    r15 = T(1:3,4,15);
    r17 = T(1:3,4,17);
    r19 = T(1:3,4,19);
    r21 = T(1:3,4,21);
    r23 = T(1:3,4,23);
    r25 = T(:,:,24)*[H;0;0;1];
    r25 = r25(1:3);
    hold on
    grid on
    view(15, 15);
    axis square;



    radius=2;
    cylinder3(r0,r3,radius,10,'r',0,1);
    cylinder3(r3,r5,radius,10,'b',0,1);
    cylinder3(r5,r7,radius,10,'r',0,1);
    cylinder3(r7,r9,radius,10,'b',0,1);
    cylinder3(r9,r11,radius,10,'r',0,1);
    cylinder3(r11,r13,radius,10,'b',0,1);
    cylinder3(r13,r15,radius,10,'r',0,1);
    cylinder3(r15,r17,radius,10,'b',0,1);
    cylinder3(r17,r19,radius,10,'r',0,1);
    cylinder3(r19,r21,radius,10,'b',0,1);
    cylinder3(r21,r23,radius,10,'r',0,1);
    cylinder3(r23,r25,radius,10,'b',1,1);
    cylinder3([-40;0;0],[0;0;0],10,20,'g',1,0);
    pause(0.001)
    axis equal
    hold off

% Link1 = [r0, r3];
% Link2 = [r3, r5];
% Link3 = [r5, r7];
% Link4 = [r7, r9];
% Link5 = [r9, r11];
% Link6 = [r11, r13];
% Link7 = [r13, r15];
% Link8 = [r15, r17];
% Link9 = [r17, r19];
% Link10 = [r19, r21];
% Link11 = [r21, r23];
% Link12 = [r23, r25];
% plot3(Link1(1,:), Link1(2,:), Link1(3,:), 'LineWidth', 3, 'color', 'r');
% plot3(Link2(1,:), Link2(2,:), Link2(3,:), 'LineWidth', 3, 'color', 'b');
% plot3(Link3(1,:), Link3(2,:), Link3(3,:), 'LineWidth', 3, 'color', 'r');
% plot3(Link4(1,:), Link4(2,:), Link4(3,:), 'LineWidth', 3, 'color', 'b');
% plot3(Link5(1,:), Link5(2,:), Link5(3,:), 'LineWidth', 3, 'color', 'r');
% plot3(Link6(1,:), Link6(2,:), Link6(3,:), 'LineWidth', 3, 'color', 'b');
% plot3(Link7(1,:), Link7(2,:), Link7(3,:), 'LineWidth', 3, 'color', 'r');
% plot3(Link8(1,:), Link8(2,:), Link8(3,:), 'LineWidth', 3, 'color', 'b');
% plot3(Link9(1,:), Link9(2,:), Link9(3,:), 'LineWidth', 3, 'color', 'r');
% plot3(Link10(1,:), Link10(2,:), Link10(3,:), 'LineWidth', 3, 'color', 'b');
% plot3(Link11(1,:), Link11(2,:), Link11(3,:), 'LineWidth', 3, 'color', 'r');
% plot3(Link12(1,:), Link12(2,:), Link12(3,:), 'LineWidth', 3, 'color', 'b');



end

