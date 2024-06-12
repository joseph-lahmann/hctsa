% my analysis

% The code to run (INP_mops.txt); and
% The features to extract from that code (INP_ops.txt).
% close all;clear all; clc;

% just in case, convert to cells
convert_to_cells

files = dir('*.mat');
% Loop over each file
for i = 1:length(files)
    % Load the file
    if i > 0
        folder = files(i).name(1:end-4);
        mkdir(folder);
        customfile = strcat(folder,'\HCTSA.mat');
        customfilenorm = strcat(customfile(1:end-4),'_N.mat');
        distanceMetricRow = 'euclidean'; % time-series feature distance
        linkageMethodRow = 'average'; % linkage method
        distanceMetricCol = 'corr_fast'; % a (poor) approximation of correlations with NaNs
        linkageMethodCol = 'average'; % linkage method
        
        TS_Init(files(i).name,{'INP_mops_catch22.txt','INP_ops_catch22.txt'},[0,0,0],customfile)
        % TS_Init(files(i).name,{'INP_mops_hctsa.txt','INP_ops_hctsa.txt'},[0,0,0],customfile)

        TS_Compute(true,[],[],'missing',customfile) % args are (parallel?, TS index range, op id index range, custome .mat file to operate on)
        TS_InspectQuality('full',customfile) %other args summary, master, full, reduced

        TS_LabelGroups(customfile,{'Healthy','Defect'})
        TS_PlotTimeSeries(customfile,10,[])

        TS_Normalize('mixedSigmoid',[0.00,1],customfile)

        TS_Cluster(distanceMetricRow, linkageMethodRow, distanceMetricCol, linkageMethodCol, false, customfile);
        TS_Cluster(distanceMetricRow, linkageMethodRow, distanceMetricCol, linkageMethodCol, false, customfilenorm);


        TS_PlotDataMatrix('whatData',customfile)% Visualize structure in data matrix
        TS_PlotDataMatrix('whatData',customfilenorm)% Visualize structure in data matrix

        TS_PlotLowDim(customfile) % Visualize low-dimensional structure
        TS_PlotLowDim(customfilenorm) % Visualize low-dimensional structure

        TS_TopFeatures(customfile,'classification',struct(),'whatPlots',{'histogram','distributions',...
                  'cluster'},'numTopFeatures',10,'numFeaturesDistr',5,'numNulls',1);

        TS_TopFeatures(customfilenorm,'classification',struct(),'whatPlots',{'histogram','distributions',...
                  'cluster'},'numTopFeatures',10,'numFeaturesDistr',5,'numNulls',1);   

        TS_Classify(customfile,struct(),3,'doPlot',true);
        TS_Classify(customfilenorm,struct(),3,'doPlot',true);
        
        % TS_SimSearch() % looks at similar matches to a target time series
        % TS_FeatureSummary() % look at behavior of a given operation cross the time-series dataset
        close all;
        fclose('all');
    end
    % break;
end
