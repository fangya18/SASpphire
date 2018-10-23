/* Bonferroni Method
It is a stronger version of ANOVA; 
it is used for multiple hypothesis testing to find out the mean value of which pair treatments are significantly different from each other.
Null Hypothesis: x1=x2, x2=x3, …. ,xn=x1 */

/*Example:
Suppose we have 4 Treatment Group and Pain Score Value, we want to know which groups have significant mean values.*/

proc anova data=one ;
class treatment;
model value=treatment ;
means treatment / alpha=0.0125 bon cldiff;
run;

title “Mean Value by Treatment”;
proc sgplot data=two;
vbar treatment/response=mean
barwidth=0.6;
run;

/*From the ANOVA result, we can see Treatment 1-2, Treatment 2-4 and Treatment 1-3 have the significant difference in mean value.
Our plot visually supported the result as well.*/

*Thanks very much to Renee Wu for sharing the knowledge with me;
