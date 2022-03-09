function output = Jacob3D(theta)
output=zeros(6,24);
delta=1e-10;
b=forwardKinematics3D(theta);
for i =1:24
    theta(i)=theta(i)+delta;
    f=forwardKinematics3D(theta);
    output(:,i)=f-b;
    theta(i)=theta(i)-delta;
end
output=output/(delta);
end


