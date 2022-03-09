function output = Jacob6D2(theta)
output=zeros(6,24);
delta=1e-10;
for i =1:24
    theta(i)=theta(i)+delta;
    f=forwardKinematics6D(theta);
    theta(i)=theta(i)-2*delta;
    b=forwardKinematics6D(theta);
    output(:,i)=f-b;
    theta(i)=theta(i)+delta;
end
output=output/(2*delta);
end