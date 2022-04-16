function [theta,bias] = inverseKinematics(X,tmpTheta,tmpBias)
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
x=forwardKinematics(tmpTheta,tmpBias,flag);
dX=X-x;

while dX'*dX>=1e-10
    dq=rightInvJac(tmpTheta,tmpBias,flag)*dX;
    tmpTheta=tmpTheta+dq(1:12);
    tmpBias=tmpBias+dq(13);
    for i=1:12
        while tmpTheta(i)>pi
            tmpTheta(i)=tmpTheta(i)-2*pi;
        end
        while tmpTheta(i)<-pi
            tmpTheta(i)=tmpTheta(i)+2*pi;
        end
    end
    x=forwardKinematics(tmpTheta,tmpBias,flag);
    dX=X-x;
end

theta=tmpTheta;
bias=tmpBias;
end

