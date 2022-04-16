function L = mu2L(centerList,N,mu)

%输入mu给出一次相连的长度
    L=0;
    P=mu2P(centerList,N,mu);
    for i=1:N-1
        r=P(:,i+1)-P(:,i);
        L=L+norm(r);
    end
end

