function output = Jacob(theta,flag)
%input：   T:               transformation matrix calculated by 'calT'
%          flag:            1  ->  6D,    0  ->  3D
%output:   output:          Jacobi matrix calculated by difference method

delta=1e-10;
if flag==1
    output=zeros(6,24);
else
    output=zeros(3,24);
end

for i =1:24
    theta(i)=theta(i)+delta;
    f=forwardKinematics(theta,0,flag);
    theta(i)=theta(i)-2*delta;
    b=forwardKinematics(theta,0,flag);
    output(:,i)=f-b;
    theta(i)=theta(i)+delta;
end
output=output/(2*delta);
end