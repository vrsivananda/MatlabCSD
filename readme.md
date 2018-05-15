# Matlab CSD

This script is built from the methods outlined by Yi & Merfeld in their paper *[A quantitative confidence signal detection model: 1. Fitting psychometric functions](https://www.physiology.org/doi/10.1152/jn.00318.2015)*.

## Documentation

Make sure that you add the path to this folder such that your script can access it.

The main function to use is `startCSD`.
I.e. `startCSD(stimulusIntensity, confidenceJudgment);`

### Inputs
This function accepts two arguments:
1. stimulusIntensity 
   * This is an array of stimulus intensities (where each element is the intensity of a trial).
    * Range is [-infinity, infinity]
    * E.g. stimulusIntensity = [0.3, 0.5, -0.4, -0.1, 0.4];

2. confidenceJudgment
    * This is an array of confidence judgments (where each element is the confidence judgment of a trial).
    * Range is [0, 1]. If your confidence judgment is beyond this range, convert the confidence judgement to a scalar between 0 and 1.
    * This array will be converted to a binary array where <0.5 will be 0 and >=0.5 will be 1.
  
  
### Outputs
This function outputs an array of 6 values in the form: `[PsyMu, PsySigma, intialK, CSDMu, CSDSigma, finalK]`
1. PsyMu 
    * The value of Mu that is estimated by conventional psychometric methods (using binary forced-choice data instead of confidence judgment)
2. PsySigma 
    * The value of Sigma that is estimated by conventional psychometric methods (using binary forced-choice data instead of confidence judgment)
3. initialK 
    * The value of k (the scalar value) that is initially found by scaling the sigma to fit the psychometric function (See Yi & Merfeld, 2016, for more details.)
4. CSDMu 
    * The value of Mu that is estimated by the CSD method.
    * This is the main output of the CSD model, along with CSDSigma below.
5. CSDSigma 
    * The value of Sigma that is estimated by the CSD method.
    * This is the main output of the CSD model, along with CSDMu above.
6. finalK 
    * The value of k that is estimated by the CSD method.
  
 ### Examples
```matlab
stim = [0.3, 0.5, -1, 0.7, -0.2, -0.85];
conf = [0.7, 0.9, 0.1, 0.95, 0.3, 0.03];
[PsyMu, PsySigma, intialK, CSDMu, CSDSigma, finalK] = startCSD(stim, conf);
```

  