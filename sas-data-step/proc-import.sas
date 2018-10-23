/* Proc Import:
In clinical trials, we often have Special Interest Excel Sheet from Medical Writer that we need to use Proc Import 
to convert excel or csv data format into SAS dataset.
converting the excel files into SAS dataset, such as format issue, special characters, and DBMS base issue*/

/*Proc Import
Excel(.xls) file Remove Special Characters to _
Note: by setting validvarname=v7, we only allow Characters, Numbers, and _ */
options validvarname=v7 missing=''; 
proc import out=nl 
     datafile="/C/projects/ft/routine/data/external/Special Interest.xls"
     dbms=xls replace;
     *optional getnames=yes;
     *optional sheet="a";
     *optional guessword=50;
run;

/*Excel(2007) file including Special Characters
Note: by setting Validvarname=any, we allow any Special Characters*/
options validvarname=any;
proc import out = multi 
  datafile = "test.xlsx" 
  dbms = excel  replace;    
  *optional getnames = Yes; 
  *optional range="Sheet1$A1:A17" ;
run;

/* Proc Export
Although few times I have used Proc Export, I guess it is always nice to keep it in handy.*/

proc export data=mydata 
     outfile='c:dissertation/mydata.xlsx' dbms = xlsx replace;
run;
