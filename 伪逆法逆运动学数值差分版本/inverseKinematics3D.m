function output = inverseKinematics3D(X,tempTheta)
%输入：目标位姿X，目前的关节角tempTheta，允许的误差error
%输出：解出来的关节角theta

x=forwardKinematics3D(tempTheta);
dX=X-x;

while dX'*dX>=1e-10
    dtheta=rightInvJac3D(tempTheta)*dX;
    tempTheta=tempTheta+dtheta;
    for i=1:24
        while tempTheta(i)>pi
            tempTheta(i)=tempTheta(i)-pi;
        end
        while tempTheta(i)<-pi
            tempTheta(i)=tempTheta(i)+pi;
        end
    end
    
    x=forwardKinematics3D(tempTheta);
    dX=X-x;
end

output=tempTheta;
end

