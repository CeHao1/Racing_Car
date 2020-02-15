function [kap,pos,edge]=initialize_centerline(interval)
% interval=1;
if nargin==0
    interval=1;
    plotflag=1;
else
    plotflag=0;
end
% kap=0;
% 
% kap=[kap,ones(1,length(0:interval:800-interval))*0];
% kap=[kap,(0:interval:200-interval)*pi/(1000*200)];
% kap=[kap,ones(1,length(0:interval:800-interval))*pi/(1000)];
% kap=[kap,(200-interval:-interval:0)*pi/(1000*200)];
% kap=[kap,ones(1,length(0:interval:800-interval))*0];
% kap=[kap,(0:interval:200-interval)*pi/(1000*200)];
% kap=[kap,ones(1,length(0:interval:800-interval))*pi/(1000)];
% kap=[kap,(200-interval:-interval:0)*pi/(1000*200)];


% kap=kap(700:1300);


%%
% kap=0;
% 
% straight=500;
% turning=200;
% for i=1:4
%     kap=[kap,ones(1,length(0:interval:straight-interval))*0];
%     kap=[kap,ones(1,length(0:interval:turning-interval))*pi/(turning*2)];
% 
% end
% kap=kap(450:750);

%% 
kap=0;
kap=[kap,ones(1,length(0:interval:100-interval))*0];
kap=[kap,ones(1,length(0:interval:100-interval))*pi/(100*2)];
kap=[kap,ones(1,length(0:interval:100-interval))*0];

%%

s=0:interval:(length(kap)-1)*interval;

wl=ones(1,length(kap))*7.5;
wr=ones(1,length(kap))*7.5;

%% 
phi=0;
X=0;
Y=0;
Xl=X-wl(1)*sin(phi);
Yl=Y+wl(1)*cos(phi);
Xr=X+wr(1)*sin(phi);
Yr=Y-wr(1)*cos(phi);


for i=1:length(kap)-1
    phi(i+1)=phi(i)+interval*kap(i);
    X(i+1)=X(i)+interval*cos(phi(i));
    Y(i+1)=Y(i)+interval*sin(phi(i));
    Xl(i+1)=X(i+1)-wl(i+1)*sin(phi(i+1));
    Yl(i+1)=Y(i+1)+wl(i+1)*cos(phi(i+1));
    Xr(i+1)=X(i+1)+wr(i+1)*sin(phi(i+1));
    Yr(i+1)=Y(i+1)-wr(i+1)*cos(phi(i+1));
    
    
end

pos=[phi;X;Y;s];
edge=[Xl;Yl;Xr;Yr;wl;wr];

if plotflag==1
    figure
    hold on
    plot(X,Y,'b');
    plot(Xl,Yl,'r');
    plot(Xr,Yr,'g');
    plot(X(1),Y(1),'ro');

    axis equal
end

end