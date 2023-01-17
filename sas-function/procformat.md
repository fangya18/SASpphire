Background Story:

The clinical study datasets usually have paired values for Character and Number, such as Sex and Sexn. However, sometimes the dataset only show the formatted values. If we don't have the original code, we need to apply Proc Format procedure to transform format values to the original values and make appropriate selections for analysis purposes .




Example:

We want to select the records of Item="shirt". 

Key idea: Proc Format to transform the format value back to the original Value.




Sample Code:

```
proc format lib=work.formats /*analyfmt*/ fmtlib ; 
  select Item /*any format you'd like to see*/;   
run;
```

Output:

Now we can select the desired records according to the original values. in our case, Item=1 (shirt). 




Extra Format Code:
```
proc format;
    value Item
    1="shirt"
    2="ties"
    3="suits"
    4="belts"
    5="shoes";
run;

data report;
   input Item 1 ;
   format Item Item. ; 
   datalines;
1 
2 
3
4 
5
;
run;
```
Thanks Marico to share this nice procedure with me!

Happy Studying!

Ref: 

https://support.sas.com/resources/papers/proceedings/proceedings/sugi27/p056-27.pdf
