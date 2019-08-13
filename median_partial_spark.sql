val dataset = Seq(
  ("1","San Francisco","100"),
  ("2","San Francisco","200"),
  ("3","New York","250"),
  ("4","San Francisco","150"),
  ("5","New York","110"),
  ("6","San Francisco","140"),
  ("7","Boston","160"),
  ("8","New York","190"))
  .toDF("Listing_id", "Market", "Price")
  
  dataset.createOrReplaceTempView("tbl")
  
%sql
select
market,price,price_index,count
from
(select market
,price
,row_number() over (partition by market order by price) as price_index
from tbl)a
join
(select market,count(*) as cnt
from tbl group by market)b
on a.market = b.market
and a.price_index = round((cnt+1)/2)
