> library(Matrix); library(MASS); library(lmerTest); library(lme4);library(stats)
> data <- read.csv("RQ3.2_glm.csv"); data_s <- as.data.frame(data); frel<-factor(data_s$release); ftype<-factor(data_s$repo_type); frepo<-factor(data_s$repo); 
> 
> lm <-lm(I(log(data$vltr)) ~ I(data$ep_cmt) + I(log(data$sum_dvpr)) + I(log(data$sum_cmt)) + frel + ftype, data = data_s); summary(lm);

Call:
lm(formula = I(log(data$vltr)) ~ I(data$ep_cmt) + I(log(data$sum_dvpr)) + 
    I(log(data$sum_cmt)) + frel + ftype, data = data_s)

Residuals:
    Min      1Q  Median      3Q     Max 
-1.6047 -0.3981  0.0443  0.3901  1.6798 

Coefficients:
                      Estimate Std. Error t value Pr(>|t|)    
(Intercept)           -0.84099    0.19456  -4.322 1.64e-05 ***
I(data$ep_cmt)         0.23939    0.04013   5.965 3.04e-09 ***
I(log(data$sum_dvpr))  0.51391    0.03241  15.857  < 2e-16 ***
I(log(data$sum_cmt))   0.12033    0.02243   5.365 9.37e-08 ***
frel2                 -0.17367    0.24886  -0.698 0.485361    
frel3                 -0.20810    0.26461  -0.786 0.431722    
frel4                 -0.02305    0.20645  -0.112 0.911102    
frel5                 -0.28040    0.19583  -1.432 0.152393    
frel6                 -0.38378    0.19076  -2.012 0.044412 *  
frel7                 -0.52422    0.18708  -2.802 0.005142 ** 
frel8                 -0.48333    0.18556  -2.605 0.009283 ** 
frel9                 -0.69909    0.18538  -3.771 0.000169 ***
frel10                -0.58837    0.18378  -3.201 0.001396 ** 
frel11                -0.60239    0.18363  -3.280 0.001060 ** 
frel12                -0.51533    0.18272  -2.820 0.004861 ** 
frel13                -0.52928    0.18260  -2.898 0.003803 ** 
frel14                -0.54458    0.18277  -2.980 0.002932 ** 
ftype2                 0.08922    0.11105   0.803 0.421849    
ftype3                 0.05518    0.08214   0.672 0.501840    
ftype4                -0.12695    0.11886  -1.068 0.285672    
ftype5                 0.01254    0.10167   0.123 0.901857    
ftype6                -0.01594    0.07943  -0.201 0.841027    
ftype7                -0.02591    0.07658  -0.338 0.735130    
ftype8                 0.13583    0.11314   1.200 0.230134    
ftype9                -0.00157    0.10482  -0.015 0.988049    
ftype10                0.18452    0.07958   2.319 0.020544 *  
ftype11                0.25923    0.09445   2.744 0.006132 ** 
ftype12                0.55647    0.14468   3.846 0.000125 ***
ftype13                0.11932    0.21106   0.565 0.571924    
ftype14               -0.13723    0.08940  -1.535 0.124983    
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.5557 on 1523 degrees of freedom
Multiple R-squared:  0.6404,	Adjusted R-squared:  0.6336 
F-statistic: 93.54 on 29 and 1523 DF,  p-value: < 2.2e-16


> nb_glm = glm.nb(data$vltr ~ data$ep_cmt + I(log(data$sum_dvpr))  + I(log(data$sum_cmt))  + frel + ftype, data=data_s); summary(nb_glm)

Call:
glm.nb(formula = data$vltr ~ data$ep_cmt + I(log(data$sum_dvpr)) + 
    I(log(data$sum_cmt)) + frel + ftype, data = data_s, init.theta = 18.19040733, 
    link = log)

Deviance Residuals: 
    Min       1Q   Median       3Q      Max  
-2.5663  -0.6331  -0.0762   0.4824   4.3704  

Coefficients:
                       Estimate Std. Error z value Pr(>|z|)    
