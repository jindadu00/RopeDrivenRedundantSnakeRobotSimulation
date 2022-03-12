function T = calT(theta,bias)
%input：   theta:           joint angles
%          bias:            base bias
%output:   T:               output transformation matrix
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
end

