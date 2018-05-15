% alpha  = bias / mean / threshold / PSE
% beta   = slope = 1/sigma
% p(1)   = k = scaling factor
% gamma  = guess rate = 0
% lambda = lapse rate = 0

function pEst = psychometricFit1Parameter(x,y,alpha,beta)

    %   y  =        0.5*(erfc(-((1/k)   .*beta).*(x-alpha)./sqrt(2)));
    psyFit = @(p,a) 0.5*(erfc(-((1/p(1)).*beta).*(a-alpha)./sqrt(2)));
    
    % Get an estimate of the parameters from the function and guess values
    pEst = nlinfit(x,y,psyFit,1); % 1 is the initial value for k

end
