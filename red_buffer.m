% 加载预训练模型
load('trainedSVMModel.mat');  
load('TRCSPFilters.mat');     

% 参数设置
fs = 250;  
windowLength = 1 * fs; 
buffer = zeros(windowLength, nChannels); 

while true
    
    newData = getNewEEGData();
    processRealTimeData(newData);
end


function processRealTimeData(newData)
   
    buffer = [buffer(size(newData, 1)+1:end, :); newData];
   
    filteredData = applyButterworthFilter(buffer, 5, 8, 30, fs);
   
    features = extractFeaturesTRCSP(filteredData, TRCSPFilters);
    
    label = predict(trainedSVMModel, features);
    
    fprintf('预测的类别: %d\n', label);
end


