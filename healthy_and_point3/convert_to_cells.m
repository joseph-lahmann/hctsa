function convert_to_cells()
%written by copilot

% Get a list of all .mat files in the current directory
files = dir('*.mat');

% Loop over each file
for i = 1:length(files)
    % Load the file
    data = load(files(i).name);
    
    % Get the variable names in the file
    varNames = fieldnames(data);
    
    % Loop over each variable
    for j = 1:length(varNames)
        % If the variable is a char array, convert it to a cell array
        if ischar(data.(varNames{j}))
            data.(varNames{j}) = cellstr(squeeze(data.(varNames{j})));
            % fprintf("converting")
        end
    end
    
    % Save the file again, overwriting the original
    save(files(i).name, '-struct', 'data');
end

end