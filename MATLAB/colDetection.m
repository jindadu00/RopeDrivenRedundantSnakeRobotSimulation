function flag = colDetection(theta,bias,wallsInfo)
%input：   T:               transformation matrix calculated by 'calT'
%output:   wallsInfo:       obstacles' information

% Determines whether a collision occurred
% Considering the radius of the manipulator, Lagrange multiplier method is used to solve the extreme value

% Line function
% x-x_0=t n_x
% y-y_0=t n_y
% z-z_0=t n_z
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
    
    for i = 1:24
        vec=T(1:3,1,i);
        p0=T(1:3,4,i);
        p1=p0+T(1:3,1:3,i)*[H;0;0];
        if vec(1)==0 && mod(i,2)==0
            continue
        end
        for j=1:length(wallsInfo)
%           Detect collision with front wall
            if (p0(1)-wallsInfo(j).front)*(p1(1)-wallsInfo(j).front)<=0
                t=(wallsInfo(j).front-p0(1))/vec(1);
                y=t*vec(2)+p0(2);
                z=t*vec(3)+p0(3);
                if (y-wallsInfo(j).center(1))^2+(z-wallsInfo(j).center(2))^2>=wallsInfo(j).radius^2
                    flag=flag+1;
                    break
                end
            end
%           Detect collision with rear wall
            if (p0(1)-wallsInfo(j).back)*(p1(1)-wallsInfo(j).back)<=0
                t=(wallsInfo(j).back-p0(1))/vec(1);
                y=t*vec(2)+p0(2);
                z=t*vec(3)+p0(3);
                if (y-wallsInfo(j).center(1))^2+(z-wallsInfo(j).center(2))^2>=wallsInfo(j).radius^2
                    flag=flag+1;
                    break
                end
            end
        end
    end
end

