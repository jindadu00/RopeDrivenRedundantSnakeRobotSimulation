clc;
clear;
close;
load data.txt;

N = 12; %臂体数量
N_static = 0; %不动臂体数量
t_back = 5; %回到原点的时刻
t_span = 10; %时间历程
t_step = t_span/100;
angle = 10; %关节角度幅值
T_bar = 100; %拉力控制
E = 2.6e10;
A = 2.25e-6;
epson = T_bar/(E*A);

t = 0:t_span/99:t_span; 

theta=zeros(36,100);
for i=1:36
    if mod(i,2)==1
        theta(i,:)=sin(t/t_back*pi) * angle /180 * pi;
    end
end
theta(1,:)=0;
theta(2,:)=0;
theta(13,:)=0;
theta(14,:)=0;
theta(25,:)=0;
theta(26,:)=0;
% global H
% H=10;
% for j=1:100
%     p=theta(:,j);
%     drawRobot(p,0);
%     plot(1,1)
% end
ds=theta2Lenth(theta)

