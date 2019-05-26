-- to get the reader specific themes, qualities and authors books

DELIMITER $$
CREATE PROCEDURE `GetRecForReader` (IN reader_id Bigint)
BEGIN
select distinct b.isbn, title, pub_year, price
from books b, themes th, authors a, qualities q
	where b.isbn = th.isbn and 
          a.isbn = b.isbn and
          q.isbn = b.isbn and b.isbn in (
			-- books containing those qualities
			select distinct isbn from qualities where quality in (
				-- which qualities the reader prefers
				select distinct quality from qualities where isbn in (
					-- to retrieve the books specific reader liked
					select isbn from books_final.book_reviews where reader_id = reader_id and rating > 2
				)
			)
            union
            select distinct isbn from themes where theme in (                 
				-- which themes the reader prefers
				select distinct theme from themes where isbn in ( 
					-- to retrieve the books specific reader liked
					select isbn from books_final.book_reviews where reader_id = reader_id and rating > 2
				)
			)
			union
			select distinct isbn from authors where author in (                 
				-- which themes the reader prefers
				select distinct author from authors where isbn in ( 
					-- to retrieve the books specific reader liked
					select isbn from books_final.book_reviews where reader_id = reader_id and rating > 2
				)
			)

			) ;	
END
DELIMITER ;

-- to get the recommendations for reader with reader id 3
CALL `books_final`.`GetRecForReader`(3);

DELIMITER $$
CREATE PROCEDURE checkIsBought (IN new_isbn Bigint(13) ,IN new_reader_id Bigint(12)) 
BEGIN
 DECLARE counter int;
 select count(1) into counter from past_recommendation where isbn=new_isbn and reader_id = new_reader_id ;
    IF (counter > 0) THEN 
  		update past_recommendation pr set is_bought = 1
	    where pr.isbn = new_isbn and pr.reader_id = new_reader_id;
 END IF;
END$$
DELIMITER ;

--CALL `books_final`.`checkIsBought`(9780006473299, 2);



DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `getHighRatedBooks`(IN num_books INT)
BEGIN
	SELECT * FROM books_final.all_time_top_books limit num_books;
END$$
DELIMITER ;

-- to get the top 10 all time books
CALL `books_final`.`getHighRatedBooks`(10);


