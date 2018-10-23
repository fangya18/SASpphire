/*Problem
The pop dataset has 7 different dose level, we need to categorize the patients into 9 groups, in addition to the 7 different dose level, 
we need group 8 as the patients beyond max dose level (dose level 6,7), and group 9 for total patients. */

data pop2;
set pop pop(in=a where=(maxdose=1)) pop(in=b);
if strtdose ne “” then trtan = input(scan(strtdose,1),3.); 
if a then trtan=998;
if b then trtan=999;
length newid $ 25;
newid=strip(usubjid)||put(trtan,z3.);
run;

*Alternative solution;
data pop1;
set pop;
output;
strtdose=”ALL”;
output;
run;

data dosemtd;
set pop;
if strtdose in (“maxdose”) then do;
strtdose=”AT or above MTD”;
output;
end;
run;

data pop2;
set pop1 dosemtd;
run;

 
