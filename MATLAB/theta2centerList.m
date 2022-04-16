function P = theta2centerList(theta)

global h H radius l bias T numcable
T=zeros(4,4,12);
T1 =[cos(theta(1)), -sin(theta(1)), 0, bias;
sin(theta(1)),  cos(theta(1)), 0, 0;
          0,            0, 1, 0;
          0,            0, 0, 1];
T(:,:,1)=T1;
T2 =[ cos(theta(2)), -sin(theta(2)), 0, 0;
           0,            0, 1, 0;
-sin(theta(2)), -cos(theta(2)), 0, 0;
           0,            0, 0, 1];
T(:,:,2)=T(:,:,1)*T2;
for i =1:5
    T(:,:,i*2+1)=T(:,:,i*2)*...
    [cos(theta(i*2+1)), -sin(theta(i*2+1)),  0, H;
          0,            0, -1, 0;
    sin(theta(i*2+1)),  cos(theta(i*2+1)),  0, 0;
          0,            0,  0, 1];

    T(:,:,i*2+2)=T(:,:,i*2+1)*...
    [cos(theta(i*2+2)), -sin(theta(i*2+2)),  0, 0;
          0,            0, 1, 0;
    -sin(theta(i*2+2)),  -cos(theta(i*2+2)),  0, 0;
          0,            0,  0, 1];
end

P=zeros(3,13,numcable);
P(:,:,:)=NaN;

for i=1:numcable
    p0=[0;radius*cos(2*i*pi/numcable);radius*sin(2*i*pi/numcable);1];

    T0=[1,0,0,-h;
        0,1,0,0;
        0,0,1,0;
        0,0,0,1];
    p=T0*p0;
    P(:,1,i)=p(1:3);
end

for i=1:numcable
    p0=[-l;radius*cos(2*i*pi/numcable);radius*sin(2*i*pi/numcable);1];
    T3=[1, 0,  0, H;
        0, 0, -1, 0;
        0, 1,  0, 0;
        0, 0,  0, 1];
    p=T(:,:,2)*T3*p0;
    P(:,2,i)=p(1:3);
end

for k=2:6
    for i=1:numcable
        if mod(i-1,6)<=6-k+1
            p0=[0;-radius*sin(2*i*pi/numcable);radius*cos(2*i*pi/numcable);1];
            T0=[1,0,0,H-h;
                0,1,0,0;
                0,0,1,0;
                0,0,0,1];
            p=T(:,:,2*k-2)*T0*p0;
            P(:,k*2-1,i)=p(1:3);
        end
    end

    for i=1:numcable
        if mod(i-1,6)<=6-k
        p0=[-l;radius*cos(2*i*pi/numcable);radius*sin(2*i*pi/numcable);1];
        T3=[1, 0,  0, H;
            0, 0, -1, 0;
            0, 1,  0, 0;
            0, 0,  0, 1];
        p=T(:,:,2*k)*T3*p0;
        P(:,k*2,i)=p(1:3);
        end
    end
end

for i=1:numcable
    if mod(i-1,6)<=6-k
        p0=[0;-radius*sin(2*i*pi/numcable);radius*cos(2*i*pi/numcable);1];
        T0=[1,0,0,H-h;
            0,1,0,0;
            0,0,1,0;
            0,0,0,1];
        p=T(:,:,12)*T0*p0;
        P(:,13,i)=p(1:3);
    end
end
end

