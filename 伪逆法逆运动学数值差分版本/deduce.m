% 这个文件是我用来推公式的草稿纸23333

clc;
clear;
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

syms y z lamda
Y=-1;
Z=5.5;
g=y^2+4*z^2-4;
f=(y-Y)^2+(z-Z)^2+lamda*(g);
eqn1=diff(f,y)==0;
eqn2=diff(f,z)==0;
eqn3=diff(f,lamda)==0;
S=solve([eqn1,eqn2,eqn3],[y,z,lamda]);
for i =1:4
    y=S.y(i);
    z=S.z(i);
    distance=double((y-Y)^2+(z-Z)^2)
    isreal(distance)
end

% lamda1=solve(eqn1,lamda);
% lamda2=solve(eqn2,lamda);
% zresult=simplify(solve(lamda1==lamda2,z));
% zresult=zresult(1);
% g=subs(z,zresult);
% yresult=simplify(solve(g==0,y));
% yresult=yresult(1);

