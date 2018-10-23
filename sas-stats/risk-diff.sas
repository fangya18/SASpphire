
/*Risk Difference is used to compare the proportions of 
successes between two independent groups with respect to a binary outcome. (cancer remission).
If the outcome is continuous, we compare the difference in means instead.*/

/*Example:
H0 (Null Hypotheses) :  p1- p2= 0 : there is no difference in outcomes between Treatment A and Placebo.*/

PROC FREQ DATA=adtte; 
where (trt01pn in (1 2 ));
BY avisitn ; 
TABLES trt01pn*aval / riskdiff(cl=wald) alpha=0.025; 
exact riskdiff;
RUN;

data riskci;
set riskci;
col1 = put(-riskdifference*100, 4.1);
keep avisitn col1;
run;

/*Interpretation:
We are 95% confident that the difference in proportion in Treatment A and Placebo is (9.2, 35.6), therefore we conclude the treatment outcome difference in success is significant.
Note: If we use the WALD option, we might get negative values for CI, which means, the difference is not significant.*/

*Thanks very much to Renee Wu;
