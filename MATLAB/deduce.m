% This file is my scratch paper for deducting formulas

clc;
clear;

syms h alpha1 alpha2 alpha h theta

a=0;
% alpha=-pi/2;
% theta=0;
d=0;
T=[cos(theta),             -sin(theta),           0,            a;
    sin(theta)*cos(alpha), cos(theta)*cos(alpha), -sin(alpha),  -sin(alpha)*d;
    sin(theta)*sin(alpha), cos(theta)*sin(alpha), cos(alpha),   cos(alpha)*d;
    0,                     0,                     0,             1];
T=subs(T,alpha,-pi/2)

% syms bias theta1
% T0=[1,0,0,bias;
%     0,1,0,0;
%     0,0,1,0
%     0,0,0,1];
% T1 =[cos(theta1), -sin(theta1), 0, 0;
% sin(theta1),  cos(theta1), 0, 0;
%           0,            0, 1, 0;
%           0,            0, 0, 1];
% T=T0*T1

% syms H alpha beta
% 
% T1 =[cos(alpha), -sin(alpha), 0, 0;
% sin(alpha),  cos(alpha), 0, 0;
%           0,            0, 1, 0;
%           0,            0, 0, 1];
%  
%  
% T2 =[ cos(beta), -sin(beta), 0, 0;
%            0,            0, 1, 0;
% -sin(beta), -cos(beta), 0, 0;
%            0,            0, 0, 1];
%        
% R1=T1*T2;
% R1=R1(1:3,1:3)
% 
% 
% T1 =[cos(alpha), -sin(alpha),  0, H;
%           0,            0, -1, 0;
% sin(alpha),  cos(alpha),  0, 0;
%           0,            0,  0, 1];
%  
%  
% T2 =[ cos(beta), -sin(beta), 0, 0;
%            0,            0, 1, 0;
% -sin(beta), -cos(beta), 0, 0;
%            0,            0, 0, 1];
%        
% R2=T1*T2;
% R2=R2(1:3,1:3)
% syms x y z x0 y0 z0 X Y Z lamda a b c r val
% g=(c*(y-y0)-b*(z-z0))^2+(a*(z-z0)-c*(x-x0))^2+(b*(x-x0)-a*(y-y0))^2-r^2*(a^2+b^2+c^2);
% g = subs(g,x,val);
% f=(y-Y)^2+(z-Z)^2+lamda*(g);
% eqn1=diff(f,y)==0;
% eqn2=diff(f,z)==0;
% eqn3=f==0;
% lamda1=solve(eqn1,lamda);
% lamda2=solve(eqn2,lamda);
% zresult=simplify(solve(lamda1==lamda2,z));
% zresult=zresult(1);
% g=subs(z,zresult);
% yresult=simplify(solve(g==0,y));
% yresult=yresult(1);

% syms y z lamda
% Y=-1;
% Z=5.5;
% g=y^2+4*z^2-4;
% f=(y-Y)^2+(z-Z)^2+lamda*(g);
% eqn1=diff(f,y)==0;
% eqn2=diff(f,z)==0;
% eqn3=diff(f,lamda)==0;
% S=solve([eqn1,eqn2,eqn3],[y,z,lamda]);
% for i =1:4
%     y=S.y(i);
%     z=S.z(i);
%     distance=double((y-Y)^2+(z-Z)^2)
%     isreal(distance)
% end

% lamda1=solve(eqn1,lamda);
% lamda2=solve(eqn2,lamda);
% zresult=simplify(solve(lamda1==lamda2,z));
% zresult=zresult(1);
% g=subs(z,zresult);
% yresult=simplify(solve(g==0,y));
% yresult=yresult(1);

