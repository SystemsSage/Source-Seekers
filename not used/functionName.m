function filename = functionName ( input_args )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
filepath = mfilename('function');
[~, filename, ~] = fileparts(filepath);
end