close all;

 plotnum=length(sum_delta);
 
 if plotnum>6
     plotnum=6;
 end
 
 for pi=1:plotnum
     figure
     subplot(2,3,1)
     hold on
     plot(ori_kap)
     plot(sum_kap{pi},'r');
     hold off
     title('kap');
     
     subplot(2,3,2)
    plot(sum_Va{pi});
    title('Va');
     
     subplot(2,3,3)
     plot(sum_xout{pi}(5,:));
     title('\phi');
     
     subplot(2,3,4)
      hold on
     plot(diff(ori_pos(4,:)));
     plot(diff(sum_pos{pi}(4,:)),'r');
     hold off
     title('ds');
     
     subplot(2,3,5)
     plot(sum_ey{pi});
     title('ey');
     
     subplot(2,3,6)
     plot(sum_delta{pi}./pi.*180);
     title('delta');
     
     s_kap(pi)=sum(abs(sum_kap{pi}));
 end
 
figure
 for pi=1:plotnum
     subplot(2,3,pi)
     regenerate_path(sum_pos{pi},edge,sum_ey{pi})
     
 end
 
 figure
 plot(sum_T_t)
title('Time');

figure
plot(s_kap);
title('sum kap');

figure
plot(sum_opt)
title('opt val')