function   [kap_new,s_re,T_t]=get_kapnew(ori_pos,edge,ey,Va,pos)

phi=ori_pos(1,:);
X=ori_pos(2,:);
Y=ori_pos(3,:);
s=ori_pos(4,:);
Xl=edge(1,:);
Yl=edge(2,:);
Xr=edge(3,:);
Yr=edge(4,:);

dphi=diff(pos(1,:));

s_re=0;
for i=1:length(s)

    X_re(i)=X(i)-ey(i)*sin(phi(i));
    Y_re(i)=Y(i)+ey(i)*cos(phi(i));
    
end

for i=1:length(s)-1
    s_re(i+1)=s_re(i)+norm([(X_re(i+1)-X_re(i)),(Y_re(i+1)-Y_re(i))]);
    
end

sum_t=diff(s_re)./Va(1:end-1);
T_t=sum(sum_t);

ds=diff(s_re);
kap_new=dphi./ds;
kap_new=[kap_new,kap_new(end)];

end