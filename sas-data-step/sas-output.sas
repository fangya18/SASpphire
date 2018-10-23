*1.The most frequent use for OUTPUT is generating tables, we use Output statement to assign the overall treatment to every patient.

data adsl1;
set adsl;
output;
trtan=”ALL”;
output;
run; 

*2.We can also use OUTPUT to divide the datasets.
*For example, in Vital Sign dataset, if we need to divide the dataset by visit time1 and visit time2;

data vs1 vs2 vs3; 
set vs;
if vsdt=” ” and vsdt2=” ” and vstm=” ” and vstm2=” ” then output vs1;
if vsdt^=” ” or vstm^=” ” then output vs3;
if vsdt2^=” ” or vstm2^=” ” then output vs2;
run;
