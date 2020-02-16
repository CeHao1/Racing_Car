function [alpf,alpr]=get_alp(Vy,dpsi)
% This function calculates the slip angle of front and rear wheel based on
% lateral velocity and angular velocity. Besides, the position of center of
% gravity (CoG) is necessary to calculate the slip angle

% Author: Ce Hao
% Data: 2020/02/15

% Notation
    % input:
        %Vy: lateral velocity
        % dpsi: angular velocity
        
    % parameters:
        % lf: distance from CoG to front wheel
        % lr: distance from CoG to rear wheel
        % width: width of the vehicle between left and right wheel
        
    % variables:
        %alpf: slip angle of front wheel (alpha_f)
        %alpr: slip angle of rear wheel (alpha_r)

%% get alpha
r2d=180/pi; % radian to degree

alp(:,1)=steer+atan2((Vy+lf*dpsi),(Vx-0.5*width*dpsi));
alp(:,2)=steer+atan2((Vy+lf*dpsi),(Vx+0.5*width*dpsi));

alp(:,3)=atan2((Vy-lf*dpsi),(Vx-0.5*width*dpsi));
alp(:,4)=atan2((Vy-lf*dpsi),(Vx+0.5*width*dpsi));
alpf=(alp(:,1)+alp(:,2))/2;
alpr=(alp(:,3)+alp(:,4))/2;

figure
subplot(211)
hold on
plot(saf*r2d,'b')
plot((alp(:,1)+alp(:,2))/2*r2d,'r');
hold off
ylabel('degree','fontsize',15)
title('combined front wheel','fontsize',15)

subplot(212)
hold on
plot(sar*r2d,'b')
plot((alp(:,3)+alp(:,4))/2*r2d,'r');
hold off
ylabel('degree','fontsize',15)
title('combined rear wheel','fontsize',15)



end