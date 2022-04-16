clc;
clear;
e=1e-7;
global H
H=10;

X=[60;0;0];
sizeX=size(X);
if sizeX(1)==3
    flag=0;
else 
    if sizeX(1)==6
        flag=1;
    else
        disp('error')
    end
end
theta=ones(12,1);
bias=10;

% T=calT(theta,bias);
% 
% X=forwardKinematics(T,flag)
[theta,bias]=inverseKinematics(X,theta,bias)
forwardKinematics(theta,bias,0)
% X=forwardKinematics(theta,bias,flag);
drawRobot(theta,bias);
% theta=inverseKinematicsInitialPSO(X,bias);
% drawRobot(theta,bias);
% 
% drawnow;
% F=getframe(gcf);
% I=frame2im(F);
% [I,map]=rgb2ind(I,256);
% imwrite(I,map,'test.gif','gif', 'Loopcount',inf,'DelayTime',0.1);
    
% % theta=inverseKinematicsPSO(X,theta,bias);
% % drawRobot(theta,bias);