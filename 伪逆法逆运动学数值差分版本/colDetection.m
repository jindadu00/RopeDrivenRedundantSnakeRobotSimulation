function [flag] = colDetection(theta,wallsInfo)
% 判断是否发生碰撞
% 直线方程
% x-x_0=t n_x
% y-y_0=t n_y
% z-z_0=t n_z
    global H
    flag=0;
    T=zeros(4,4,24);

    T1 =[cos(theta(1)), -sin(theta(1)), 0, 0;
    sin(theta(1)),  cos(theta(1)), 0, 0;
              0,            0, 1, 0;
              0,            0, 0, 1];
    T(:,:,1)=T1;

    T2 =[ cos(theta(2)), -sin(theta(2)), 0, 0;
               0,            0, 1, 0;
    -sin(theta(2)), -cos(theta(2)), 0, 0;
               0,            0, 0, 1];

    T(:,:,2)=T1*T2;

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

    for i = 1:24
        vec=T(1:3,1,i);
        p0=T(1:3,4,i);
        p1=p0+T(1:3,1:3,i)*[H;0;0];
        if vec(1)==0
            continue
        end
        for j=1:length(wallsInfo)
%           检测是否与前壁碰撞
            if (p0(1)-wallsInfo(j).front)*(p0(1)+p1(1)-wallsInfo(j).front)<=0
                t=(wallsInfo(j).front-p0(1))/vec(1);
                y=t*vec(2)+p0(2);
                z=t*vec(3)+p0(3);
                if (y-wallsInfo(j).center(1))^2+(z-wallsInfo(j).center(2))^2>=wallsInfo(j).radius^2
                    flag=1;
                    break
                end
            end


            
%           检测是否与后壁碰撞
            if (p0(1)-wallsInfo(j).back)*(p0(1)+p1(1)-wallsInfo(j).back)<=0
                t=(wallsInfo(j).back-p0(1))/vec(1);
                y=t*vec(2)+p0(2);
                z=t*vec(3)+p0(3);
                if (y-wallsInfo(j).center(1))^2+(z-wallsInfo(j).center(2))^2>=wallsInfo(j).radius^2
                    flag=1;
                    break
                end
            end
        end
    end

end

