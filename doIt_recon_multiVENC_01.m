clear all
close all
clc
%figure('MenuBar', 'none','ToolBar', 'none');




projectName = 'multiVENC_sub01';
%%%%%%%%%%%%%%%%%%%%%
%% Set up environment
%%%%%%%%%%%%%%%%%%%%%

% Detect computing environment
os   = char(java.lang.System.getProperty('os.name'));
host = char(java.net.InetAddress.getLocalHost.getHostName);
user = char(java.lang.System.getProperty('user.name'));

% Setup folders
if strcmp(os,'Linux') && strcmp(host,'takoyaki') && strcmp(user,'sebp')
    envId = 1;
    storageDrive = '/local/users/Proulx-S/db/';
    scratchDrive = '/local/users/Proulx-S/db/';
    projectCode    = fullfile(scratchDrive, projectName);        if ~exist(projectCode,'dir');    mkdir(projectCode);    end
    projectStorage = fullfile(storageDrive, projectName);        if ~exist(projectStorage,'dir'); mkdir(projectStorage); end
    projectScratch = fullfile(scratchDrive, projectName, 'tmp'); if ~exist(projectScratch,'dir'); mkdir(projectScratch); end
    toolDir        = '/scratch/users/Proulx-S/tools';            if ~exist(toolDir,'dir');        mkdir(toolDir);        end
else
    envId = 2;
    storageDrive   = '/Users/sebastienproulx/db/';
    scratchDrive   = '/Users/sebastienproulx/db/';
    projectCode    = fullfile(scratchDrive, projectName);        if ~exist(projectCode,'dir');    mkdir(projectCode);    end
    projectStorage = fullfile(storageDrive, projectName);        if ~exist(projectStorage,'dir'); mkdir(projectStorage); end
    projectScratch = fullfile(scratchDrive, projectName, 'tmp'); if ~exist(projectScratch,'dir'); mkdir(projectScratch); end
    toolDir        = '/Users/sebastienproulx/tools';             if ~exist(toolDir,'dir');        mkdir(toolDir);        end
end

% Load dependencies and set paths
%%% initial cloning of matlab util to get gitClone.m
tool = 'util'; toolURL = 'https://github.com/Proulx-S/util.git';
if ~exist(fullfile(toolDir, tool), 'dir'); system(['git clone ' toolURL ' ' fullfile(toolDir, tool)]); end; addpath(genpath(fullfile(toolDir,tool)))
%%% matlab others
tool = 'util'; repoURL = 'https://github.com/Proulx-S/util.git'; branch = '';
gitClone(repoURL, fullfile(toolDir, tool), [], branch);
tool = 'bassRecon'; repoURL = 'https://github.com/Proulx-S/bassRecon.git'; branch = '';
gitClone(repoURL, fullfile(toolDir, tool), [], branch);

%% %%%%%%%%%%%%%%%%%%
disp(projectCode)
disp(projectStorage)
disp(projectScratch)
info.project.code    = projectCode;
info.project.storage = projectStorage;
info.project.scratch = projectScratch;
info.toClean = {};









%%%%%%%%%%%%%
%% Crop range
%%%%%%%%%%%%%
% cropRange =[1 208; 34 150]; % tight crop of the agar body
cropRange = 0; % 0: no crop; 1: manual crop range; [2 x 2]: crop limits
%% %%%%%%%%%%



return;


%%%%%%%%%%%%%%%%%%%%%
%% Recon file by file
%%%%%%%%%%%%%%%%%%%%%
% see takoyaki:/local/users/Proulx-S/db/multiVENC_sub01
dataFiles = dir(fullfile(projectStorage, 'raw', '*.dat'));
dataFiles(~contains({dataFiles.name},'BEAT_FQ')) = [];
dataFiles(1) = [];
dataFiles = fullfile({dataFiles.folder},{dataFiles.name})';
dataRefFiles = dir(fullfile([projectStorage '_eccRef'],'raw','*.dat'));
dataRefFiles = flip(dataRefFiles);
dataRefFiles = fullfile({dataRefFiles.folder},{dataRefFiles.name})';




% % Check spatial correspondence
% dir(fullfile(projectStorage, 'nii'))
% dir(fullfile(projectStorage, 'nii', '*','*','*','*'))
% % confirmed on Sherlock





