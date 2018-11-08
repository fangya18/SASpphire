proc sql;
  create table dummy as
  select a.*, b.epoch
  from dummy_vs as a left join dummy_se as b
  on case  when a.usubjid = b.usubjid
  and epoch="SCREENING"
and  b.sestdy <= a.vsdy < b.seendy then "screening"
when a.usubjid = b.usubjid
  and epoch="TREATMENT"
and  b.sestdy <= a.vsdy < b.seendy then "treat"
when a.usubjid = b.usubjid
  and epoch="FOLLOW-UP"
and  b.sestdy <= a.vsdy <= b.seendy then "follow"
end ;
quit;
