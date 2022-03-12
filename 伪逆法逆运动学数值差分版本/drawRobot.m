function [] = drawRobot(theta,bias)
%input：   T:               transformation matrix calculated by 'calT'
%output:   Visualize the robotic arm
    global H

    T=zeros(4,4,24);
    

    T1 =[cos(theta(1)), -sin(theta(1)), 0, bias;
    sin(theta(1)),  cos(theta(1)), 0, 0;
              0,            0, 1, 0;
              0,            0, 0, 1];
    T(:,:,1)=T1;

    T2 =[ cos(theta(2)), -sin(theta(2)), 0, 0;
               0,            0, 1, 0;
    -sin(theta(2)), -cos(theta(2)), 0, 0;
               0,            0, 0, 1];

    T(:,:,2)=T(:,:,1)*T2;

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
    
    r0=T(1:3,4,1);
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
    bias=T(1,4,1);
    baseR= [bias;0;0];
    baseL= [bias-20;0;0];
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
    cylinder3(baseL,baseR,10,20,'g',1,0);
    pause(0.001)
    axis equal
    hold off


end