coilMethod     = 'bartEspirit';
dataFilesRecon = cell(size(dataFiles));
for iFile = 1:length(dataFiles)
    % outName = fullfile(dataFiles(iFile).folder,replace(dataFiles(iFile).name,'.dat',['_fft_coilComb-' coilMethod '.mat']));
    outName = replace(dataFiles{iFile},'.dat',['_fft_coilComb-' coilMethod '.mat']);
    % outName = fullfile(dataFiles(iFile).folder,replace(dataFiles(iFile).name,'.dat',['_fft_coilComb-' coilMethod '.mat']));
    if exist(outName,'file')
        fprintf('File already exists: %s\n', outName);
    else
        % fprintf('Processing file %d of %d: %s\n', iFile, length(dataFiles), dataFiles(iFile).name);
        % [outName,cropRange] = simpleRecon(fullfile(dataFiles(iFile).folder, dataFiles(iFile).name),coilMethod,0,0);
        fprintf('Processing file %d of %d: %s\n', iFile, length(dataFiles), dataFiles{iFile});
        [outName,cropRange] = recon(dataFiles{iFile},[],dataRefFiles{iFile},coilMethod,cropRange)
    end
    dataFilesRecon{iFile} = outName;
end
dataRefFilesRecon = cell(size(dataRefFiles));
for iFile = 1:length(dataRefFiles)
    outName = fullfile(dataRefFiles(iFile).folder,replace(dataRefFiles(iFile).name,'.dat',['_fft_coilComb-' coilMethod '.mat']));
    if exist(outName,'file')
        fprintf('File already exists: %s\n', outName);
    else
        fprintf('Processing file %d of %d: %s\n', iFile, length(dataRefFiles), dataRefFiles(iFile).name);
        [outName,cropRange] = simpleRecon(fullfile(dataRefFiles(iFile).folder, dataRefFiles(iFile).name),coilMethod,0,0);
    end
    dataRefFilesRecon{iFile} = outName;
end
%% %%%%%%%%%%%%%%%%%%



if 0
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Confirm object-independence of eddy-current-related background phase
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

iFile = 1;
data    = load(dataFilesRecon{iFile});
dataRef = load(dataRefFilesRecon{iFile});


size(data.img)
size(data.venc)
size(dataRef.img)
size(dataRef.venc)




rep = 3;

figure;
hT = tiledlayout(2,2); hT.TileSpacing = 'compact'; hT.Padding = 'compact'; ax = {}; colormap gray
ax{end+1} = nexttile(hT,1);
imagesc(abs(data.img(:,:,1,1,1,1,1,1,1,1,rep,1,1,1,1,1))); axis image;
title('data');
ax{end+1} = nexttile(hT,2);
imagesc(abs(dataRef.img(:,:,1,1,1,1,1,1,1,1,rep,1,1,1,1,1))); axis image;
title('dataRef');
ax{end+1} = nexttile(hT,3);
imagesc(angle(data.img(:,:,1,1,1,1,1,1,1,1,rep,1,1,1,1,1)),[-pi pi]); axis image;
title('data');
ax{end+1} = nexttile(hT,4);
imagesc(angle(dataRef.img(:,:,1,1,1,1,1,1,1,1,rep,1,1,1,1,1)),[-pi pi]); axis image;
title('dataRef');


whos data dataRef



figure;
hT = tiledlayout(2,6); hT.TileSpacing = 'compact'; hT.Padding = 'compact';
ax = {};

tmp = mean(data.img(:,:,1,1,1,1,:,1,1,1,:,1,1,1,1,1),11);
ax{end+1} = nexttile(hT);
imagesc(abs(tmp(:,:,:,:,:,:,1,:,:,:,:,:,:,:,:,:))); axis image;
ax{end}.Colormap = gray;
title('mag'); ylabel('in vivo');

tmp = tmp ./ exp(1i*angle(tmp(:,:,:,:,:,:,1,:,:,:,:,:,:,:,:,:)));
for i = 2:6
    ax{end+1} = nexttile(hT);
    imagesc(angle(tmp(:,:,:,:,:,:,i,:,:,:,:,:,:,:,:,:)),[-pi pi]); axis image;
    title(['venc=' num2str(data.venc(i)), 'cm/s']);
end
ylabel(colorbar, 'phase difference [rad]');



