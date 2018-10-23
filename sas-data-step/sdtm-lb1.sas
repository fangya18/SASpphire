/*How to assign a VISIT to Lab records if the CPEVENT is “Unscheduled” ?*/

/*For the unscheduled visits, we merge with SV (Subject Visits) by Unique Subject ID(USUBJID) and Laboratory Test Date(LBDTC).*/

proc sql;
create table lb99_ as
select a.*, b.visitnum , b.visit
from lb99 as a left join sv99 as b
on a.usubjid = b.usubjid and 
b.svstdtc <= a.lbdtc <= b.svendtc;
quit;

*Depends on the category of drugs, LBCAT usual includes:
*Biochemistry, Blood Smear, Coagulation, Haematology, Urinalysis, and Other.
