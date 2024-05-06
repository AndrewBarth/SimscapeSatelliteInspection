count = 0;
for countVars = 1:length(vars)
    var = vars(countVars).Name;
    val = vars(countVars).Value;
    if isa(val, 'Simulink.Parameter')
        % Do nothing 
        continue;
    end   
    count = count+1;
		
% Create and configure Simulink.Parameter objects 
% corresponding to the control variable names.
% Specify the storage class as Define (Custom).
	newVal = Simulink.Parameter(val);
	newVal.DataType = 'int16';
	newVal.CoderInfo.StorageClass = 'Custom';
	newVal.CoderInfo.CustomStorageClass = 'Define (Custom)';
	newVal.CoderInfo.CustomAttributes.HeaderFile = headerFileName;
		
		Simulink.data.assigninGlobal(model, var, newVal);
		
		if ~fidErr
    		fprintf(fid, '#endif\n');
    		fclose(fid);
		end
end