tmp = mean(dataRef.img(:,:,1,1,1,1,:,1,1,1,:,1,1,1,1,1),11);
ax{end+1} = nexttile(hT);
imagesc(abs(tmp(:,:,:,:,:,:,1,:,:,:,:,:,:,:,:,:))); axis image;
ax{end}.Colormap = gray;
title('mag'); ylabel('phantom reference');

tmp = tmp ./ exp(1i*angle(tmp(:,:,:,:,:,:,1,:,:,:,:,:,:,:,:,:)));
for i = 2:6
    ax{end+1} = nexttile(hT);
    imagesc(angle(tmp(:,:,:,:,:,:,i,:,:,:,:,:,:,:,:,:)),[-pi pi]); axis image;
    title(['venc=' num2str(dataRef.venc(i)), 'cm/s']);
end
ylabel(colorbar, 'phase difference [rad]');

set([ax{:}],'XTick',[],'YTick',[]);




tmp = mean(dataRef.img(:,:,1,1,1,1,:,1,1,1,:,1,1,1,1,1),11);
tmp = tmp ./ exp(1i*angle(tmp(:,:,:,:,:,:,1,:,:,:,:,:,:,:,:,:)));
for i = 2:6
    ax{end+1} = nexttile(hT);
    imagesc(angle(tmp(:,:,:,:,:,:,i,:,:,:,:,:,:,:,:,:)),[-pi pi]); axis image; colormap hsv;
    title(['dataRef ', num2str(i)]);
end
colorbar



ax{end}.XTick = []; ax{end}.YTick = [];
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Venc-dependent background phase is receive-channel-independent
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
load('tmp.mat')
whos img1 img2 iCoil1 iCoil2
clear iCoil1 iCoil2
img1 = mean(img1,11);
img2 = mean(img2,11);
img1 = img1(:,:,:,:,:,:,2:end) ./ exp(1i*angle(img1(:,:,:,:,:,:,1)));
img2 = img2(:,:,:,:,:,:,2:end) ./ exp(1i*angle(img2(:,:,:,:,:,:,1)));

size(img1)
size(img2)


close all
curImg = img1;
for vencIdx = 1:size(curImg,7)
    figure;
    nRows = 4;
    nCols = ceil(size(curImg,4)./nRows);
    hT = tiledlayout(nRows,nCols); hT.TileSpacing = 'compact'; hT.Padding = 'compact'; ax = {};
    for coilIdx = 1:size(curImg,4)
        ax{end+1} = nexttile(hT);
        imagesc(angle(curImg(:,:,:,coilIdx,:,:,vencIdx)),[-pi/2 pi/2]); axis image;
        % title(['coil=' num2str(coilIdx)]);
    end
    set([ax{:}],'XTick',[],'YTick',[],'Colormap',hsv);
    ylabel(colorbar, 'phase difference [rad]');
    title(hT, ['venc=' num2str(vencIdx) 'cm/s']);
end




set([ax{:}],'XTick',[],'YTick',[]);





for coilIdx = 3:52

figure;
hT = tiledlayout(2,6); hT.TileSpacing = 'compact'; hT.Padding = 'compact';
ax = {};

tmp = img1(:,:,:,coilIdx,:,:,:);
ax{end+1} = nexttile(hT);
imagesc(abs(tmp(:,:,:,:,:,:,1,:,:,:,:,:,:,:,:,:))); axis image;
ax{end}.Colormap = gray;
title('mag'); ylabel('in vivo');

for i = 1:5
    ax{end+1} = nexttile(hT);
    imagesc(angle(tmp(:,:,:,:,:,:,i,:,:,:,:,:,:,:,:,:)),[-pi pi]); axis image;
    % title(['venc=' num2str(data.venc(i)), 'cm/s']);
end
ylabel(colorbar, 'phase difference [rad]');



tmp = img2(:,:,:,coilIdx,:,:,:);
ax{end+1} = nexttile(hT);
imagesc(abs(tmp(:,:,:,:,:,:,1,:,:,:,:,:,:,:,:,:))); axis image;
ax{end}.Colormap = gray;
ylabel('phantom reference');

for i = 1:5
    ax{end+1} = nexttile(hT);
    imagesc(angle(tmp(:,:,:,:,:,:,i,:,:,:,:,:,:,:,:,:)),[-pi pi]); axis image;
    % title(['venc=' num2str(dataRef.venc(i)), 'cm/s']);
end
ylabel(colorbar, 'phase difference [rad]');

set([ax{:}],'XTick',[],'YTick',[]);

keyboard;
end

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end