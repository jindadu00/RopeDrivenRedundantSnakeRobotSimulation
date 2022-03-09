function [] = drawFoundation()
%画机器人底座
t = (0:0.2:20)';
radius = 10;
theta = t*(2*pi/t(end));
point =(radius*[ cos(theta) sin(theta)])';
Y=point(1,:);
Y=[Y;Y];
Z=point(2,:);
Z=[Z;Z];
A = ones(1,101)*-40;
B = zeros(1,101);
X = [A;B];
cdata=cat(3,zeros(size(X)),ones(size(X)),zeros(size(X)));
surf(X,Y,Z,cdata);
end

