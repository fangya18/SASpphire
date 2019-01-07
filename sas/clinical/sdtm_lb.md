SDTM Day 3 : LB, Laboratory Dataset


Last Time we introduced SDTM.LB for laboratory Test Results in Finding General Observation Class and Showed an example of how to merge with SV(Subject Visit) to get Epoch.

SDTM.LB is one of the most crucial datasets for Drug Safety Analysis, it could be challenging due to the vast amount of records.

This time we will introduce the General structure and Key Variable derivation for SDTM.LB


Create SDTM.LB Dataset Steps:
Read in LB raw data.
data lb1;
set raw.lb;
run;
Create Various Key Variables
Merge with SDTM.SV (Subject Visit) for Unscheduled Visit information.
Merge with SDTM.DM (Demographic) for Common Variable information.
Create Baseline Flag.
Remove empty records, label the variables and sort the records, get ready for Presentation!

leovalente / Pixabay
SDTM. LB Key Variable with Derivation Logic and Code Examples:
STUDYID, USUBJID, LBCAT, LBTEST, LBTESTCD, LBSEQ, LBORRES, LBORRESU, LBORNRLO, LBORNRHI, LBBLFL, LBTOX, LBTOXGR, LBDTC, LBDY, EPOCH, VISIT, VISITNUM

STUDYID, Study Identifier, Assigned Variable.

STUDYID="TF-001"



USUBJID, Unique Subject Identifier, Derived from raw.lb.SUBJID.

USUBJID=catx("-","TF-001",substr(SUBJID,1,5));


LBCAT, Category of Lab Test, Derived from CRF Collection.
E.g. Hematology, Blood Smear, Biochemistry, Urinalysis, Coagulation 

LBCAT= raw_lb.LBCATF


LBTEST, Lab Test or Examination Name,   Derived Variable.
E.g: Albumin, Bilirubin, Calcium, Glucose, Magnesium

LBTEST= raw_lb.LBTESTF


LBTESTCD, Lab Test or Examination Short Name, Derived Variable.
E.g: ALB, BILI, CAL, GLUC, MG

LBTESTCD=raw_lb.LBTESTCD


LBSEQ, Sequence Number, Derived.
A sequential number uniquely identifying the records within LB by USUBJID.

Data lbseq;
set lb;
by usubjid lbcat;
retain lbseq;
if first.usubjid then lbseq=1;
else lbseq=lbseq+1;
run;


LBORRES, Lab Result of Finding in Original Units, Derived Variable

LBORRES=raw_lb.lborres


LBORRESU, Original Lab Units
E.g: sec, g/L, IU/L, umol/L, 10^9/L

LBORRESU=raw_lb.lborresu


LBORNRLO, Lower Limit for Reference Range in the original Units.

LBORNRLO= raw_lb.lbstnlo


LBORNRHI, Higher Limit for Reference Range in the original Units.

LBORNRHI= raw_lb.lbsthi


LBBLFL, Baseline Flag, Last non-missing value before or On the treatment start day.

*Baseline Flag
data base;
set base1;
by usubjid lbcat lbtestcd lbdtn;
if last.lbtestcd;
lbblfl="Y";
if lbblfl=" " then delete;
run;

*Merge Back with the Previous LB dataset;
data lb7;
merge lb6(in=a) base(in=b);
if a;
by usubjid lbcat lbtestcd lbdtn lbstresc;
run;


LBTOX, Toxicity, Toxicity grades coded under CTCAE 4.03



LBTOXGR, Standard Toxicity Grade.
Note: different studies might have different standards.

if lbtestcd="BILI" then do;
if lborres<=uln then grade=0; 
else if lborres<=1.5*LBORNRLO then grade=1; 
else if lborres<=3.0*LBORNRLO then grade=2; 
else if lborres<=10*LBORNRLO then grade=3; 
else if lborres>10*LBORNRLO then grade=4; 
end;


LBDTC, Date and Time of Specimen Collections in ISO8601 format

LBDTC=input(raw_lb.lbdt, e8601da.);


LBDY,  Study Day of Specimen Collection. Derived from dm, demographic dataset RFSTDTC, reference start day.

if LBDTC< sdtm_dm.RFSTDTC then LBDY=LBDTC-RFSTDTC;
If LBDTC>= sdtm_dm.RFSTDTC then LBDY=LBDTC-RFSTDTC+1;



EPOCH, Derived base on SDTM.SE(Subject Elements) Start and End Day.

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


VISIT, Visit Name, derived from raw_lb.EVENT, for Unscheduled Visit, merge with SV(Subject Visit) by USUBJID, DATE

VISIT=raw_lb.event


VISITNUM, Visit Numer, derived from raw_lb.visitnum.



 Sample Dummy SDTM.LB Dataset:




This is a simple introduction for SDTM.LB data, in real life things could get a lot more tedious and complex. But no matter how difficult they are going to be, we are already started!

Happy Studying! 🤣


















