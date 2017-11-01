function [ output_args ] = loadC( Sizek )
%LOADC Summary of this function goes here
%   Detailed explanation goes here

mapname = strcat('ImageMap_Cantor', num2str(Sizek));
load (mapname);

end

