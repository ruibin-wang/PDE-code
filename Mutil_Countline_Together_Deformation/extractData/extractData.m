clear;clc

label = '1';

cd ../MainFcnFile

load coffPressViscousNet.mat 
load generationParaSets.mat 
load orgPressViscousNet.mat
load StroChild.mat

% cd ../../../dataRestore/childGeneration/gen_1/1

cd ../extractData
eval(['mkdir ', label]);

eval(['cd ./', label]);


save coffPressViscousNet.mat coffPressViscousNet
save generationParaSets.mat generationParaSets
save orgPressViscousNet.mat orgPressViscousNet
save StroChild.mat StroChild



