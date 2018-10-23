
/*Libname
Assign the name to the location we can fetch the data from.
Assign the name to the location we can store our data in.
*/
libname adam ‘C:\Users\fangya\Desktop\All\3study’ access = readonly;

/*1.Fetch Data
We can use set statement to read in any dataset we want.
Example: we want ADSL.*/

data adsl;
set adam.adsl;
run;

/*2. Store Data
We can use set statement to store any dataset in the location assigned to libname.
Example: we want to store final into adam library.*/

data adam.qcadsl;
set final;
run;
