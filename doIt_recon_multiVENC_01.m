clear all
close all
clc
%figure('MenuBar', 'none','ToolBar', 'none');

%%%%%%%%%%%%%%%
%% Dependencies
toolDir = '/scratch/users/Proulx-S/tools';
bassReconDir = fullfile(toolDir, 'bassRecon');
if ~exist(bassReconDir, 'dir')
    fprintf('bassRecon repo not found. Cloning from GitHub...\n');
    system(sprintf('cd %s && git clone https://github.com/Proulx-S/bassRecon.git', toolDir));
    if ~exist(bassReconDir, 'dir')
        error('Failed to clone bassRecon repository.');
    end
    fprintf('bassRecon cloned successfully.\n');
else
    fprintf('bassRecon repo already exists at %s\n', bassReconDir);
end
addpath(genpath(bassReconDir));
%% %%%%%%%%%%%%

%%%%%%%%%%%%%
%% Crop range
%%%%%%%%%%%%%
% cropRange =[1 208; 34 150]; % tight crop of the agar body
cropRange = 0; % 0: no crop; 1: manual crop range; [2 x 2]: crop limits
%% %%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%
%% Recon file by file
%%%%%%%%%%%%%%%%%%%%%
% see takoyaki:/local/users/Proulx-S/db/multiVENC_sub01
dataFiles = dir(fullfile(pwd, 'raw', '*.dat'));
dataFiles(~contains({dataFiles.name},'BEAT_FQ')) = [];
dataFiles(1) = [];

coilMethod = 'bartEspirit';
for iFile = 1:length(dataFiles)
    fprintf('Processing file %d of %d: %s\n', iFile, length(dataFiles), dataFiles(iFile).name);
    [outName,cropRange] = simpleRecon(fullfile(pwd, 'raw', dataFiles(iFile).name),coilMethod,0,0);
end
%% %%%%%%%%%%%%%%%%%%



