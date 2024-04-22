% dataClass1, dataClass2, dataClass3
featuresClass1 = extractFeaturesCSP3Classes(dataClass1, dataClass2, dataClass3, 0.1);
featuresClass2 = extractFeaturesCSP3Classes(dataClass2, dataClass1, dataClass3, 0.1);
featuresClass3 = extractFeaturesCSP3Classes(dataClass3, dataClass1, dataClass2, 0.1);

% 创建特征和标签矩阵
features = [featuresClass1; featuresClass2; featuresClass3];
labels = [ones(size(featuresClass1, 1), 1); 2 * ones(size(featuresClass2, 1), 1); 3 * ones(size(featuresClass3, 1), 1)];

% 划分训练和测试数据
cv = cvpartition(labels, 'HoldOut', 0.3);
XTrain = features(cv.training,:);
YTrain = labels(cv.training);
XTest = features(cv.test,:);
YTest = labels(cv.test);

% 训练SVM模型
SVMModel = fitcecoc(XTrain, YTrain);

% 测试模型
YPred = predict(SVMModel, XTest);
accuracy = sum(YTest == YPred) / length(YTest);
fprintf('准确率: %.2f%%\n', accuracy * 100);

% 混淆矩阵
confMat = confusionmat(YTest, YPred);
disp('混淆矩阵:');
disp(confMat);
