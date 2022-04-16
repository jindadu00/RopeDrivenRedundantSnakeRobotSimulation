function LJacob = calLJacob(centerList,N,mu)
%计算绳长关于mu的雅可比矩阵，输入为中心的坐标
LJacob=zeros(1,N-2);
delta=1e-10;

for i =1:N-2
    mu(i)=mu(i)+delta;
    f=mu2L(centerList,N,mu);
    mu(i)=mu(i)-2*delta;
    b=mu2L(centerList,N,mu);
    LJacob(1,i)=f-b;
    mu(i)=mu(i)+delta;
end
LJacob=LJacob/(2*delta);
end

