function [Ca,Iz]=get_CaIz(ay,d2psi,alpf,alpr)
% This function calculates the lateral stiffness Ca of tire and yaw moment of
% inertia Iz. The function require the lateral acceleration ax, angluar acceleration d2psi 
% and lateral velocity Vy. The slip angle of front and rear wheel is  derived by former function get_alp

% Author: Ce Hao
% Data: 2020/02/15
% Notice: the solver is based on CVX (matlab): http://cvxr.com/cvx/

%Notation
    % input:
        % ay: lateral acceleratoin
        % d2psi: angular acceleration
        % alpf: slip angle of front wheel (alpha_f)
        % alpr: slip angle of rear wheel (alpha_r)
    % parameters:
        % Ca: lateral stiffness of tire
        % Iz: yaw moment of inertia
        % m: mass of vehicle
    
%% get Ca
cvx_begin
    variable Ca
    J=ay*m/2-Ca*(alpf+alpr)
    minimize(norm(J))
cvx_end 
        
 figure
hold on
plot((alpf+alpr),ay*m/2,'b.')
plot((alpf+alpr),(alpf+alpr)*C,'k','linewidth',1.5)
hold off
title(strcat('C_\alpha : ',num2str(C)),'fontsize',15)
xlabel('\alpha','fontsize',15)
ylabel('Fy','fontsize',15)       
 
%% get Iz
xx=2*d2psi/2;
yy=C*L*(alpf-alpr)-ay*m*(lr-lf)/2;
 
cvx_begin
    variable Iz
    J2=xx*Iz-yy
    minimize(norm(J2))
cvx_end
 
figure
hold on
plot(xx,yy,'b.')
plot(xx,xx*Iz,'r','linewidth',2)
hold off
title(strcat('Iz :',num2str(Iz)),'fontsize',15)
xlabel('$\ddot \psi $','Interpreter','latex','fontsize',15) 
ylabel('M','fontsize',15)


end
