function PList = mu2P(centerList,N,mu)
%输入圆上的位置，输出P的坐标序列
    global T miniRadius
    PList=zeros(3,N);
    PList(:,1)=centerList(:,1);
    
    for i=2:N-1
        p0=[0;miniRadius*cos(mu(i-1));miniRadius*sin(mu(i-1))];
        PList(:,i)=T(1:3,1:3,2*floor(i/2))*p0+centerList(:,i);
    end
    PList(:,N)=centerList(:,N);
end

