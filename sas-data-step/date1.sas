*Problem 1 :   From date Format(Character) 11-APR-2008 to Format(Character)  2008-04-11;

pedt1=compress(pedt, ‘-‘);
pedt2= input(pedt1, date9.);
pedt3= put(pedt2,yymmdd10.);

*Convert Month: Jan, Feb, Mar… into 01, 02, 03 … or 1,2,3 ….;
mhdmm1=month(input(cats(’01’,mhdmm,’2013′),date9.))
if . < mhdmm1 <10 then mhdmm2= compress(“0” || put(mhdmm1,2.))
if mhdmm1>9 then mhdmm2=put(mhdmm1,2.);
rfstdt=input(scan(rfstdtc,1,’T’),??IS8601DA.);

*Problem3 2012-07-09 to Numeric Date;
format qsdt date9.;
qsdate= substr(qsdtc,1,10);
qsdt= input(qsdate, yymmdd10.);

*Last Reminder: always add FORMAT for the desired output!
