function Y=car_model2(Vx,K,delta,ds,x0)
N=length(Vx);
x=cvx(zeros(5,N));

g=10;

m=1500;
Iz=2250;
lf=1.04;
lr=1.42;
Cf=160*1000;
Cr=180*1000;
mu=0.95;
% Ds=1;
Fzf=m*g*lr/(lf+lr);
Fzr=m*g*lf/(lf+lr);
x(:,1)=x0;
%%


for i=1:N

    bta=x(4,i);
    r=x(3,i);
    alpf(i)=bta+(lf*r)/Vx(i)-delta(i);
    alpr(i)=bta-(lr*r)/Vx(i);
 
    alpf_star(i)=atan((3*mu*Fzf)/Cf);
    alpr_star(i)=atan((3*mu*Fzr)/Cr);
    
%    Fyf(i)=-Cf*alpf(i)+Cf^2/(3*mu*Fzf)*abs(alpf(i))*alpf(i)-Cf^3/(27*mu^2*Fzf^2)*alpf(i)^3;
%  
%    Fyr(i)=-Cf*alpr(i)+Cf^2/(3*mu*Fzr)*abs(alpr(i))*alpr(i)-Cf^3/(27*mu^2*Fzr^2)*alpr(i)^3;
    Fyf(i)=-Cf*alpf(i);
 
   Fyr(i)=-Cf*alpr(i);

 
    A=[0, Vx(i), 0, Vx(i), 0;
    0, 0, 1, 0, 0;
    0, 0, -(lf^2*Cf+lr^2*Cr)/(Vx(i)*Iz), (lr*Cr-lf*Cf)/(Iz), 0;
    0, 0,  (lr*Cr-lf*Cf)/(m*Vx(i)^2)-1, -(Cf+Cr)/(m*Vx(i)),0;
    0,0,1,0,0   ];
 
    B=[0,0, lf*Cf/Iz, Cf/(m*Vx(i)),0]';
 
    D=[0, -K(i)*Vx(i), (lf*Cf*alpf(i)-lr*Cr*alpr(i)+lf*Fyf(i)-lr*Fyr(i))/Iz, (Cf*alpf(i)+Cr*alpr(i)+Fyf(i)+Fyr(i))/(m*Vx(i)),0]';
 
    T=ds(i)/Vx(i);
    G=eye(5)+A*T;
    H=B*T;
    Dd=D*T;   
    x(:,i+1)=G*x(:,i)+H*delta(i)+Dd;
   
end

    Y=x(:,2:N+1);

end