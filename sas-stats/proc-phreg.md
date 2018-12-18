
### SAS day 17: Proc Phreg

One day, my boss took a glance at a table with **Hazard Ratio** and **Median Survival Time** then he told me the program set the reference group in **Proc Phreg** wrong.

It turns out he was correct after validating the program. However, I was very curious about how did he figure it out by an Augenblick. Then he shared with us some knowledge about **Hazard Ratio** and **Proc Phreg**.

#### **Background knowledge**

*Hazard Ratio*: HRs represent instantaneous risk over the study time period.

*Median Survival Time:* The time after which 50 percent of people with a particular condition are still living, and 50 percent have died.

**Median survival time and Hazard Ratio** 

**if Median(A) > Median(B) then HR(A) < HR(B), vice versa.** 

Without Loss of Generality, if the median survival time of group A is significantly higher than group B, then Hazard Ratio of group A is smaller than Hazard Ratio of group B, vice versa.

[caption id="attachment_1056" align="alignnone" width="750"]![image](http://upload-images.jianshu.io/upload_images/8699364-607f96067e196651.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

 [qimono](https://pixabay.com/users/qimono/) / Pixabay[/caption]

#### **Example  **

Now we will demonstrate Proc Phreg with Hazard Ratio with **Sashelp.BMT** dataset. 

Basic Proc Phreg Syntax

<pre class="EnlighterJSRAW" data-enlighter-language="sql" data-enlighter-highlight="2,4">Proc phreg data=a;
class x ; /*ref(x) only character value, the lowest character value is reference*/
model x*y= a/rl ; /*can input more than one variable on the RHS of the equation. rl:risk limit (eßt)*/
by z;/*optional*/ 
id m;/*optional*/
run;</pre>

1.  Read in the sashelp.BMT dataset and only consider AML Low Group and AML High Group
    *Note: Hazard Ratio is usually designed for two-level comparison,*
    *we will introduce* 3-level *comparison next time.*

<pre class="EnlighterJSRAW" data-enlighter-language="sql">data aml;
set sashelp.bmt;
if group="AML-Low Risk" then ref="0";
if group="AML-High Risk" then ref="1";
if ref in("0","1");
run;</pre>

![image](http://upload-images.jianshu.io/upload_images/8699364-34f88a4921b254ae.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

       2.  Apply Proc Phreg to generate the hazard ratio

<pre class="EnlighterJSRAW" data-enlighter-language="sql" data-enlighter-highlight="2,3">proc phreg data=aml outest=est61 covout;
class ref;
model T*status(0)=ref/rl;
run;</pre>

![image](http://upload-images.jianshu.io/upload_images/8699364-f66ba7ff5c902281.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

**Results:**

From the output, we have **Hazard Ratio=0.39**, which means the probability a patient in AML high Group survives until today and will survive until tomorrow, compared with the AML Low Group **Reduced by 0.39**.  

**Validation:**

As we mentioned earlier, if Hazard Ratio <1 then we expected a longer survival median time in AML Low Group. The following Kaplan Meier plot demonstrated the AML Low Group indeed has a larger survival median. 

![image](http://upload-images.jianshu.io/upload_images/8699364-84def8f5ace4cb07.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

<pre class="EnlighterJSRAW" data-enlighter-language="python">proc lifetest data=aml plots=survival;
time T*status(0);
strata Group;
run;</pre>

Thanks very much to Joe wang to share the Proc Phreg knowledge with me, we will show the 3-level Hazard Ratio in Proc Phreg next time!

**Happy studying! 🐰**
