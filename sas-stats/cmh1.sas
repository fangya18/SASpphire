*CMH Test;
*H0: odds ratio ab(1)= odds ratio ab(2)= ……= odds ratio ab(k)=1

proc freq data=berkeley order=data;
weight count;
tables Sex*Accept/chisq relrisk;
tables Department*Sex*Accept/ cmh ;
run;

data berkeley;
input Department Sex Accept $ count;
cards;
DeptA Male Reject 313
DeptA Male Accept 512
DeptA Female Reject 19
DeptA Female Accept 89
DeptB Male Reject 207
DeptB Male Accept 353
DeptB Female Reject 8
DeptB Female Accept 17
DeptC Male Reject 205
DeptC Male Accept 120
DeptC Female Reject 391
DeptC Female Accept 202
DeptD Male Reject 278
DeptD Male Accept 139
DeptD Female Reject 244
DeptD Female Accept 131
DeptE Male Reject 138
DeptE Male Accept 53
DeptE Female Reject 299
DeptE Female Accept 94
DeptF Male Reject 351
DeptF Male Accept 22
DeptF Female Reject 317
DeptF Female Accept 24
;

/*Since the Chi-square P-value <0.0001, we conclude the Admission is gender biased. Furthermore, Odds ratio=0.54 
implies male is twice more likely to get an acceptance letter than female.

For CMH P-value=0.23, we conclude Department is independent of Admission and Gender.
Given Department, there is no consistent difference in proportion in the acceptance rate and Gender. 
The Common Odds ratio=1.102 supported our conclusion.*/
