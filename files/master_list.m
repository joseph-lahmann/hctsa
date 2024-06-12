% just in case, convert to cells
convert_to_cells

files = dir();
% Loop over each file

TS_DataMat = [];
TS_CalcTime = [];
TS_Quality = [];
Operations = table();

for i = 3:length(files)
    folder = files(i).name();
    customfile = strcat(folder,'\HCTSA.mat');
    customfilenorm = strcat(customfile(1:end-4),'_N.mat');
    if exist(customfilenorm,'file')

        new_data = load(customfile);
        % index = isnan(new_data.('TS_DataMat'));
        data_mat = new_data.('TS_DataMat');
        ops = new_data.("Operations");

        appendString = strcat(folder,' - ');
        ops.Name = strcat(appendString,ops.Name);

        MasterOperations = new_data.MasterOperations;
        TS_CalcTime = [TS_CalcTime,new_data.TS_CalcTime];
        TS_DataMat = [TS_DataMat, new_data.("TS_DataMat")];
        TS_Quality = [TS_Quality, new_data.("TS_Quality")];
        Operations = vertcat(Operations, ops);
        TimeSeries = new_data.TimeSeries;
        fromDatabase = new_data.fromDatabase;
        gitInfo = new_data.gitInfo;
    end
end

mkdir("master_list");
save('master_list\HCTSA.mat')

