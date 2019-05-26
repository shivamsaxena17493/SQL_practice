
-- View for getting the ranked books for specific themes as per the avg reader rating
-- view 1
CREATE OR REPLACE VIEW all_time_top_books AS 
select br.isbn, title, author, theme,  quality,pub_year, price, avg(rating) as avg_reader_rating
from book_reviews br, books b, themes th, authors a, qualities q
	where b.isbn = th.isbn and 
		  br.isbn = b.isbn and
          a.isbn = b.isbn and
          q.isbn = b.isbn
	group by br.isbn
	order by rating desc

-- view 2
-- to get the recommendations based on reader id
CREATE OR REPLACE VIEW reader_id_past_reviews_based_rec_books AS
select b.isbn, title, pub_year, author, theme, quality, price
from books b, themes th, authors a, qualities q
	where b.isbn = th.isbn and 
          a.isbn = b.isbn and                    
          q.isbn = b.isbn and b.isbn in (
			-- books containing those qualities
			select distinct isbn from qualities where quality in (
				-- which qualities the reader prefers
				select distinct quality from qualities where isbn in (
					-- to retrieve the books specific reader liked
					select isbn from books_final.book_reviews where reader_id = 3 and rating > 2
				)
			)
            union
            select distinct isbn from themes where theme in (                 
				-- which themes the reader prefers
				select distinct theme from themes where isbn in ( 
					-- to retrieve the books specific reader liked
					select isbn from books_final.book_reviews where reader_id = 3 and rating > 2
				)
			)
			union
			select distinct isbn from authors where author in (                 
				-- which themes the reader prefers
				select distinct author from authors where isbn in ( 
					-- to retrieve the books specific reader liked
					select isbn from books_final.book_reviews where reader_id = 3 and rating > 2
				)
			)

			) ;	

-- view 3
CREATE OR REPLACE VIEW gender_M_pref AS
select author, theme, quality
from books b, themes th, authors a, qualities q
	where b.isbn = th.isbn and 
          a.isbn = b.isbn and
          q.isbn = b.isbn and b.isbn in (
		-- Gender preference books from book sold
		select bs.isbn from readers r, books_sold bs
		where r.reader_id = bs.reader_id 
		-- Male preference
			and gender = 'M' 
) and th.rank < 3 and a.rank < 3 and q.rank < 3

-- view 4

CREATE OR REPLACE VIEW unemployed_teenage_pref_atq AS
select author, theme, quality
from books b, themes th, authors a, qualities q
	where b.isbn = th.isbn and 
          a.isbn = b.isbn and
          q.isbn = b.isbn and b.isbn in (
	select isbn from books where isbn in (
		-- Teen Age - Cheap preference books from book sold
		select bs.isbn from readers r, books_sold bs
		where r.reader_id = bs.reader_id 
			and age between 13 and 20
            and profession = ''
	)
) and th.rank < 3 and a.rank < 3 and q.rank < 3


---view 5
-- view containg country regional preference
CREATE OR REPLACE VIEW country_usa_pref_atq AS
select author, theme, quality
	from books b, themes th, authors a, qualities q
		where b.isbn = th.isbn and 
	          a.isbn = b.isbn and
	          q.isbn = b.isbn and b.isbn in (
			-- Books which are preferred
			select isbn from readers r, books_sold bs where 
				-- Readers from Specific Country
				r.reader_id = bs.reader_id and cities_id in (
					select cities_id from books_final.cities 
				    -- Country Preference
				    where country = 'usa'
			)
) and th.rank < 3 and a.rank < 3 and q.rank < 3


-- 6
-- view containing books having sold most copies
CREATE OR REPLACE VIEW all_time_most_bought AS
select b.isbn, title, pub_year, price , available_qty, count(bs.isbn) as order_cnt
	from books_sold bs, books b
    where bs.isbn  = b.isbn
		group by bs.isbn 
        order by order_cnt desc



-- top cheap books
-- most bought books
-- seasonal books
-- all_time_low_cost_books 