function theta = P2Theta(P)
%input：   P:               the 3d matrix and size is (13,3,t)
%output:   theta:           two-dimensional matrix size is (24,t)


    sizeOfP=size(P);
    theta=zeros(24,sizeOfP(3));

    for j=1:sizeOfP(3)
        R=eye(3);
        for i=1:sizeOfP(1)-1
            vector=reshape(P(i+1,:,j)-P(i,:,j),[3,1]);
            vector=R*vector/norm(vector);
            yi=vector(2);
            zi=vector(3);
            if i==1
                beta=asin(-zi);
                if cos(beta)==0
                    alpha=0;
                else
                    alpha=asin(yi/cos(beta));
                end
                R=[ cos(alpha)*cos(beta),  cos(beta)*sin(alpha), -sin(beta);
                    -cos(alpha)*sin(beta), -sin(alpha)*sin(beta), -cos(beta);
                             -sin(alpha),            cos(alpha),          0]*R;
            else
                beta=asin(yi);
                if cos(beta)==0
                    alpha=0;
                else
                    alpha=asin(zi/cos(beta));
                end
                R=[ cos(alpha)*cos(beta), sin(beta),  cos(beta)*sin(alpha);
                   -cos(alpha)*sin(beta), cos(beta), -sin(alpha)*sin(beta);
                            -sin(alpha),         0,            cos(alpha)]*R;
            end
            theta(2*i-1,j)=alpha;
            theta(2*i,j)=beta;
        end
    end
end

