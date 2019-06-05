--redshift temp table
drop table if exists #lagtest;
create table #lagtest as
select distinct timestamp 'epoch' + imp_ts/1000 * interval '1 second' as  imprsn_ts,cookie_id,session_id,request_id
from impression_detail 
order by imp_ts
limit 100;

select cookie_id,session_id,request_id,imprsn_ts
--lag sets earliest record to null, next record is compared with previous record
,imprsn_ts - lag(imprsn_ts) over(partition by cookie_id order by imprsn_ts asc) as duration_since_last_rq
from #lagtest
order by cookie_id,session_id,imprsn_ts
