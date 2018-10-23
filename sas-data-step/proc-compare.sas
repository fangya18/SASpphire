/*Proc Compare
 Problem: Suppose we need to compare the dataset Prod and QC.*/
 
/*Criterion: Set the compare decimal places.
E.g. criterion=0.001.

Var…With: Compare the attributes with different names.
E.g.  Var aval; With aval1;

Listall: List all the comparison results.

Id: Specify the compared order.
E.g: Id usubjid visitnum visdtc;

Out: Output a dataset for compared results.*/ 
 
Proc Compare Base=a Compare=b listall criterion=0.0001;
var x y z;
with a b c;
run;

proc compare base=prod compare=qc out=a criterion=0.001 listall;
var usubjid aval1 trt01pn;
with usubjid aval trtnum;
run;
