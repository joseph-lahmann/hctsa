convert_to_cells
files = dir();

order = {'na',
        'j1s_0.1',
        'j1s_0.2',
        'j1s_0.3',
        'j1s_0.4',
        'j1s_0.5',
        'j1s_0.6',
        'j1s_0.7',
        'j1s_0.8',
        'j1s_0.9',
        'j1d_0.1',
        'j1d_0.2',
        'j1d_0.3',
        'j1d_0.4',
        'j1d_0.5',
        'j1d_0.6',
        'j1d_0.7',
        'j1d_0.8',
        'j1d_0.9',
        };

for  k = 3:length(files)
    folder = files(i).name();
    customfilenorm = strcat(customfile(1:end-4),'_N.mat');
    if exist(customfilenorm,'file')
        load(customfilenorm); 
        
        % Extract the Keywords column from the TimeSeries table
        keywords = TimeSeries.Keywords;

        n = length(order);

        % Selection sort
        order_idx = 0;
        data_idx = 0;
        for i = 1:n-1
            % Assume the minimum is the first element
            for j = data_idx+1:n
                if contains(keywords{j},keywords{order_idx})
                    new_min_idx = j;
        
                    % Swap in the TimeSeries table
                    tempRow = TimeSeries(data_idx, :);
                    TimeSeries(data_idx, :) = TimeSeries(new_min_idx, :);
                    TimeSeries(new_min_idx, :) = tempRow;
                    
                    % Also swap the corresponding rows in the TimeSeries table
                    tempRow = TimeSeries(data_idx, :);
                    TimeSeries(data_idx, :) = TimeSeries(new_min_idx, :);
                    TimeSeries(new_min_idx, :) = tempRow;
                    
                    % Swap the corresponding rows in the TS_DataMat matrix
                    tempMatRow = TS_DataMat(data_idx, :);
                    TS_DataMat(data_idx, :) = TS_DataMat(new_min_idx, :);
                    TS_DataMat(new_min_idx, :) = tempMatRow;
                    
                    data_idx = data_idx + 1;
                end
        
            end
        end

% Save the sorted data back to a new .mat file
save('sorted_yourfile.mat', 'TS_DataMat', 'TimeSeries'); % Replace 'sorted_yourfile.mat' with your desired file name

    end
end

mkdir("master_list");
save('master_list\HCTSA.mat')

% Load the .mat file
load('yourfile.mat'); % Replace 'yourfile.mat' with the name of your .mat file

% Ensure the necessary variables exist
if ~exist('TS_DataMat', 'var') || ~exist('TimeSeries', 'var') || ~ismember('Keywords', TimeSeries.Properties.VariableNames)
    error('Required variables or fields are missing from the .mat file.');
end

% Extract the Keywords column from the TimeSeries table
keywords = TimeSeries.Keywords;

% Get the number of elements
% n = length(keywords);
order = {'na',
        'j1s_0.1',
        'j1s_0.2',
        'j1s_0.3',
        'j1s_0.4',
        'j1s_0.5',
        'j1s_0.6',
        'j1s_0.7',
        'j1s_0.8',
        'j1s_0.9',
        'j1d_0.1',
        'j1d_0.2',
        'j1d_0.3',
        'j1d_0.4',
        'j1d_0.5',
        'j1d_0.6',
        'j1d_0.7',
        'j1d_0.8',
        'j1d_0.9',
        };
n = length(order);
% Selection sort
order_idx = 0;
data_idx = 0;
for i = 1:n-1
    % Assume the minimum is the first element
    for j = data_idx+1:n
        if contains(keywords{j},keywords{order_idx})
            new_min_idx = j;

            % Swap in the TimeSeries table
            tempRow = TimeSeries(data_idx, :);
            TimeSeries(data_idx, :) = TimeSeries(new_min_idx, :);
            TimeSeries(new_min_idx, :) = tempRow;
            
            % Also swap the corresponding rows in the TimeSeries table
            tempRow = TimeSeries(data_idx, :);
            TimeSeries(data_idx, :) = TimeSeries(new_min_idx, :);
            TimeSeries(new_min_idx, :) = tempRow;
            
            % Swap the corresponding rows in the TS_DataMat matrix
            tempMatRow = TS_DataMat(data_idx, :);
            TS_DataMat(data_idx, :) = TS_DataMat(new_min_idx, :);
            TS_DataMat(new_min_idx, :) = tempMatRow;
            
            data_idx = data_idx + 1;
        end

    end
    

end

% Save the sorted data back to a new .mat file
save('sorted_yourfile.mat', 'TS_DataMat', 'TimeSeries'); % Replace 'sorted_yourfile.mat' with your desired file name
