function output = JacobVector6D(T)
%input：   T:               transformation matrix calculated by 'calT'
%output:   output:          The Jacobian calculated by the vector product method
    output=zeros(6,24);
    global H

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
    P0=P0(1:3);
    for i = 1:24
        zi=T(1:3,3,i);
        pni=P0-T(1:3,4,i);
        output(1:3,i)=cross(zi,pni);
        output(4:6,i)=zi;
    end
end


