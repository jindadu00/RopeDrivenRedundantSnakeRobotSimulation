function [] = drawWall(left,right,top,bottom,front,back,center,radius)
%UNTITLED3 此处显示有关此函数的摘要
%   此处显示详细说明
% left=-50;
% right=50;
% top=50;
% bottom=-50;
% front=10;
% back=15;
% center=[10;10];     %圆心的y和z坐标
% radius=5;

v = [back,left,top;
    front,left,top;
    front,right,top;
    back,right,top;
    back,left,bottom;
    front,left,bottom;
    front,right,bottom;
    back,right,bottom];
f = [1,2,3,4;
    5,6,7,8;
    1,2,6,5;
    4,3,7,8];

patch('Faces',f,'Vertices',v,...
    'EdgeColor','none','FaceColor','green','FaceAlpha',0.05);


t = (0:0.2:20)';
theta = t*(2*pi/t(end));

frontCenter = [front;center]';
frontPoints =frontCenter + radius*[zeros(size(theta)) cos(theta) sin(theta)];
frontPoints=[front,right,top;
    front,left,top;
    front,left,bottom;
    front,right,bottom;
    front,right,center(2);
    frontPoints;
    front,right,center(2)];

patch('X',frontPoints(:,1),'Y',frontPoints(:,2),'Z',frontPoints(:,3),...
    'EdgeColor','none','FaceColor','green','FaceAlpha',0.05);


backCenter = [back;center]';
backPoints =backCenter + radius*[zeros(size(theta)) cos(theta) sin(theta)];
backPoints=[back,right,top;
    back,left,top;
    back,left,bottom;
    back,right,bottom;
    back,right,center(2);
    backPoints;
    back,right,center(2)];

patch('X',backPoints(:,1),'Y',backPoints(:,2),'Z',backPoints(:,3),...
    'EdgeColor','none','FaceColor','green','FaceAlpha',0.05);

cylinder3(frontCenter,backCenter,radius,20,[0.1,0.8,0.6],0,0)


hold on
% axis equal
view(3)

end

