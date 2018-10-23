/*We use Proc Sort to organize our data before presenting our final output such as plot the Waterfall graph or Merge with another dataset.*/

*basic syntax;
Proc Sort data=a out=b;
by variable1;
run;

/*I have 6 favorite ❤ options in Proc Sort:  By, Where, Nodupkey, Descending, Out, Dupout.*/

data car;
set sashelp.cars;
run;

*1.By: Sort the variables in the dataset according to the order of By ….;

Proc sort data=car;
by make model ;
run;

*2.Where: put a constraint in the sorting dataset;
suppose we would like to see the records only made by BMW;
Proc sort data=car(where=(make="BMW"));
by model;
run;

*3.Nodupkey: Remove the exactly duplicate records according to the By variable;
*Suppose we only care the brand and type of cars;
proc sort data=car nodupkey;
by make type;
run;


/*4. Descending: Sort the dataset in a descending order according to the By variable
Suppose we would like to see the car price in descending order*/
proc sort data=car ;
by descending msrp;
run;

/*5. Out:  Keep the original dataset and assign a new name the sorted data.
Suppose we would like to name the sorted car as “s_car“;*/
proc sort data=car out=s_car ;
by descending msrp;
run;

/*6. Dupout: Store the duplicated records
Suppose we would like to see the duplicated records from ex.3.*/
proc sort data=car nodupkey dupout=dcar;
by make type;
run;
