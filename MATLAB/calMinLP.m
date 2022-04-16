function output = calMinLP(centerList,N)
    %输入一条绳上圆心P的坐标序列，除了第一个和最后一个点重合外，
    %其他的点分布在各自以该点为圆心的圆上，坐标为mu(i),
    %找到mu的组合使得点以此连接的长度最小
    e=1e-5;
    mu=zeros(N-2,1);

    J=calLJacob(centerList,N,mu);
    JNorm=norm(J);
    lastJNorm=inf;
    i=0;
    while lastJNorm-JNorm>e
        i=i+1;
        alpha=0.01+exp(-i*0.01);
        lastJNorm=JNorm;
        mu=mu-J*alpha;
        J=calLJacob(centerList,N,mu);
        JNorm=norm(J);
    end
    hold on
    PList=mu2P(centerList,N,mu);
    output=PList;
end

