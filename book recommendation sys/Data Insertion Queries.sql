UPDATE books_final.books SET available_qty = 1000 * RAND() WHERE available_qty=0;

UPDATE books_final.books SET price = 1000 * RAND() WHERE price=0;

UPDATE books_final.books
   SET pub_year = YEAR(DATE(NOW()) + INTERVAL -30 YEAR + INTERVAL RAND()*19 YEAR)
   WHERE pub_year = 0

INSERT INTO books_final.book_reviews (isbn, reader_id, rating, review_comments, review_date) 
VALUES (9781409090021, 6, 4, 'amazing book, well written', '2011-04-29');

INSERT INTO books_final.book_reviews (isbn, reader_id, rating, review_comments, review_date) 
VALUES (9781409090021, 6, 4, 'amazing book, well written', '2014-02-02'),
(9780143129516, 11, 3, 'One of my favorite authors. With passion about the drug epidemi.', '2013-04-11'),
(9780486474915, 3, 4, 'Watched the show, then read the book. Enjoyed both immensely. ', '2014-01-21'),
(9781408138724, 8, 3, 'You just can’t go wrong with a Harry read. While this jumped from not one but three different cases you never get lost or lose interest. ', '2010-09-18'),
(9781848940802, 7, 1, 'I wish connelly had put as much effort in the story line as he put into disparaging our president ', '2009-06-22'),
(9781635035995, 3, 5, 'GREAT BOOK, GREAT PRICE AND WELL PACKED ', '2011-01-12'),
(9780486474915, 2, 4, 'Not one investigation but two. Still the Best Detective Series I have ever read. Bravo', '2016-05-16');


INSERT INTO books_final.books_sold
(isbn, reader_id, order_date, quantity, total_cost) VALUES
( 9781409090021, 6, '2014-02-02', 1, 681),
( 9780143129516, 11, '2013-04-11', 1, 308),
( 9780486474915, 3, '2014-01-21', 1, 677),
( 9780486474915, 2, '2016-05-16', 1, 677),
( 9781408138724, 8, '2010-09-18', 2, 1182),
( 9781848940802, 7, '2009-06-22', 1, 62),
( 9781635035995, 3, '2011-01-12', 1, 903)

;



select isbn from CALL `books_final`.`GetRecForReader`(3);
