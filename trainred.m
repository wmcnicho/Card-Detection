function [] = trainred()
%TRAINRED Used to train the red bayesian classifer model. Assumes that
%there is data prestored in properties/heart and properties/diamond
%according to the convention specified in readSymProps
%   The file reading was used to speed up the training since the symbol
%   dectection process can be time consuming

symbolVecs = readSymProps('heart');
symbolVecs = [symbolVecs;readSymProps('diamond')];

redDim = 3;
redNumClass = 2;
symbolClasses = [ones(60,1);2 * ones(60,1)];

symbol_n = size(symbolClasses,1);

[redMeans,redInvcors,redAprioris] = buildmodel(redDim,symbolVecs,symbol_n,redNumClass,symbolClasses);

eval(['save  trained_models/symbols_red.mat redNumClass redMeans redInvcors redAprioris']);
    
end