function output = Jacob(theta,bias,flag)
%input：   T:               transformation matrix calculated by 'calT'
%          flag:            1  ->  6D,    0  ->  3D
%output:   output:          Jacobi matrix calculated by difference method

delta=1e-10;
if flag==1
    output=zeros(6,13);
else
    output=zeros(3,13);
end

for i =1:12
    theta(i)=theta(i)+delta;
    f=forwardKinematics(theta,bias,flag);
    theta(i)=theta(i)-2*delta;
    b=forwardKinematics(theta,bias,flag);
    output(:,i)=f-b;
    theta(i)=theta(i)+delta;
end
bias=bias+delta;
f=forwardKinematics(theta,bias,flag);
bias=bias-2*delta;
b=forwardKinematics(theta,bias,flag);
output(:,13)=f-b;
output=output/(2*delta);
end