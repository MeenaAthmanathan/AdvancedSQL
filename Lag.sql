drop table if exists #timestamptest;
create table #timestamptest as
select distinct timestamp 'epoch' + imp_ts/1000 * interval '1 second' as  imprsn_ts,si,ss,rc
from impression_detail 
order by imp_ts
limit 100;

select si,ss,rc,imprsn_ts
//lag sets earliest record to null, next record is compared with previous record
,imprsn_ts - lag(imprsn_ts) over(partition by si order by imprsn_ts asc) as duration_since_last_rq
from #timestamptest
order by si,ss,imprsn_ts
