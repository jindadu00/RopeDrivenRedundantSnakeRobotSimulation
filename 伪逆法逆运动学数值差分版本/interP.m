function pout = interP(p1,p2,origin,L)
    % Find a point on the line segment between P1 and P2 that is L away from Origin, where P1, P2 and Origin are (3 × 1) vectors
    % the premise L is between the distance p1 and p2 to origin, respectively
    d1=norm(p1-origin);
    d2=norm(p2-origin);
    if (d1-L)*(d2-L)>0
        disp('error')
    end
    if d1<d2
        left=p1;
        right=p2;
    else
        left=p2;
        right=p1;
    end
    
    pout=(left+right)/2;
    d=norm(pout-origin);
    while abs(d-L)<1e-7
        if d>L
            right=pout;
        else
            left=pout;
        end
        pout=(left+right)/2;
        d=norm(pout-origin);
    end
    
end

