close all; clc; clear all;
%% Bills
rent = 1275 + 50;
rent2 = 550;
carInsurance = 45;
food = 200;
gas = 100;
gas2 = 300;
phone = 55;
loan = 105;
tax1 = 230;
% tax2 = 191;
ring = 125;
NYC = 80;
fun = 135;

bill1 = rent+carInsurance+food+gas+phone+tax1+loan+ring+NYC+fun;
% bill2 = rent+carInsurance+food+gas+phone+tax2+loan+ring+NYC;
bill3 = rent+rent2+carInsurance+food+gas2+phone+loan+ring+NYC+fun;
bill4 = rent+carInsurance+food+gas2+phone+loan+ring+NYC+fun;
%% Income
monthly1 = 3000;
monthly2 = 2500;
monthly3 = 3200;

income1 = monthly1;
income2 = monthly2;%+h;
income3 = monthly3;

%% Saving 
leftoverPerMonth1 = income1-bill1;
% leftoverPerMonth2 = income2-bill2;
leftoverPerMonth3 = income3-bill4;
leftoverPerMonth4 = income1-bill1;

overAll=zeros(1,5);
overAll(1) = leftoverPerMonth1*3;
% overAll(2) = leftoverPerMonth2*5;
overAll(3) = leftoverPerMonth3*3;
overAll(4) = leftoverPerMonth1*6;

fprintf('Squishy 3 Month:  %5.2f \n',overAll(1));%Option #2 5.2f \nOption #3 %5.2f \nOption #4 %5.2f \nOption #5 %5.2f\n',overAll(1),overAll(2),overAll(1)*2,overAll(3),overAll(1)+overAll(4));
fprintf('Squishy 6 Month:  %5.2f \n',overAll(4));
fprintf('Squishy 3 Month + Construction 3 Month:  %5.2f \n\n',overAll(1)+overAll(3));
%fprintf('Difference btwn options %4.2f\n',diff(overAll));