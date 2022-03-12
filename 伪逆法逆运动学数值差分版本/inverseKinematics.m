function output = inverseKinematics(X,tmpTheta,bias)
%input：   X:               target positions
%          tempTheta:       current joint angles
%output:   theta:           output joint angles

sizeX=size(X);
if sizeX(1)==3
    flag=0;
else 
    if sizeX(1)==6
        flag=1;
    else
        disp('error')
    end
end
x=forwardKinematics(tmpTheta,bias,flag);
dX=X-x;

while dX'*dX>=1e-10
    dtheta=rightInvJac(tmpTheta,flag)*dX;
    tmpTheta=tmpTheta+dtheta;
    for i=1:24
        while tmpTheta(i)>pi
            tmpTheta(i)=tmpTheta(i)-2*pi;
        end
        while tmpTheta(i)<-pi
            tmpTheta(i)=tmpTheta(i)+2*pi;
        end
    end
    x=forwardKinematics(tmpTheta,bias,flag);
    dX=X-x;
end

output=tmpTheta;
end

