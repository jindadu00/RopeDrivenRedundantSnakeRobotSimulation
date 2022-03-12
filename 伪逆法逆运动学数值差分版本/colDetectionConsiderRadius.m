function [flag] = colDetectionConsiderRadius(theta,bias,wallsInfo)
%input：   T:               transformation matrix calculated by 'calT'
%output:   wallsInfo:       obstacles' information

% Determines whether a collision occurred
% Considering the radius of the manipulator, Lagrange multiplier method is used to solve the extreme value
    global robotRadius
    global H
    T=zeros(4,4,24);
    

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

    for i =1:11
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
    flag=0;
%     robotRadius=2;

    for i = 1:24
        vec=T(1:3,1,i);
        p0=T(1:3,4,i);
        p1=p0+T(1:3,1:3,i)*[H;0;0];
        if vec(1)==0
            continue
        end
        for j=1:length(wallsInfo)
%           Detect collision with front wall
            x=wallsInfo(j).front;
            if (p0(1)-x)*(p0(1)+p1(1)-x)<=0
                syms y z lamda
                g=(vec(3)*(y-p0(2))-vec(2)*(z-p0(3)))^2+(vec(1)*(z-p0(3))-vec(3)*(x-p0(1)))^2+(vec(2)*(x-p0(1))-vec(1)*(y-p0(2)))^2-robotRadius^2;
                f=(y-wallsInfo(j).center(1))^2+(z-wallsInfo(j).center(2))^2+lamda*(g);
                eqn1=diff(f,y)==0;
                eqn2=diff(f,z)==0;
                eqn3=diff(f,lamda)==0;
                S=solve([eqn1,eqn2,eqn3],[y,z,lamda]);
                distance=-1;
                for k =1:4
                    y=S.y(k);
                    z=S.z(k);
                    t=double((y-wallsInfo(j).center(1))^2+(z-wallsInfo(j).center(2))^2);
                    if isreal(distance) && t>distance
                        distance=t;
                    end
                end
                if distance>=wallsInfo(j).radius^2
                    flag=1;
                    break
                end
            end

%           Detect collision with rear wall
            x=wallsInfo(j).back;
            if (p0(1)-x)*(p0(1)+p1(1)-x)<=0
                syms y z lamda
                g=(vec(3)*(y-p0(2))-vec(2)*(z-p0(3)))^2+(vec(1)*(z-p0(3))-vec(3)*(x-p0(1)))^2+(vec(2)*(x-p0(1))-vec(1)*(y-p0(2)))^2-robotRadius^2;
                f=(y-wallsInfo(j).center(1))^2+(z-wallsInfo(j).center(2))^2+lamda*(g);
                eqn1=diff(f,y)==0;
                eqn2=diff(f,z)==0;
                eqn3=diff(f,lamda)==0;
                S=solve([eqn1,eqn2,eqn3],[y,z,lamda]);
                distance=-1;
                for k =1:4
                    y=S.y(k);
                    z=S.z(k);
                    t=double((y-wallsInfo(j).center(1))^2+(z-wallsInfo(j).center(2))^2);
                    if isreal(distance) && t>distance
                        distance=t;
                    end
                end
                if distance>=wallsInfo(j).radius^2
                    flag=1;
                    break
                end
            end
        end
    end
end

