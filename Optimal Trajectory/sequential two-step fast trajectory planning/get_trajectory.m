function [xout,dt,cvx_optval]=get_trajectory(pos,edge,Va,ori_kap)
    
edge_l=-edge(5,:);
edge_r=edge(6,:);
% phi=pos(1,:);
s=pos(4,:);

ds=diff(s);
ds2=ds.^2;
lambda=1;

n=length(s)-1;
% e, dphi,r,beta,phi
cvx_begin
    variables  x(5,n+1) delta(1,n+1)

    dphi=(x(5,2:n+1)-x(5,1:n)).^2;
    ddelta=(delta(2:n+1)-delta(1:n)).^2;
%     dey=abs(x(1,2:n+1)-x(1,1:n));
   
    J=(dphi./ds2)+lambda*ddelta;
    minimize(sum(J));


        
    subject to
        x(:,2:n+1)==car_model2(Va(1:n),ori_kap(1:n),delta,ds,x(:,1))
        edge_l<=x(1,:)<=edge_r
        % constrains
        x(5,1)==0
        
cvx_end

xout=x;
dt=delta;

clear x
clear delta
end