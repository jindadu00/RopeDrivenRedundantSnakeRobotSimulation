function output = forwardKinematics(theta,bias,flag)
%input：   T:               transformation matrix calculated by 'calT'
%          flag:            1  ->  6D,    0  ->  3D
%output:   output:          The attitude coordinates of the tool

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
    
    P0=T(:,:,24)*[H;0;0;1];
    if flag == 1
        [yaw,pitch,roll] = dcm2angle(T(1:3,1:3,24));
        output=[P0(1:3);yaw;pitch;roll];
    else
        output=P0(1:3);
    end

end

