function output = startCSD(stimulusIntensity, confidenceJudgment)

    opts = optimset('fminsearch');
    opts.TolX = 1.e-4;
    opts.TolFun = 1.e-4;
    
    % Convert confidence to binary
    binaryChoice = confidenceJudgment >= 0.5;
    
    % ==============================================
    % Step B:

    % This is the Psychometric function that we will use
    disp('-------------------------------------');
    disp('Psychometric function on binomial data with 0 guess and 0 lapse rates:');
    disp('    mean      slope');
    % Fitting to binary forced choice data:
    parametersPsychometricFn = psychometricFit2Parameters(stimulusIntensity,binaryChoice);
    disp(parametersPsychometricFn);

    % Store what we need in variables
    mu = parametersPsychometricFn(1);
    slope = parametersPsychometricFn(2);
    sigma = 1/slope;

    % ==============================================
    % Step C:

    % This is the function that we will use
    disp('-------------------------------------');
    disp('Confidence function with only k as the free parameter');
    disp('    scalar');
    parametersConfidenceFn = psychometricFit1Parameter(stimulusIntensity,confidenceJudgment,mu,slope);
    disp(parametersConfidenceFn);

    k = parametersConfidenceFn;

    % ==============================================
    % Step D:

    % Preallocate for matrix to hold lower bin limit (col 1) and upper bin limit
    % (col 2)
    binLimits = nan(length(confidenceJudgment),2);

    % Fill in the bin
    binLimits(:,1) = confidenceJudgment(:,1) - 0.005;
    binLimits(:,2) = confidenceJudgment(:,1) + 0.005;


    % ==============================================
    % Step E:

    % Assignment has been done above in steps B and C.
    % mu sigma k

    %The initial guessing values for fmincon, to be varied
    x0 = [mu, sigma, k]

    % ==============================================
    % Steps F to H:

    % Create an anonymous function to be used in fmincon
    % This gets us around the problem where some variables need to be fixed (the
    % original mu, sigma,and k) and others need to be changed to be optimized
    % (those in x0).
    f = @(x) stepsFtoH(x,confidenceJudgment,binLimits,stimulusIntensity);


    % ==============================================
    % Step I
    % [finalX,fval, exitflag, output, lambda, grad, hessian] = fmincon(f,x0,[],[],[],[],[-0.5 0 0],[0.5 3 30]);
    finalX = fminsearchbnd(f,x0,[-0.5 0 0],[0.5,3,10],opts);

    finalMu = finalX(1);
    finalSigma = finalX(2);
    finalK = finalX(3);

    % ==============================================
    
     output = [mu, sigma, k, finalMu, finalSigma, finalK];