(Intercept)           -1.347087   0.202834  -6.641 3.11e-11 ***
data$ep_cmt            0.355024   0.044499   7.978 1.48e-15 ***
I(log(data$sum_dvpr))  0.518054   0.035840  14.455  < 2e-16 ***
I(log(data$sum_cmt))   0.212817   0.025747   8.266  < 2e-16 ***
frel2                 -0.230855   0.267903  -0.862  0.38885    
frel3                 -0.260078   0.278288  -0.935  0.35001    
frel4                 -0.008363   0.207344  -0.040  0.96783    
frel5                 -0.185575   0.199768  -0.929  0.35292    
frel6                 -0.255065   0.194184  -1.314  0.18901    
frel7                 -0.553431   0.192575  -2.874  0.00406 ** 
frel8                 -0.403253   0.189738  -2.125  0.03356 *  
frel9                 -0.605731   0.190384  -3.182  0.00146 ** 
frel10                -0.497761   0.189416  -2.628  0.00859 ** 
frel11                -0.563779   0.189434  -2.976  0.00292 ** 
frel12                -0.459292   0.188431  -2.437  0.01479 *  
frel13                -0.468944   0.188139  -2.493  0.01268 *  
frel14                -0.492720   0.188071  -2.620  0.00880 ** 
ftype2                 0.001211   0.095197   0.013  0.98985    
ftype3                 0.017255   0.071813   0.240  0.81012    
ftype4                -0.141323   0.127154  -1.111  0.26638    
ftype5                 0.063075   0.096807   0.652  0.51469    
ftype6                 0.037769   0.073503   0.514  0.60736    
ftype7                 0.003214   0.072746   0.044  0.96476    
ftype8                 0.300011   0.115572   2.596  0.00943 ** 
ftype9                 0.018042   0.103725   0.174  0.86191    
ftype10                0.314564   0.068608   4.585 4.54e-06 ***
ftype11                0.242106   0.082407   2.938  0.00330 ** 
ftype12                0.711331   0.143340   4.963 6.96e-07 ***
ftype13                0.291623   0.310122   0.940  0.34704    
ftype14               -0.107982   0.094444  -1.143  0.25290    
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

(Dispersion parameter for Negative Binomial(18.1904) family taken to be 1)

    Null deviance: 5244.5  on 1552  degrees of freedom
Residual deviance: 1159.1  on 1523  degrees of freedom
AIC: 5897.7

Number of Fisher Scoring iterations: 1


              Theta:  18.19 
          Std. Err.:  2.81 

 2 x log-likelihood:  -5835.739 
> rem <- lmer(log(data$vltr) ~ (1|frepo) + data$ep_cmt + log(data$sum_dvpr) + log(data$sum_cmt) + frel, data=data_s, REML=FALSE); summary(rem);
Linear mixed model fit by maximum likelihood . t-tests use Satterthwaite's method ['lmerModLmerTest']
Formula: log(data$vltr) ~ (1 | frepo) + data$ep_cmt + log(data$sum_dvpr) +      log(data$sum_cmt) + frel
   Data: data_s

     AIC      BIC   logLik deviance df.resid 
  2391.3   2492.9  -1176.6   2353.3     1534 

Scaled residuals: 
     Min       1Q   Median       3Q      Max 
-2.86388 -0.60441  0.07595  0.67746  2.47893 

Random effects:
 Groups   Name        Variance Std.Dev.
 frepo    (Intercept) 0.09631  0.3103  
 Residual             0.21111  0.4595  
Number of obs: 1553, groups:  frepo, 384

Fixed effects:
                     Estimate Std. Error         df t value Pr(>|t|)    
(Intercept)        -7.670e-01  1.629e-01  1.468e+03  -4.708 2.74e-06 ***
data$ep_cmt         1.094e-01  4.019e-02  1.533e+03   2.723 0.006545 ** 
log(data$sum_dvpr)  5.835e-01  3.322e-02  1.497e+03  17.562  < 2e-16 ***
log(data$sum_cmt)   5.124e-02  2.319e-02  1.453e+03   2.209 0.027296 *  
frel2              -2.727e-01  2.089e-01  1.293e+03  -1.305 0.192058    
frel3              -3.573e-01  2.232e-01  1.300e+03  -1.601 0.109703    
frel4              -5.561e-03  1.763e-01  1.345e+03  -0.032 0.974848    
frel5              -2.184e-01  1.683e-01  1.365e+03  -1.298 0.194473    
frel6              -2.863e-01  1.642e-01  1.370e+03  -1.744 0.081434 .  
frel7              -3.858e-01  1.620e-01  1.390e+03  -2.381 0.017417 *  
frel8              -3.046e-01  1.611e-01  1.400e+03  -1.890 0.058939 .  
frel9              -5.403e-01  1.616e-01  1.414e+03  -3.343 0.000852 ***
frel10             -4.292e-01  1.606e-01  1.418e+03  -2.672 0.007615 ** 
frel11             -4.805e-01  1.607e-01  1.421e+03  -2.991 0.002833 ** 
frel12             -4.013e-01  1.598e-01  1.425e+03  -2.511 0.012155 *  
frel13             -4.008e-01  1.601e-01  1.436e+03  -2.504 0.012382 *  
frel14             -4.009e-01  1.604e-01  1.441e+03  -2.499 0.012570 *  
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
