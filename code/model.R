> data <- read.csv("model_set8_82.csv"); 
> data_s <- as.data.frame(data); 
> frel<-factor(data_s$release); 
> ftype<-factor(data_s$repo_type);
>  fit<-lm(I(log(data$vltr)) ~ I(data$ep_cmt) + I(log(data$sum_dvpr)) + I(log(data$sum_cmt)) + frel + ftype, data = data_s); summary(fit);

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

> 