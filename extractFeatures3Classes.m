function features = extractFeaturesCSP3Classes(X1, X2, X3, regularizationParam)
    % 为三个类别两两计算
    Sigma1 = cov(X1) + regularizationParam * eye(size(X1, 2));
    Sigma2 = cov(X2) + regularizationParam * eye(size(X2, 2));
    Sigma3 = cov(X3) + regularizationParam * eye(size(X3, 2));

    % 类别1和类别2
    [V12, ~] = eig(Sigma1, Sigma1 + Sigma2);
    W12 = V12(:, [1:3, end-2:end]);
    features12 = log(var(W12' * [X1; X2], [], 2));

    % 类别1和类别3
    [V13, ~] = eig(Sigma1, Sigma1 + Sigma3);
    W13 = V13(:, [1:3, end-2:end]);
    features13 = log(var(W13' * [X1; X3], [], 2));

    % 类别2和类别3
    [V23, ~] = eig(Sigma2, Sigma2 + Sigma3);
    W23 = V23(:, [1:3, end-2:end]);
    features23 = log(var(W23' * [X2; X3], [], 2));

    % 合并特征
    features = [features12; features13; features23];
end
