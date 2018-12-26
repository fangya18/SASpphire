#### **SAS Day 18: LOCF**

#### **Background:**

Clinical trial studies often spanned several years. What happens if patients did not participate the check such as Vital Sign(blood pressure, weight) or Lab value(white blood cell count, red blood cell count) on some of the time points and caused the missing data? 

The pharmaceutical industry standard method for imputing missing data is **LOCF** (Last Observation Carry Forward).

#### **Definition:** 

**LOCF** is used for missing data in repeated measures that have been taken per subject by time point. The **last observed non-missing value** is used to fill in missing values at **a later point** in the study.


#### **Example: LOCF with Lab dataset**

Original Dataset:

![image](http://upload-images.jianshu.io/upload_images/8699364-aac65340e15b2e90.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


**Solution**: 
1.  **Fill the Missings Values by LOCF.**

***Key procedures: Retain, By***

**Code:**
```
PROC SORT DATA=lab;
  BY usubjid lbtestcd avisitn;
RUN;

DATA locf;
  LENGTH dtype $15;
  RETAIN retain;
  SET lab;
  BY usubjid lbtestcd avisitn;
  IF FIRST.lbtestcd THEN retain=.;
  IF aval NE . THEN retain=aval;
   IF aval=. THEN DO;
    avallocf=retain;
    dtype='LOCF';
  END;
  ELSE avallocf=aval;
RUN;
```

**Output:**

![image](http://upload-images.jianshu.io/upload_images/8699364-fb4bbc2f4c556c5f.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


  2. Fill the missing value by LOCF except we do NOT carry the baseline value (visit 0)?

**Code:**
```
DATA locf1;
  LENGTH dtype $15;
  RETAIN retain;
  SET lab;
  BY usubjid lbtestcd avisitn;

  IF FIRST.lbtestcd and avisitn^=0 THEN retain=.;
  IF aval NE . and avisitn^=0 THEN retain=aval;   
  IF aval=. THEN DO;
    avallocf=retain;
    dtype='LOCF';
  END;
  ELSE avallocf=aval;

RUN;
```

**Output:**

![image](http://upload-images.jianshu.io/upload_images/8699364-f7b3d86db4074978.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

#### **Conclusion:**

As widely as the LOCF is used in clinical trial studies, it is not the elixir for any cases, for example, LOCF leads to serious biased results in **dementia** drug studies.  Because LOCF ignores whether the participant's condition was improving or deteriorating at the time of dropout but instead freezes outcomes at the value observed before dropout.

As the novice techniques developed in clinical trials, there are many other methods are used for missing value imputation, such as BOCF(best observation carry forward) WOCF( worst observation carry forward), and Multiple Imputation.

**Multiple Imputation** is the hottest imputation method, however, we barely see it in Oncology studies, can you guess why?

**Happy Studying! **🐷
