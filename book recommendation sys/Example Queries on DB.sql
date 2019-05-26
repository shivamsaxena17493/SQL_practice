select * from books 
where isbn in ( select isbn from authors 
	where author in (select  distinct author 
	from books_final.country_usa_pref_atq )) and available_qty > 1;


select bs.reader_id,r.name, sum(quantity) as total_books_bought 
from  books_sold bs , readers r
where bs.reader_id = r.reader_id
group by bs.reader_id order by total_books_bought desc;

select * from books where isbn in (
	select isbn from themes where theme in (
		 select distinct theme from books_final.gender_m_pref
	)
);

select  Year(bs.order_date) as Year, sum(quantity) as Books_Sold 
from  books_sold bs 
group by Year(bs.order_date) order by Books_Sold desc;


select  city,country, sum(quantity) as Books_Sold 
from  books_sold bs , readers r, cities c 
where r.reader_id = bs.reader_id 
and c.cities_id = r.cities_id
group by c.cities_id order by Books_Sold desc;


select  profession, sum(quantity) as Books_Sold 
from  books_sold bs , readers r
where r.reader_id = bs.reader_id and age > 20
group by r.profession order by Books_Sold desc;