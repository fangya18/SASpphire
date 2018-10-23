
/*COALESCEC:
Problem:
We want to select the non-missing value among qs1 to qs5 as QSSTRESN.*/

/*SAS Function Background:
COALESECEC:  Return the first non-missing Character String among the input variables
Syntax:  Coalescec(” “, “a ” )=a
*/

qsorres= strip(coalescec(qsorres1,qsorres2,qsorres3,qsorres4,qsorres5));

*Alternative solutions;
array values {*} $200 QS1 QS2 QS3 QS4 QS5;
do i =1 to dim(values);
if values{i} ne "" then QSORRES=strip(values{i});
end;
