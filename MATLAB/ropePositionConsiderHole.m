clc;
clear;
close;


theta=ones(12,1)*0.2;
bias=0;
global miniRadius h H radius l numcable
numcable=18;
radius=5;
miniRadius=0.2;
miniN=3;
scatterSize=8;

%[X or Y or Z], 第i个平面，  平面上第j个孔
h=2;  %万向节到下底板的垂直距离
l=9;
H=10;  %两个万向节之间的垂直距离

P=theta2centerList(theta);
hold on
grid on
axis equal
view(15, 15);
axis square;

for i=1:13
    for j=1:numcable
        if isnan(P(1,i,j))
            continue
        end
        scatter3(P(1,i,j),P(2,i,j),P(3,i,j),scatterSize)
        if i==1
        text(P(1,i,j),P(2,i,j),P(3,i,j),num2str(j),'FontSize',7)
        end
    end
end


for i=1:numcable
    N=sum(~isnan(P(1,:,i)));
    P(:,1:N,i)=calMinLP(P(:,:,i),N);
end


for k=1:numcable
    if k<=numcable/3
    plot3(P(1,:,k),P(2,:,k),P(3,:,k),'r')
    elseif k<=numcable/3*2
    plot3(P(1,:,k),P(2,:,k),P(3,:,k),'g')
    else
    plot3(P(1,:,k),P(2,:,k),P(3,:,k),'b')
    end
end


    
drawRobot(theta,bias)
xlabel('x/cm','FontSize',12);
ylabel('y/cm','FontSize',12);
zlabel('z/cm','FontSize',12);

