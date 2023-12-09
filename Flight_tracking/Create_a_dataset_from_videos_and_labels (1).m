%% Introduction
% This is an example showing how to create a dataset for training from 
% videos and label-files.


%% Preparations:
% 1. Create a folder called Data under C:
% 2. Copy the folders Video_IR and Video_V to the folder C:\Data
% 3. Add the folder C:\Data to the Matlab path using "Set Path"
% This has to be done so that the DataSource-value of the groundTruth-
% object in the label-file points at the correct video file.


%% Load ground truth from four label-files
gt1=load('V_AIRPLANE_001_LABELS.mat');
gt2=load('V_BIRD_001_LABELS.mat');
gt3=load('V_DRONE_001_LABELS.mat');
gt4=load('V_HELICOPTER_001_LABELS.mat');

gt5=load('V_AIRPLANE_002_LABELS.mat');
gt6=load('V_AIRPLANE_013_LABELS.mat');
gt7=load('V_AIRPLANE_014_LABELS.mat');%%%%
gt8=load('V_AIRPLANE_019_LABELS.mat');
gt9=load('V_AIRPLANE_032_LABELS.mat');
gt10=load('V_AIRPLANE_048_LABELS.mat');
gt11=load('V_AIRPLANE_050_LABELS.mat');

gt12=load('V_BIRD_002_LABELS.mat');
gt13=load('V_BIRD_004_LABELS.mat');

gt14=load('V_DRONE_002_LABELS.mat');
gt15=load('V_DRONE_013_LABELS.mat');
gt16=load('V_DRONE_014_LABELS.mat');
gt17=load('V_DRONE_019_LABELS.mat');
gt18=load('V_DRONE_031_LABELS.mat');

gt19=load('V_HELICOPTER_010_LABELS.mat');
gt20=load('V_HELICOPTER_018_LABELS.mat');
gt21=load('V_HELICOPTER_023_LABELS.mat');
gt22=load('V_HELICOPTER_024_LABELS.mat');
gt23=load('V_HELICOPTER_044_LABELS.mat');
gt24=load('V_HELICOPTER_055_LABELS.mat');
gt25=load('V_HELICOPTER_060_LABELS.mat');
gt26=load('V_HELICOPTER_003_LABELS.mat');




%% Put the ground truth together 7 8 10 21 23
gTruth = [gt1.gTruth;gt2.gTruth;gt3.gTruth;gt4.gTruth; gt5.gTruth; gt6.gTruth; gt9.gTruth; gt11.gTruth; gt12.gTruth; gt13.gTruth; gt14.gTruth; gt15.gTruth; gt16.gTruth; gt17.gTruth; gt18.gTruth; gt19.gTruth; gt20.gTruth; gt22.gTruth; gt24.gTruth; gt25.gTruth; gt26.gTruth; gt8.gTruth; gt21.gTruth;];
gTruth = selectLabels(gTruth, {'AIRPLANE','BIRD','DRONE','HELICOPTER'});
%gTruth = selectLabels(gTruth,{'AIRPLANE','BIRD','DRONE','HELICOPTER', 'AIRPLANE', 'AIRPLANE', 'AIRPLANE', 'AIRPLANE', 'AIRPLANE', 'AIRPLANE', 'AIRPLANE','BIRD','BIRD', 'DRONE','DRONE','DRONE','DRONE','DRONE', 'HELICOPTER', 'HELICOPTER', 'HELICOPTER', 'HELICOPTER', 'HELICOPTER', 'HELICOPTER', 'HELICOPTER', 'HELICOPTER'});


%% Create a folder for all the images that will be extracted from the videos
if isfolder(fullfile('Training_data_V'))
    cd Training_data_V
else
    mkdir Training_data_V
end 
addpath('Training_data_V');


%% Produce the training dataset
trainingData = objectDetectorTrainingData(gTruth,...
    'SamplingFactor', [3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3,3], ...
    'WriteLocation','Training_data_V');
% Using a sampling factor of 1 means that all images from the video will be
% included in the dataset.
% If more or less than four label-files is to be included, the length of the
% SamplingFactor-array must also be changed so that the number of files and
% the length are the same.


%% Save the training dataset
save('Training_data_V.mat',"trainingData")


%% Results
% You should now have the following:
% 1. A folder contaning the images extracted from the videos
% 2. A .mat-file with as many rows as images and five columns, one with
% the paths to the images and four with bounding boxes for the respective classes


%% Example of how to use the results:
% To load the dataset, use the following commands:
% addpath('Training_data_IR');
% data = load('Training_data_IR.mat');
% trainingData = data.trainingData;

% To train a detector, use the following commands:
% [detector,info] = trainYOLOv2ObjectDetector(trainingData,lgraph,options);
% Note that lgraph and options has to be defined first.

