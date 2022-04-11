clc;
clear;
close;

% P=zeros(13,3,2);
% for i=1:13
%     for j=1:2
%         P(i,1,j)=i;
%         P(i,2,j)=i^2;
%     end
% end
% plot(P(:,1,1),P(:,2,1))
% 
% theta = P2Theta(P)

% 输入P为三维矩阵size为(13,3,t)
% 输出Theta为二维矩阵size为(24,t);


global H
global robotRadius
robotRadius=2;
H=10;

wallsInfo(1).left=-50;
wallsInfo(1).right=50;
wallsInfo(1).top=50;
wallsInfo(1).bottom=-50;
wallsInfo(1).front=10;
wallsInfo(1).back=12;
wallsInfo(1).center=[0;0];
wallsInfo(1).radius=5;

wallsInfo(2).left=-50;
wallsInfo(2).right=50;
wallsInfo(2).top=50;
wallsInfo(2).bottom=-50;
wallsInfo(2).front=30;
wallsInfo(2).back=32;
wallsInfo(2).center=[0;0];
wallsInfo(2).radius=5;

wallsInfo(3).left=-50;
wallsInfo(3).right=50;
wallsInfo(3).top=50;
wallsInfo(3).bottom=-50;
wallsInfo(3).front=50;
wallsInfo(3).back=52;
wallsInfo(3).center=[0;0];
wallsInfo(3).radius=5;

for i = 1:length(wallsInfo)
    drawWall(wallsInfo(i).left,...
        wallsInfo(i).right,...
        wallsInfo(i).top,...
        wallsInfo(i).bottom,...
        wallsInfo(i).front,...
        wallsInfo(i).back,...
        wallsInfo(i).center,...
        wallsInfo(i).radius);
end
bias=0;
theta=ones(24,1)*0.022;
col=colDetection(theta,bias,wallsInfo)
% colConsiderRadius=colDetectionConsiderRadius(theta,bias,wallsInfo)
drawRobot(theta,bias)

% left=-50;
% right=50;
% top=50;
% bottom=-50;
% front=10;
% back=15;
% center=[10;10];     %圆心的y和z坐标
% radius=5;