function phase = phaseCalc(phaseTimeL,countL,timeL,phaseTimeR,countR,timeR)
leftAngle = (countL/-4109)*(2*pi); %Angle in radians
rightAngle = (countR/2322)*(2*pi); %Angle in radians
StimeDiff = phaseTimeL-phaseTimeR; % Take the time difference of the switches being activated
EtimeDiff = timeL-timeR; %seconds
EcountDiff = leftAngle-rightAngle; %radians
% if the value is negative then R is larger than L and is moving slower
% than L.
phase={StimeDiff,EtimeDiff,EcountDiff};
% Lets assume 180 degree is about 0 (Each hits the switch at the same time
end