% p(1) = alpha  = bias / mean / threshold / PSE
% p(2) = beta   = slope
% p(3) = gamma  = guess rate = 0
% p(4) = lambda = lapse rate = 0

function pEst = psychometricFit2Parameters(x,y)

    %   y  =     gamma+(1-gamma-lambda)*0.5*erfc(-beta.*(x-alpha)./sqrt(2));
    psyFit = @(p,a) 0.5*(erfc((-p(2)).*(a-p(1))./sqrt(2)));
    
    % Get an estimate of the parameters from the function and guess values
    pEst = nlinfit(x,y,psyFit,[0, 1]);
    
end
