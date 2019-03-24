clear all; close all; clc;
%% UPLOAD DATA

%Upload all of the data and save it into a single cell variable
cd data/pololu298/;
fileNum=numel(dir('*.mat'));
test=cell(1,fileNum);
for num=1:fileNum
    file=['test',num2str(num),'.mat'];
    test{num}=load(file);
end
cd ../../;
%% Check Validitiy of each trial

for num=1:fileNum
   cutoff=find(test{num}.dutyCycle==0,1);
   
   test{num}.dutyCycle(cutoff:end)=[];
   test{num}.encoder(cutoff:end)=[];test{num}.dutyCycle(cutoff:end)=[];
   test{num}.time(cutoff:end)=[];
   
   figure(num)
   plot(test{num}.time/1000,test{num}.encoder,'b'); grid on;
end

%% Take a derivative to find velocity and acceleration

for num=1:fileNum
   test{num}.vel=diff(test{num}.encoder)./diff(test{num}.time);
   test{num}.acc=diff(test{num}.vel)./diff(test{num}.time(1:end-1));
end
%% APPLY FILTER
for num=1:fileNum
   test{num}.vel=movmean(test{num}.vel,9);
   test{num}.acc=movmean(test{num}.acc,12);
end
%% Check Validitiy of each derivative

for num=1:fileNum
   figure(num+11)
   plot(test{num}.time(1:end-1)/1000,test{num}.vel,'b'); grid on;
   xlabel('Time (sec)');
   ylabel('Velocity (counts/sec)');
end

for num=1:fileNum
   figure(num+22)
   plot(test{num}.time(1:end-2)/1000,test{num}.acc,'b'); grid on;
   xlabel('Time (sec)');
   ylabel('Acceleration (counts/sec^2)');
end


%% Form the EQ acc=[A]*vel+[B]*input 

%Form matrix [vel input 1]
Y=cell(1,numel(test));
for num=1:fileNum
    DC=ceil((test{num}.dutyCycle/255)*100);
    Y{num}=[-test{num}.vel(1:end-1),DC(1:numel(test{num}.vel)-1),ones(size(test{num}.vel(1:end-1)))];
    input(num)=max(ceil((test{num}.dutyCycle/255)*100));
end

%Put all the Y matrices into one big matrix X
X=[];
acc=[];
for num=1:fileNum
   X=[X;Y{num}]; 
   acc=[acc;test{num}.acc];
end

%% Find the [A] & [B] from the EQ acc=[A]*vel+[B]*input using sol = X\acc
sol=X\acc
pole=sol(1);
gain=sol(2);
bias=sol(3);


