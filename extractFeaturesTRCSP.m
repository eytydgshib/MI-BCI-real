function features = extractFeaturesTRCSP(data, TRCSPFilters)
    
    CSPData = data * TRCSPFilters;

    features = log(var(CSPData));

    features = reshape(features, 1, []);
end
