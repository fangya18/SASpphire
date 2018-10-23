/*Problem: 
We want the select the non-missing death date (second date), however, if the death date is missing,
we will select the adverse event end date (first date) as the death date.
For example: 2008-04-21/2008-05-12*/

/*SCAN: separate a character value into words and return a specified word 
Example:*/
a= TF–BOY101000–001–1000
b=Scan (a, 3, ‘-‘);
/*Note: Take the third word separated by “-“.*/

/*TRANWRD: substitute strings for a certain part of the variable
Example:*/
Add=‘No.88 Keyuan Road’;
Add =TRANWRD (Add,’Road’,’Rd.‘);
/*Note: replace Road with Rd.
Return: No.88 Keyuan Rd. */

aeendth=tranwrd(aeendth,”/”,”|”);
deathdt=input(scan(aesdthd,-1,’|’),??IS8601DA.);

