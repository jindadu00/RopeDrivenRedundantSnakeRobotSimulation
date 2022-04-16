function [] = drawRobot(theta,bias)
%input：   T:               transformation matrix calculated by 'calT'
%output:   Visualize the robotic arm
    global H

    T=zeros(4,4,12);
    

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

    for i =1:5
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
    r13 = T(:,:,12)*[H;0;0;1];
    r13 = r13(1:3);
    bias=T(1,4,1);
    baseR= [bias;0;0];
    baseL= [bias-20;0;0];
    hold on
    grid on
    view(15, 15);
    axis square;



    radius=5;
    cylinder3(r0,r3,radius,10,'r',0,0);
    cylinder3(r3,r5,radius,10,'b',0,0);
    cylinder3(r5,r7,radius,10,'r',0,0);
    cylinder3(r7,r9,radius,10,'b',0,0);
    cylinder3(r9,r11,radius,10,'r',0,0);
    cylinder3(r11,r13,radius,10,'b',0,0);
    cylinder3(baseL,baseR,10,20,'g',0,0);
    xlabel('x/cm','FontSize',12);
    ylabel('y/cm','FontSize',12);
    zlabel('z/cm','FontSize',12);
    axis equal
    hold off


end

