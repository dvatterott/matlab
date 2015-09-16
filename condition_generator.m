function [ out_struct ] = condition_generator( var_struct )
%condition_generator: simple counter balancing function
%   input is a structure with the variables as fields and the possible
%   levels as numbers/strings in these fields. 
%   the output is a structure with the same fields, but now the output is
%   counterbalanced across the different levels
%   the output is not random.

% parse the number of variables and levels
fields                          = fieldnames(var_struct);
varLevels                       = zeros(1,numel(fields));
for i = 1 : numel(fields)
    varLevels(i)                = length(var_struct.(fields{i}));
end
TotalTrial                      = prod(varLevels);

% counter balance variables
for i = 1 : numel(fields) 
    divisor                     = TotalTrial/prod(varLevels(1:i));
    TrialsVect                  = 1:TotalTrial;

    varHolder                   = mod((TrialsVect-1)/divisor, varLevels(i));
    out_struct.(fields{i})      = var_struct.(fields{i})(floor(varHolder)+1);       
end
end
