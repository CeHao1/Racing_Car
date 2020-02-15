function Va=get_velocity(kap,interval)

mu=1.0; % friction ratio
g=10;


% 1 get maximum velocity
vm=sqrt(mu*g./abs(kap));

% 2 acceleration
%if Vk+1>Vk, accelerate, but no more than the vm
V1=vm(1);
for i=1:length(vm)-1
    if vm(i+1)>V1(i)
        % calculate the remained frction
        a=sqrt((mu*g)^2-(V1(i)^2*kap(i))^2);
        V1(i+1)=min([vm(i+1),sqrt(2*a*interval+V1(i)^2)]);
    else
        V1(i+1)=vm(i+1);
    end

end
V1=abs(V1);

% 3 deceleration
% if Vk>Vk+1, decelerate, but no more than vm
V2(length(vm))=vm(end);
for i= length(vm):-1:2
    if vm(i-1)>V2(i)
        a=sqrt((mu*g)^2-(V2(i)^2*kap(i))^2);
        V2(i-1)=min([vm(i-1),sqrt(2*a*interval+V2(i)^2)]);
    else
        V2(i-1)=vm(i-1);
    end
    
end
V2=abs(V2);

% 4 get the minimal velocity of acceleration and deceleration
Va=min([V1;V2]);



%%
plotflag=0;
if plotflag==1
figure
hold on;
plot(vm,'b');
plot(V1,'r');
plot(V2,'g');
plot(Va,'k','linewidth',2);
xlabel('distance (m)');
ylabel('velocity (m/s)');

hold off;
pause(0.1);
end


end