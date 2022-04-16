clc;
clear;
close;

numcable=18;
theta=ones(12,1)*0.2;
radius=5;
scatterSize=3;
P=zeros(3,13,numcable);
P(:,:,:)=NaN;
%[X or Y or Z], 第i个平面，  平面上第j个孔
h=2;  %万向节到下底板的垂直距离
l=9;
H=10;  %两个万向节之间的垂直距离
bias=0;
hold on
grid on
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


for i=1:numcable
    circle=[0;radius*cos(2*i*pi/numcable);radius*sin(2*i*pi/numcable);1];
    T0=[1,0,0,-h;
        0,1,0,0;
        0,0,1,0;
        0,0,0,1];
    p=T0*circle;
    P(:,1,i)=p(1:3);
    scatter3(P(1,1,i),P(2,1,i),P(3,1,i),scatterSize)
    text(P(1,1,i),P(2,1,i),P(3,1,i),num2str(i),'FontSize',8)
end

for i=1:numcable
    p0=[-l;radius*cos(2*i*pi/numcable);radius*sin(2*i*pi/numcable);1];
    T1=[cos(theta(1)), -sin(theta(1)), 0, 0;
        sin(theta(1)),  cos(theta(1)), 0, 0;
        0,           0, 1, 0;
        0,           0, 0, 1];
    T2=[ cos(theta(2)), -sin(theta(2)), 0, 0;
        0,           0, 1, 0;
        -sin(theta(2)), -cos(theta(2)), 0, 0;
        0,           0, 0, 1];
    T3=[1, 0,  0, H;
        0, 0, -1, 0;
        0, 1,  0, 0;
        0, 0,  0, 1];
    p=T1*T2*T3*p0;
    P(:,2,i)=p(1:3);
    scatter3(P(1,2,i),P(2,2,i),P(3,2,i),scatterSize)
end

for k=2:6
    for i=1:numcable
        if mod(i-1,6)<=6-k+1
        p0=[0;-radius*sin(2*i*pi/numcable);radius*cos(2*i*pi/numcable);1];
        T0=[1,0,0,H-h;
            0,1,0,0;
            0,0,1,0;
            0,0,0,1];
        p=T(:,:,2*k-2)*T0*p0;
        P(:,k*2-1,i)=p(1:3);
        scatter3(p(1),p(2),p(3),scatterSize)
        end
    end

    for i=1:numcable
        if mod(i-1,6)<=6-k

        p0=[-l;radius*cos(2*i*pi/numcable);radius*sin(2*i*pi/numcable);1];
        T3=[1, 0,  0, H;
            0, 0, -1, 0;
            0, 1,  0, 0;
            0, 0,  0, 1];
        p=T(:,:,2*k)*T3*p0;
        P(:,k*2,i)=p(1:3);
        scatter3(p(1),p(2),p(3),scatterSize)
        end
    end
end

for i=1:numcable
            if mod(i-1,6)<=6-k

    p0=[0;-radius*sin(2*i*pi/numcable);radius*cos(2*i*pi/numcable);1];
    T0=[1,0,0,H-h;
        0,1,0,0;
        0,0,1,0;
        0,0,0,1];
    p=T(:,:,12)*T0*p0;
    P(:,13,i)=p(1:3);
    scatter3(p(1),p(2),p(3),scatterSize)
            end
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
xlabel('x/cm','FontSize',12);
ylabel('y/cm','FontSize',12);
zlabel('z/cm','FontSize',12);
axis equal


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

cylinder3(r0,r3,radius,10,'r',0,0);
cylinder3(r3,r5,radius,10,'b',0,0);
cylinder3(r5,r7,radius,10,'r',0,0);
cylinder3(r7,r9,radius,10,'b',0,0);
cylinder3(r9,r11,radius,10,'r',0,0);
cylinder3(r11,r13,radius,10,'b',0,0);
cylinder3(baseL,baseR,10,20,'g',0,0);
