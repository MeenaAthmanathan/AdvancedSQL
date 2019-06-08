select 
sum(case when dau_array[0] == 1 then 1 else 0 end) as total_new_count
,sum(case when dau_array[1] == 1 then 1 else 0 end) as total_recent_count
,sum(case when dau_array[3] == 1 then 1 else 0 end) as total_old_count
from
(SELECT  
user_id
,case when join_dt between '2019-06-01' and '2019-06-08' then array(1,0,0,0)
when join_dt between '2019-01-01' and '2019-05-31' then array(0,1,0,0)
else array(0,0,0,1)
end as dau_array
FROM user_table) a
