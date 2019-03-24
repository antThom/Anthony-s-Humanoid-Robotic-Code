clear all; close all; clc;
%% load Data
cd C:\Users\aaten\Documents\Anthony-s-Humanoid-Robotic-Code\ClydeRivers\dynamicData;
files = dir('*.mat');
for n = 1:length(files)
    fileName = files(n).name;
    data{n} = load(fileName);
end
cd C:\Users\aaten\Documents\Anthony-s-Humanoid-Robotic-Code\ClydeRivers;
%% Figures
% figure(1);
% plot(data{1}.timeL,abs(data{1}.countL),'--'); hold on; grid on;
% plot(data{1}.timeR,abs(data{1}.countR),'--');
% 
% figure(2);
% plot(data{1}.timeL,abs(data{1}.Lrpm),'--'); hold on; grid on;
% plot(data{1}.timeR,abs(data{1}.Rrpm),'--');
% 
% figure(3);
% plot(data{1}.timeL,data{1}.leftState); hold on; grid on;
% ylim([-0.1,1.1]); % you can get velocity from this
% 
% figure(4);
% plot(data{1}.timeR,data{1}.rightState); grid on; hold on;
% ylim([-0.1,1.1]); % you can get velocity from this
% Find zeros in the switch state its corresponding time, get the clicks
% pers second and know that each click is 2 pi radians

%% Frequency of clicks
dtL = cell(length(data),1);
dtR = cell(length(data),1);
calcRpmL = cell(length(data),1);
calcRpmR = cell(length(data),1);
for n=1:length(data)
    %Plot the Data from the switch
%     figure(); subplot(1,2,1)
%     plot(data{n}.timeL,data{n}.leftState); hold on; grid on;
%     ylim([-0.1,1.1]); % you can get velocity from this
%     xlabel('Time (sec)'); ylabel('State (On/Off)');
%     title('Left Switch State over Time');
%     subplot(1,2,2);
%     plot(data{n}.timeR,data{n}.rightState); grid on; hold on;
%     ylim([-0.1,1.1]); 
%     xlabel('Time (sec)'); ylabel('State (On/Off)');
%     title('Right Switch State over Time');
    % Find the zeros in the switch states (index in array)
    zerL = ischange(data{n}.leftState,'variance');
    zerR = ischange(data{n}.rightState,'variance'); 
    indL = find(zerL==1);
    indL = indL(1:2:end);
    indR = find(zerR==1);
    indR = indR(1:2:end);
    % Find the corresponding time for each click
    tL = data{n}.timeL(indL);
    tR = data{n}.timeL(indR);
    % Find the difference between the time for the clicks and take the mean
    % and take the reciprical. This is the frequency of the clicks
    % This is also the angular velocity of the motor [rad/s]
    dtL{n} = 1/mean(diff(tL));
    dtR{n} = 1/mean(diff(tR));
    
    % Convert to RPM
    calcRpmL{n} = dtL{n}*(180/pi);
    calcRpmR{n} = dtR{n}*(180/pi);
end

%% Find Velocity from the Encoder counts
Lder = cell(length(data),1);
Rder = cell(length(data),1);
EncRevL{n} = cell(length(data),1)';
EncRevR{n} = cell(length(data),1)';
click2Rev =@(c) c / (12);
for n=1:length(data)
    % Plot the data
%     figure('units','normalized','outerposition',[0 0 1 1]); subplot(1,2,1);
%     plot(data{n}.timeL,abs(data{n}.countL),'--'); hold on; grid on;
%     xlabel('Time (sec)'); ylabel('Counts');
%     title('Left Encoder over Time');
%     subplot(1,2,2);
%     plot(data{n}.timeR,abs(data{n}.countR),'--'); grid on;
%     xlabel('Time (sec)'); ylabel('Counts');
%     title('Right Encoder over Time');
    
    % Take the derivative of the Encoder Counts
    Lder{n} = derivative(abs(data{n}.countL),data{n}.timeL); %Clicks/s
    Rder{n} = derivative(data{n}.countR,data{n}.timeR); %Clicks/s
    EncRevL{n} = click2Rev(Lder{n}); % RPM
    EncRevR{n} = click2Rev(Rder{n}); % RPM   
end


%% Compare RPM
close all;
for n=1:length(data)
   figure()
   plot(data{n}.timeL,EncRevL{n},'b'); grid on; hold on;
   plot(data{n}.timeL,calcRpmL{n}*ones(length(data{n}.timeL),1),'Color','r'); legend('Left Encoder','Left Switch');
   plot(data{n}.timeL,abs(data{n}.Lrpm),'g');
   legend('Left Encoder','Left Switch','Left Enc Calc');
   xlabel('Time (sec)'); ylabel('Angular Velocity (RPM)');
   title('Comparison between the Left Encoder and Switch');
%    ylim([min(EncRevL{n})-0.5,max(calcRpmL{n})+0.5]);
end

for n=1:length(data)
   figure()
   plot(data{n}.timeR,EncRevR{n},'b'); grid on; hold on;
   plot(data{n}.timeR,calcRpmR{n}*ones(length(data{n}.timeL),1),'Color','r');
   plot(data{n}.timeR,data{n}.Rrpm,'g');
   legend('Rigtht Encoder','RigthtSwitch', 'Right Enc Calc');
   xlabel('Time (sec)'); ylabel('Angular Velocity (RPM)');
   title('Comparison between the Rigtht Encoder and Switch');
%    ylim([min(EncRevR{n})-0.5,max(calcRpmR{n})+0.5]);
end

%% User Functions

function xdot = derivative(x,t);
xdot = NaN*ones(length(t),1);
for i=1:length(t)
    if i<5
        xdot(i) = (x(i+2)-x(i))/(2*(t(i+2)-t(i)));
    elseif i>=5 && i<=length(t)-2
        xdot(i) = (x(i+2)-x(i-2))/(2*(t(i+2)-t(i-2)));
    elseif i<=length(t)-1
        xdot(i) = (x(i)-x(i-2))/(2*(t(i)-t(i-2)));
    end
end
end
