%% this calls multiGaussSegmentation code for my data
% call the code for each dimension of IMU data

clear all
close all
clc



% t = readtable('feeding 2.csv');
t = readtable('mod_feeding 1.csv');
% t = readtable('deodorant 4.csv');
tLabels2 = table2cell(t(:,[1 end])); % store time stamp and label
t2 = t(:,1:end-1); % remove the labels colum
dataMatrix = table2array(t2);
X = dataMatrix;
% [coeff score] = pca(dataMatrix);
% X = score(:,1:12);
% figure,plot(X)


 tLabels = tLabels2(~cellfun(@isempty,tLabels2(:,2)),:); % keep the labels and their time stamps
 timeStamps = 100.*cell2mat(tLabels(:,1)); % multiplying by 100 to convert to frame number; adding 1 to avoid frame number zero
 timeStamps(1)=timeStamps(1)+1;

 CPs ={};
 for i=2:size(X,2)-2 % go to dim-2 (the last 2 dim are labelCntr and labels
    i
     CPs(i-1) = {multiGaussSegmentation(X(:,i))}; % call segmentation code for each dimension of X
 end
%  
%  figure, plot(CPs(:,1)), hold on
%

figure
plot(timeStamps,'ro-','linewidth',3)
hold on
 for i=1:length(CPs)
    plot(CPs{1,i}(:,2), '*-') % plot the second column in CPs
    pause(0.3)
 end
  hold off