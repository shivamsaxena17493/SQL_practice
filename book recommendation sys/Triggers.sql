

DELIMITER $$
 CREATE TRIGGER update_book_quantity AFTER INSERT ON books_sold 
 FOR EACH ROW 
   BEGIN
       UPDATE books 
       SET available_qty = available_qty - NEW.quantity 
       WHERE isbn = NEW.isbn;
    END;
$$
DELIMITER ;


DELIMITER $$
 CREATE TRIGGER update_is_bought AFTER INSERT ON books_sold 
 FOR EACH ROW 
   BEGIN
       CALL `books_final`.`checkIsBought`(NEW.isbn, NEW.reader_id);
    END;
$$
DELIMITER ;





