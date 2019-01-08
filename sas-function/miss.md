#### SAS Day 20: Miss function

There are two miss functions in SAS I really like, **NMISS and CMISS.**

#### Problem:

if we want to calculate the duration as aendt(Adverse Event End Date) — aestdt (Adverse Event Start Date). Ideally, we can use **adurn=aendt-aestdt +1**. However, in reality, we know there are high probabilities with missing AE dates.

**Background Knowledge:**

**NMISS** function is reserved for **numeric variables**.

**MISSING** and **CMISS** function can be used with **either character or numeric arguments.**

NMISS and CMISS count the number of arguments with missing values.

[caption id="attachment_1385" align="alignnone" width="500"]![image](http://upload-images.jianshu.io/upload_images/8699364-186c4da4d3d250d2.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

 [Engin_Akyurt](https://pixabay.com/users/Engin_Akyurt/) / Pixabay[/caption]


#### Solution:

1.  Basic Approach
```
if aendt^=. and aestdt^=. then adurn=aendt-aestdt+12
```

2\. NMISS function
```
if nmiss(aendt, astdt)=0 then
adurn=aendt-astdt+1
```

![](http://upload-images.jianshu.io/upload_images/8699364-6566bcf76162c53c.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


What if we want the Adverse Event Duration Time of the Patients’ with AE ends up in hospitalization?

3\. CMISS function

```
set ae;
if cmiss(aeshosp, aestdy, aeendt)=0
then adurn=aestdy-aeendt+1;
run;
```

![image](http://upload-images.jianshu.io/upload_images/8699364-bcc88c3e64c0f127.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


#### Summary:

Methods of selecting non-missing records:

1\. x neq. , x neq “ “, ***Miss(x)=0***
note: with Miss function, we don’t need to worry about the type of variables

2\. **NMISS**: good for selecting multiple numbers of non-missing numerical variables.
*e.g.* nmiss*(x1, x2,….*xn*)=0*

3\. **CMISS**: good for selecting multiple numbers of non-missing character or mixed variables.
*e.g.* cmiss*(*subjid*,* aestdy*,* aeendt*)=0*

**Happy Studying!!! ❄**
