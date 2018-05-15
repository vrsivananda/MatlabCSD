function output = stepsFtoH(x, confidence, binLimits, coherence)
    
    guessMu = x(1);
    guessSigma = x(2);
    guessK = x(3);

    % ==============================================
    % Step F: 

    % Preallocate matrix to hold lower limit (col 1) and upper limit (col 2) on
    % the decision variable (Xj lower and Xj upper)
    decisionVariableLimits = nan(length(confidence), 2);

    % Use a loop to calculate the lower limit and upper limit of decision
    % variables
    for i = 1:length(confidence)

        % Make sure that all values are > 0 and < 1. If they are out of the range, pull
        % them back in
        binLimits(binLimits < 0) = 0.0000000000000001;
        binLimits(binLimits > 1) = 0.9999999999999999;
        
        % Lower limits
        decisionVariableLimits(i,1) = inverseCumulativeGaussian([0, guessK*guessSigma], binLimits(i,1)); 
        % Upper limits
        decisionVariableLimits(i,2) = inverseCumulativeGaussian([0, guessK*guessSigma], binLimits(i,2));

    end

    % ==============================================
    % Step G: 


    % Calculate the probability of the specific confidence probability judgment
    % (Pj)
    % (Sj is the stimulus intensity/coherence at trial j)

    % Preallocate matrix to hold the confidence probability judgments for each
    % trial
    likelihood = nan(length(confidence),1);


    % Make a loop to go through each trial and calculate the
    % confidenceProbabilityJudgment (Pj)
    for i = 1:length(confidence)

        % Sj is the stimulus intensity/coherence at the current trial
        Sj = coherence(i);

        % Place lower and upper bounds of the confidence probability judgment
        % into variables for easy handling
        XjLower = decisionVariableLimits(i,1);
        XjUpper = decisionVariableLimits(i,2);

        % Calculate the upper and lower bound probabilities
        UpperLimitProbability = cumulativeGaussian(XjUpper,[Sj+guessMu, guessSigma]);
        LowerLimitProbability = cumulativeGaussian(XjLower,[Sj+guessMu, guessSigma]);

        % Calculate the probability for that interval and store it in the
        % likelihood array
        likelihood(i,1) = UpperLimitProbability - LowerLimitProbability;

    end
    
    logLikelihood = log(likelihood);
    
    % Since the fmincon seeks to minimize, but we want the logLikelihood 
    % to be maximized, we take the negative of the logLikelihood as the
    % output (to be minimized by fmincon)
    output = sum(-logLikelihood);

end