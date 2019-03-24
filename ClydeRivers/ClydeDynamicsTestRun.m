close all; clc; clear all;
%%  Arduino Code for 193B
%% Connecting to the Arduino
a = arduino('COM7','MEGA2560','Libraries', {'Adafruit\MotorShieldV2','RotaryEncoder'});
shield = addon(a, 'Adafruit\MotorShieldV2');
addrs = scanI2CBus(a,0);
rightleg = dcmotor(shield, 2);
leftleg = dcmotor(shield, 1);
rightSwitch = a.AvailablePins{10};
leftSwitch = a.AvailablePins{8};
leftEnc = rotaryEncoder(a,'D19','D3',ceil(3575));
rightEnc = rotaryEncoder(a,'D18','D2',ceil(3575));
%% Initialize Controller and States
offset = deg2rad(180); %Switch offset location
rightleg.Speed = 1.0;
leftleg.Speed = -rightleg.Speed;
resetCount(leftEnc);
resetCount(rightEnc);
n=1;
index = 200;

countL = NaN*ones(index,1);
countR = NaN*ones(index,1);

timeL = NaN*ones(index,1);
timeR = NaN*ones(index,1);

Lrpm = NaN*ones(index,1);
Rrpm = NaN*ones(index,1);

phaseTimeL = NaN*ones(index,1);
phaseTimeR = NaN*ones(index,1);

leftState = NaN*ones(index,1);
rightState = NaN*ones(index,1);

%% Start the Show Clyde
phaseTimeL = 0;
phaseTimeR = 0;
UserInput = input('Press g to Start:    ','s');
start(rightleg);
start(leftleg);
if strcmp(UserInput,'g')==1
    while n<=index
        [countL(n),timeL(n)] = readCount(leftEnc);
        Lrpm(n) = readSpeed(leftEnc);
        leftState(n) = readDigitalPin(a,leftSwitch);
        if leftState(n)==0
            phaseTimeL(n) = getswitchTime();
        end
        [countR(n),timeR(n)] = readCount(rightEnc);
        Rrpm(n) = readSpeed(rightEnc);
        rightState(n) = readDigitalPin(a,rightSwitch);
        if rightState(n)==0
            phaseTimeR(n) = getswitchTime();
        end
%         phase = phaseCalc(phaseTimeL(n),countL(n),timeL(n),phaseTimeR(n),countR(n),timeR(n));
        fprintf('n == %i\t',n);
        fprintf('while == %i\n',strcmp(UserInput,'g')==1);
%         if mod(n,15)==0
%             UserInput = input('Press s to Stop:    ','s');
%             if strcmp(UserInput,'g')==0
%                 break;
%             end
%         end
        n=n+1;
    end
    stop(rightleg);
    stop(leftleg);
    
else
    stop(rightleg);
    stop(leftleg);
end
cd dynamicData\
save(['dutyCycle_',num2str(rightleg.Speed),'.mat'],'countL','countR','timeL','timeR','leftState','rightState','Lrpm','Rrpm','phaseTimeL','phaseTimeR','offset');
cd ../;