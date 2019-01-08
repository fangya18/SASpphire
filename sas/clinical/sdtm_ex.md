#### **SDTM Day 5**:** SDTM.EX**

#### **Introduction:**

**Exposure dataset** contains the essence of subjects' **treatment information**, it is one of the key safety datasets, and it is critical to efficacy analysis. The EX domain is intended for "protocol-specified study treatments" including placebo dosing. The EX dataset would present a **complete and accurate of subjects' exposure** to the reviewers.

#### **SDTM.EX dataset building steps:**

1.  Read in the **Raw.EX** data and derive the key variables.
2.  Merge with **SDTM.DM** data for **common variables**
3.  Merge with **SDTM.SE** data for **Epoch**
4*.Compare with the production dataset

[caption id="attachment_1348" align="alignnone" width="500"]![image](http://upload-images.jianshu.io/upload_images/8699364-8d7d43723189ab60.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

 [Couleur](https://pixabay.com/users/Couleur/) / Pixabay[/caption]

#### **Key variables:**

STUDYID, USUBJID, EXDOSE, EXDOSU, EXDOSFRQ, EPOCH, EXTRT, EXGRPID,EXROUTE, EXLOT, EXSTDTC, EXENDTC, EXSTDY, EXENDY, EXTPT

**Key variables Derivation:**

**STUDYID,** Study Identifier, Assigned Variable. 
```
STUDYID="TF-001"
```
**USUBJID**, Unique Subject Identifier, Derived from raw.lb.SUBJID.
```
USUBJID=catx("-","TF-001",substr(SUBJID,1,5));
```
**EPOCH**, Derived Variable base on SDTM.SE(Subject Elements) Start and End Day
```
proc sql;
create table aeqc2 as
select a.*, b.epoch 
from aeqc1 as a left join se as b
on case when a.usubjid = b.usubjid and fl=. 
and b.sestdy <= a.aestdy < b.seendy then "a"
when a.usubjid=b.usubjid and fl=1 and 
b.sestdy <= a.aestdy <= b.seendy then "b"
end;
quit;
```

**EXTRT**,  Name of Actual Treatment, CRF variable

```
if shtreat=1 then extrt='PLACEBO';
else if shtreat in (2,3) then  extrt='SAR302503';
if missing(extrt) and missing(exdose) and missing(exstdtc) then delete;
```

**EXDOSE**,  Dose per Administration, Derived Variable
```
if armcd in("500MG"  "PL-400MG") then exdose = (actual dose)*100 
if armcd in("300MG") then exdose = ((actual dose)-1)*100
Note:Where (actual dose) is 0, exdose kept as 0\. Where (actual dose) is missing, exdose kept missing.
```

**EXDOSU**, Dose Units, Assigned Variable
**EXDOSFRQ**, Dosing Frequency per Interval
**EXROUTE**, Route of Administration
```
if _exdose ne . then do;
exdosu = "mg";
exdosfrq = "QD";
exroute = "ORAL";
end;
else do;
exdosu = "";
exdosfrq = " ";
exroute = "";
end;
```

**EXGRPID**, Group ID, eDT variable
```
exgrpid = strip(put(raw.subsetsn,best.));
```

**EXLOT**, Lot Number, CRF variable 
```
exlot=raw.ex.exnb
```

**EXSTDTC**, Start Date/ Time of Treatment

```
exstdtc= raw.exstdtc
```
**EXENDTC**, End Date/Time of Treatment
```
exendtc= raw.exendtc
```

**EXSTDY**, Study Day of Start of Treatment
```
If (EXSTDTC < DM.RFSTDTC) then EXSTDY=EXSTDTC-DM.RFSTDTC;
Else if (EXSTDTC >= DM.RFSTDTC) then EXSTDY=(EXSTDTC-DM.RFSTDTC)+1.
```

**EXENDY**, Study Day of End of Treatment
```
 If (EXSTDTC < DM.RFSTDTC) then EXENDY=EXSTDTC-DM.RFSTDTC; 
Else if (EXSTDTC >= DM.RFSTDTC) then EXENDY=(EXSTDTC-DM.RFSTDTC)+1.
```

**EXTPT**, Planned Time Point Name, eDT variable
```
extpt=raw.extpt
```

**EXSEQ**, Sequence Number, Derived Variable.
The sequential number uniquely identifying the records within the domain by USUBJID and generated using the key sequence from the domain level metadata.
```
Data exseq;
set ex;
by usubjid ;
retain aeseq EXTRT EXSTDTC EXENDTC  EXTPT;
if first.usubjid then exseq=1;
else exseq=exseq+1;
run;
```

**Sample SDTM.EX dummy dataset:**

![image](http://upload-images.jianshu.io/upload_images/8699364-a9f9949ddb9dc636.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)



HAPPY STUDYING!!💖
