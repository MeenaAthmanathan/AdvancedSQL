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
listing_id
,market
,avg(price) as median_price
from
(select 
market
,listing_id
,price
,row_number() over(partition by market order by price) as price_index
,count(listing_id) over(partition by market) as per_market_count
from tbl) a
where
price_index in (floor((per_market_count+1)/2),floor((per_market_count+2)/2))
group by listing_id,market
