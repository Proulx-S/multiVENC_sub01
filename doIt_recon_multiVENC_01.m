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
    dataFilesRecon{iFile} = recon(dataFiles{iFile},[],dataRefFiles{iFile},coilMethod,[],[],1);
end
%% %%%%%%%%%%%%%%%%%%




for iFile = 1:length(dataFiles)
    load(dataFilesRecon{iFile});
    img = img./exp(1i*angle(mean(img(:,:,:,:,:,:,1,:,:,:,:,:,:,:,:,:),11)));
    datUncorrected = load(replace(imgInfo.datFile,'.dat','.mat'));
    imgUncorrected = datUncorrected.img./exp(1i*angle(mean(datUncorrected.img(:,:,:,:,:,:,1,:,:,:,:,:,:,:,:,:),11)));
    datUncorrectedPhaseRef = load(replace(imgInfo.datPhaseFile,'.dat','.mat'));
    imgUncorrectedPhaseRef = datUncorrectedPhaseRef.img./exp(1i*angle(mean(datUncorrectedPhaseRef.img(:,:,:,:,:,:,1,:,:,:,:,:,:,:,:,:),11)));
    figure('MenuBar', 'none','ToolBar', 'none');
    hT = tiledlayout(4,size(img,7)); hT.TileSpacing = 'compact'; hT.Padding = 'compact'; hT.TileIndexing = 'columnmajor';
    ax1 = {};
    ax2 = {};
    ax3 = {};
    ax4 = {};
    for iSet = 1:size(img,7)

        ax1{end+1} = nexttile(hT);
        imagesc(abs(mean(img(:,:,:,:,:,:,iSet,:,:,:,:,:,:,:,:,:),11))); axis image; drawnow;
        ax1{end}.Colormap = gray;
        title(ax1{end},['venc=' num2str(imgInfo.vencList(iSet)) ' cm/s']);
        if iSet == 1; ylabel(ax1{end},'corrected'); end;
        if iSet == size(img,7); ylabel(colorbar,'mag'); end;

        ax2{end+1} = nexttile(hT);
        imagesc(angle(mean(imgUncorrected(:,:,:,:,:,:,iSet,:,:,:,:,:,:,:,:,:),11)),[-pi pi]); axis image; drawnow;
        ax2{end}.Colormap = hsv;
        if iSet == 1; ylabel(ax2{end},'uncorrected'); end;
        if iSet == size(img,7); ylabel(colorbar,'phase difference'); end;

        ax3{end+1} = nexttile(hT);
        imagesc(angle(mean(imgUncorrectedPhaseRef(:,:,:,:,:,:,iSet,:,:,:,:,:,:,:,:,:),11)),[-pi pi]); axis image; drawnow;
        ax3{end}.Colormap = hsv;
        if iSet == 1; ylabel(ax3{end},'reference'); end;
        if iSet == size(img,7); ylabel(colorbar,'phase difference'); end;

        ax4{end+1} = nexttile(hT);
        imagesc(angle(mean(img(:,:,:,:,:,:,iSet,:,:,:,:,:,:,:,:,:),11)),[-pi pi]); axis image; drawnow;
        ax4{end}.Colormap = hsv;
        if iSet == 1; ylabel(ax4{end},'corrected'); end;
        if iSet == size(img,7); ylabel(colorbar,'phase difference'); end;

    end
    cLim = get([ax1{:}],'CLim'); cLim = [min([cLim{:}]) max([cLim{:}])*0.5]; set([ax1{:}],'CLim',cLim);
    set([ax1{:} ax2{:} ax3{:} ax4{:}],'DataAspectRatio',[imgInfo.fov./imgInfo.mat 1],'XTick',[],'YTick',[]);
end


