clear all; close all; clc;
%% Wrist
tspan=[0,1]; %Time Span
wr0=[0;0]; %initial Conditions
torque=0.40; %Input from motor Nm

m_hand=0.5; % kg
g=9.81; % m/s^2
l_hand=0.15; % meters length of hand
w_hand=0.10; % meters width of hand

[t_wrist,wrist]=ode45(@(t,y) wristFunc(t,y,torque,m_hand,l_hand,w_hand,g),tspan,wr0);
figure(1)
subplot(1,2,1); plot(t_wrist,wrist(:,1)); grid on; 
xlabel('Time (sec)'); ylabel('\theta (rad)');
title('\theta v.s Time Body Frame');

subplot(1,2,2); plot(t_wrist,wrist(:,2)); grid on; 
xlabel('Time (sec)'); ylabel('\theta/s (rad)');
title('\theta/s v.s Time Body Frame');
%% Wrist Animation
scale=100;
figure(2);
for n=1:length(wrist)
   x=l_hand*cos(wrist(n,1));
   y=l_hand*sin(wrist(n,1));
   plot(0,0,'k.','MarkerSize',10); hold on; grid on;
   plot(x/2,y/2,'kh','MarkerSize',10);
   plot([0,x],[0,y],'k'); hold off;
   %plot(t_wrist(n),wrist(n,1),'kh'); grid on; 
   xlim([(-max(wrist(:,1))-2.5)/scale,(max(wrist(:,1))+2.5)/scale]); 
   ylim([(-max(wrist(:,1))-2.5)/scale,(max(wrist(:,1))+2.5)/scale]);
   pause(0.2);
end
title('Wrist Actuation Body Frame');

%% Forearm Rotation
% l_forearm=7.5e-2;  %Length of half the forearm in meters
% r_forearm=7.62e-2; %Radius of the forearm in meters
% t_span=[0,1];      %Time of the simulation (sec)
% init=[0,0,0,0];    %Initial Conditions of each state
% torque=[0.4,0.4];  %The amount of torque input (Nm)
% m_forearm=0.5;     %Mass of the forearm (Kg)
% I=ones(2,1);
% I(1)=m_hand*(l_hand^2)/3+m_hand*(w_hand^2)/12; %Inertia of the hand
% I(2)=I(1)+m_forearm*r_forearm^2;               %Inertia of the hand and forearm
% 
% [t_sim, states]=ode45(@(t,y) forearmFunc(t,y,I,m_hand,g,l_hand,torque),tspan,init);
% 
% figure(3)
% subplot(2,2,1); plot(t_sim,states(:,1)); grid on; 
% xlabel('Time (sec)'); ylabel('\theta (rad)');
% title('\theta v.s Time Body Frame');
% 
% subplot(2,2,2); plot(t_sim,states(:,2)); grid on; 
% xlabel('Time (sec)'); ylabel('\theta/s (rad)');
% title('\theta/s v.s Time Body Frame');
% 
% subplot(2,2,3); plot(t_sim,states(:,3)); grid on; 
% xlabel('Time (sec)'); ylabel('\phi (rad)');
% title('\phi v.s Time Body Frame');
% 
% subplot(2,2,4); plot(t_sim,states(:,4)); grid on; 
% xlabel('Time (sec)'); ylabel('\phi/s (rad)');
% title('\phi/s v.s Time Body Frame');
%% Forearm Animation
% scale=100;
% figure(4)
% for n=1:length(t_sim)
%     x=l_hand*cos(states(n,1));
%     y=l_hand*sin(states(n,1));
%     plot3(0,0,0,'k.','MarkerSize',10); hold on; grid on; %Plot the origin
%     plot3(0,x/2,y/2,'kh','MarkerSize',10); plot3([0,0],[0,x],[0,y],'k'); hold off;
%     xlim([(-max(states(:,1))-2.5)/scale,(max(states(:,1))+2.5)/scale]); 
%     ylim([(-max(states(:,1))-2.5)/scale,(max(states(:,1))+2.5)/scale]);
%     zlim([(-max(states(:,1))-2.5)/scale,(max(states(:,1))+2.5)/scale]);
%     xlabel('X'); ylabel('Y'); zlabel('Z');
%     pause(0.2);
% end
%% Elbow 

%% Elbow Animation

%% Elbow Rotation

%% Elbow Rotation Animation

%% Shoulder axis 1

%% Shoulder axis 1 Animation

%% Shoulder axis 2 

%% Shoulder axis 2 Animation

%% Rotation Matrices

%% Dynamics in Inertial Frame

%% Dynamics Animation

%% User Functions
function X=wristFunc(t,y,input,m,l,w,g)
    I=(m*l^2/3)+(m*w^2/12); %2nd moment of inertia
    A=[0,1;(-m*g*l)/(2*I),0];
    B=[0;1/I];
    X(1)=A(1,1)*y(1)+A(1,2)*y(2)+B(1)*input;
    X(2)=A(2,1)*cos(y(1))+A(2,2)*y(2)+B(2)*input;
    X=[X(1);X(2)];  
end

function X=forearmFunc(t,y,I,m_hand,g,l_hand,T)
    A=zeros(4);
    A(1,2)=1; A(2,2)=1; A(3,4)=1; A(2,1)=(m_hand*g*l_hand)/(-2*I(1));
    B=zeros(4,2);
    B(2,1)=1/I(1); B(4,2)=1/I(2);
    X(1)=A(1,1)*y(1)+A(1,2)*y(2)+A(1,3)*y(3)+A(1,4)*y(4)+B(1,1)*T(1)+B(1,2)*T(2);
    X(2)=A(2,1)*cos(y(1))+A(2,2)*y(2)+A(2,3)*y(3)+A(2,4)*y(4)+B(2,1)*T(1)+B(2,2)*T(2);
    X(3)=A(3,1)*y(1)+A(3,2)*y(2)+A(3,3)*y(3)+A(3,4)*y(4)+B(3,1)*T(1)+B(3,2)*T(2);
    X(4)=A(4,1)*y(1)+A(4,2)*y(2)+A(4,3)*y(3)+A(4,4)*y(4)+B(4,1)*T(1)+B(4,2)*T(2);
    X=[X(1);X(2);X(3);X(4)];
    
end