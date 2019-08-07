select start_date,end_date 
from
(SELECT Start_Date, End_Date, row_number() over(partition by start_date order by end_date) as row_rank
FROM 
    (SELECT Start_Date FROM Projects WHERE Start_Date NOT IN (SELECT End_Date FROM Projects)) a,
    (SELECT End_Date FROM Projects WHERE End_Date NOT IN (SELECT Start_Date FROM Projects)) b 
WHERE Start_Date < End_Date
)x
where row_rank = 1
ORDER BY DATEDIFF(day,start_Date, end_Date), Start_Date
