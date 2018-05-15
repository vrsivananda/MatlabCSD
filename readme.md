# Matlab CSD

This script is built from the methods outlined by Yi & Merfeld in their paper *[A quantitative confidence signal detection model: 1. Fitting psychometric functions](https://www.physiology.org/doi/10.1152/jn.00318.2015)*.

## Documentation

The main function to use is `startCSD`: <br>
I.e.  `startCSD(stimulusIntensity, confidenceJudgment);`

### Inputs
This function accepts two arguments:
1. **stimulusIntensity**
   * This is a vector of stimulus intensities (where each element is the intensity of a trial).
    * Range is [-infinity, infinity]
    * This represents the x-axis of the psychometric function

2. **confidenceJudgment**
    * This is a vector of confidence judgments (where each element is the confidence judgment of a trial).
    * Range is [0, 1]. If your confidence judgment is beyond this range, convert the confidence judgement to a scalar between 0 and 1.
    * This vector will be converted to a binary vector where <0.5 will be 0 and >=0.5 will be 1.
    * This represents the y-axis of the psychometric function
  
### Outputs
This function outputs an array of 6 values in the form: `[PsyMu, PsySigma, intialK, CSDMu, CSDSigma, finalK]`
1. **PsyMu** 
    * The value of Mu that is estimated by conventional psychometric methods (using binary forced-choice data instead of confidence judgment)
2. **PsySigma** 
    * The value of Sigma that is estimated by conventional psychometric methods (using binary forced-choice data instead of confidence judgment)
3. **initialK** 
    * The value of k (the scalar value) that is initially found by scaling the sigma to fit the psychometric function (See Yi & Merfeld, 2016, for more details.)
4. **CSDMu** 
    * The value of Mu that is estimated by the CSD method.
    * This is the main output of the CSD model, along with CSDSigma below.
5. **CSDSigma** 
    * The value of Sigma that is estimated by the CSD method.
    * This is the main output of the CSD model, along with CSDMu above.
6. **finalK** 
    * The value of k that is estimated by the CSD method.
    
    
## Notes

1. Make sure that you add the path to this folder such that your script can access it.

2. This function uses the **Cumulative Gaussian** for psychometric function fitting.
  
### Examples

Example where stimulus intensity is from -1 to 1, and confidence judgment is from 0 to 1:
```matlab
stimulusIntensity = [-0.70; 0.70; -0.70; -0.38; 0.54; -0.54; 0.54; -0.46; -0.46; -0.46; 0.50; -0.50; 0.50; 0.48; 0.48; 0.48; -0.49; -0.49; -0.49; -0.48];

confidenceJudgment = [ 0.23; 0.93; 0.00; 0.58; 0.58; 0.06; 0.61; 0.26; 0.46; 0.53; 0.74; 0.34; 0.75; 0.87; 0.72; 0.18; 0.09; 0.02; 0.12; 0.28];

[PsyMu, PsySigma, intialK, CSDMu, CSDSigma, finalK] = startCSD(stimulusIntensity, confidenceJudgment);
```

  