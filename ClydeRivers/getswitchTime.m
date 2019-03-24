function phaseTime = getswitchTime()
Time=clock;
Time(1:3)=[];
phaseTime=dot(Time,[3600,60,1]); %Seconds
end