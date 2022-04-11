function lenth = theta2Lenth(theta)
    %UNTITLED 此处显示有关此函数的摘要
    %   此处显示详细说明

    h=0.01;
    d=0.11;
    L=0.1;
    r=0.016;
    sizeofTheta=size(theta);
    t=sizeofTheta(2);
    lenth=zeros(36,t);
    for j=1:t
        for i=1:12
            alpha1=theta(i*2-1,j);
            alpha2=theta(i*2,j);
            T0=[cos(alpha1), -sin(alpha1), 0, 0;
                sin(alpha1),  cos(alpha1), 0, 0;
                          0,            0, 1, 0;
                          0,            0, 0, 1];
            T1=[cos(alpha2), -sin(alpha2),  0, 0;
                              0,            0,  1, 0;
                   -sin(alpha2), -cos(alpha2),  0, 0;
                              0,            0,  0, 1];
            T2=[1, 0,  0, d;
                0, 0, -1, 0;
                0, 1,  0, 0;
                0, 0,  0, 1];

            T= [1, 0,  0, h;
                0, 1,  0, 0;
                0, 0,  1, 0;
                0, 0,  0, 1];

            T=T*T0*T1*T2;
            for k=i:12
                phi=pi/18*k;
                r1=[-L;r*cos(phi);r*sin(phi)];
                l1=T*[r1;1]-[r1+[L;0;0];1];
                r2=[-L;r*cos(phi+pi*2/3);r*sin(phi+pi*2/3)];
                l2=T*[r2;1]-[r2+[L;0;0];1];
                r3=[-L;r*cos(phi+pi*4/3);r*sin(phi+pi*4/3)];
                l3=T*[r3;1]-[r3+[L;0;0];1];
                lenth(k,j)=lenth(k,j)+norm(l1(1:3));
                lenth(k+12,j)=lenth(k+12,j)+norm(l2(1:3));
                lenth(k+24,j)=lenth(k+24,j)+norm(l3(1:3));
            end
        end
    end
end