/*INDEX/INDEXC
Problem: 
We want to select all the MedDRA_PT contains “Acute leukemia”. such as Acute leukemia, Acute leukemia in remission.*/

/*INDEX function searches a character expression for a string of characters, and it returns the position of the string’s 
first character for the first occurrence of the string.

While theoretically, we use Index function to return the position of the string, most of the time, 
we use it to select whether a string exists in the variable.*/

data _null_;
a=index("xyz omy ooo","ooo");
put a=;
run; 
a=9

data luk;
set nl;
where  index(meddra_pt,"Acute leukaemia")>0;
run;

*INDEX/INDEXC;

data _null_;
a=indexc("hiphop dance","ai");
put a=;
b=index("hiphop dance", "ai");
put b=;
run; 
a=2
b=0
