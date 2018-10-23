
*General Proc Report Syntax:

option orientation=landscape;  /* this code allows to print in landscape*/

proc report data=final nowindows missing headline headskip spacing=1 split=’|’ ;
/* change row when | shows up */

columns ( pageno skip ord2 var2 (“Starting Dose|__” ac1 ac2) ); 
/*columns: we list all the desired variables*/

define pageno / group order=internal noprint;
/*define: we define pageno by group, the order is the same as final dataset, and do not show pageno in the output */

define skip / group order=internal noprint;
define ord2 / group order=internal noprint;

define var2 / group order width=45 “Variable” id left flow ;
/*define: we assign var2 with length 45 characters start from the left, print header as “Variable”, and if there are mutliple groups we will only show the first var2 (order id). If var2 is more than 45 characters then it will automatically flow to next row (flow). */

define ac1 / display center width=14 “30 mg/day|(N=&n1.)”;
/*define: show ac1 in center with length 14, the header splits (|) into two row*/

define ac2 / display center width=14 “60 mg/day|(N=&n2.)”;
break after pageno / page;
/* start a new page based on pageno values */

break after skip / skip;
/* set an empty line when skip value changes */

run;

*RFT report
proc report data=final nowindows missing headline headskip spacing=1 split=’|’ style(header)=[just=left asis=on];
columns pageno skip ord2 var2 (“Starting Dose|  ^R/RTF’\brdrb\brdrs” ac1-ac2);
define pageno / group order=internal noprint;
define skip / group order=internal noprint;
define ord2 / group order=internal noprint;
define var2 / group display style(column)=[cellwidth=39% protectspecialchars=off  asis=on just=left] “Variable” left  ;
define ac1 / display style(column)=[cellwidth=30% protectspecialchars=off  asis=on just=left] “30 mg/day|(N=&n1.)”;
define ac2 / display display style(column)=[cellwidth=30% protectspecialchars=off  asis=on just=left] “60 mg/day|(N=&n2.)”;

break after pageno / page;
break after skip / summarize;
run;

#byvar: add in title to split report by assigned variables.

Footnote  “rundate=%sysfunc(date(), dtae9.)”
/*System macro generate the date, must use double quotation*/

*Break or Rbreak;
BREAK location variable/options; 
RBREAK location/options;

/*Break need a variable defined as Group or Order, Bbreak doesn’t*/

/*Location value: before, after
Options:
OL:  add a horizontal line above
DOL: add two horizontal lines above
UL: add a horizontal line below
DUL: add two horizontal lines below
Page: start a new page
Skip: add an empty line
Summarize: add an empty line in RTF
Suppress: dont show up

spacing=0: delete blank space in Report*/
