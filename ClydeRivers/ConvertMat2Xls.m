clear all; close all; clc;
%% Load data
cd C:\Users\aaten\Documents\Anthony-s-Humanoid-Robotic-Code\ClydeRivers\dynamicData;
files = dir('*.mat');

for n = 1:length(files)
    fileName = files(n).name;
    data = load(fileName);
    f = fieldnames(data);
    varName = [];
    for k=1:size(f,1)
        col = [char(k+64),num2str(1),':',char(k+64),num2str(length(data.(f{k})))];
        name = [fileName(1:end-4),'.xlsx'];
        A = data.(f{k})
        xlswrite(name,,1,col);
    end
end