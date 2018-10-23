/*Problem:
We want to assign values for QSSTRESN such that it matches with the variable QSTESTCD.
(E.g. QSTESTCD=”EQ5D01″, QSTRESN=QS1)
Desired Output:
USUBJID	QSTESTCD	QS1	QS2	QS3	QS4	QS5	QSSTRESN
TF001	EQ5D01	1	1	1	1	1	1
TF001	EQ5D02	1	1	2	1	1	1
TF001	EQ5D03	1	1	3	1	2	3
TF001	EQ5D04	1	2	1	1	1	1
TF001	EQ5D05	1	1	3	1	2	2
*/

array nvalue{*} QS1 QS2 QS3 QS4 QS5;
do i=1 to dim(nvalue);
if nvalue{i} ne “” then QSSTRESN=nvalue{i};
end;
