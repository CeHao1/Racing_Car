% creat a trajectory with least curvature

clc;clear all;
close all;
% pos- phi,X,Y,s
% edge- Xl,Yl,Xr,Yr,wl,wr
interval=1;
 [kap,pos,edge]=initialize_centerline(interval);
 T0=1e10;
 iter=0;
 
 % using sum to contain all variables
 ori_kap=kap; % original kap(centerline curvature)
 ori_pos=pos; % (centerline curvature)
 sum_kap={};
 sum_pos={};
 sum_Va={};
 sum_T_t=[];
 sum_ey={};
 sum_delta={};
 sum_xout={};
 sum_opt=[];
 
   
 
 while  T0==1e10 || deltaT>0.1 || iter<=5
     Va=get_velocity(kap,interval);
     [xout,delta,opt]=get_trajectory(pos,edge,Va,ori_kap);
     ey=xout(1,:); % ey, dphi,r,beta,phi
     pos(1,:)=xout(5,:); %update phi
     [kap_new,s_re,T_t]=get_kapnew(ori_pos,edge,ey,Va,pos);
     pos(4,:)=s_re; %update s
         
     sum_kap=[sum_kap,kap_new];
     sum_pos=[sum_pos,pos];
     sum_Va=[sum_Va,Va];    
     sum_T_t=[sum_T_t,T_t];
     sum_ey=[sum_ey,ey];
     sum_delta=[sum_delta,delta];
     sum_xout=[sum_xout,xout];
     sum_opt=[sum_opt,opt];
     

     iter=iter+1;
     deltaT=T0-T_t;
     T0=T_t;
     kap=kap_new;
 end
     
run plot_fun