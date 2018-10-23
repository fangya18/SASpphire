
*PROC FREQ to summarize frequency count for the categorical variables, 
*such as Age Group(<=65, >65), SEX(female, male), RACE(Black, White, Asian), and patient Histology;

%macro freq(in= , var= , out1= ); 
proc freq data=&in noprint ; 
tables strtdose*&var /out=&out1 nopercent; 
run;
%mend freq;

*Age group;
%freq(in=adsl1, var=agegrpc, out1=a2); 

*Sex;
%freq(in=adsl1, var=sex1, out1=a3);

*show the response result for patients in each cycle;
%macro c;
%do i=1 %to 50;
proc freq data=pe3(where=(cycle=&i)) noprint ; 
tables trtan*response /out=out&i nopercent; 
run;
%end;
%mend c;
%c;

data cycresp;
set out1-out61;
proc sort; by sorter response;
run;
