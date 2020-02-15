function regenerate_path(pos,edge,ey)

phi=pos(1,:);
X=pos(2,:);
Y=pos(3,:);
Xl=edge(1,:);
Yl=edge(2,:);
Xr=edge(3,:);
Yr=edge(4,:);

s=pos(4,:);

for i=1:length(s)-1

    X_re(i)=X(i)-ey(i)*sin(phi(i));
    Y_re(i)=Y(i)+ey(i)*cos(phi(i));

end



hold on
plot(X,Y,'b');
plot(Xl,Yl,'r');
plot(Xr,Yr,'g');
plot(X(1),Y(1),'ro');
plot(X_re,Y_re,'k','linewidth',2);
axis equal
title('track');

end