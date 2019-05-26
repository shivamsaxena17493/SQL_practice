select CITY,CHAR_LENGTH(CITY) from STATION 
    where CHAR_LENGTH(CITY) =
        ( (select MAX(CHAR_LENGTH(CITY)) 
            from STATION ) 
        )
    order by CITY ASC 
    limit 1;

select CITY,CHAR_LENGTH(CITY) from STATION 
    where CHAR_LENGTH(CITY) =
        ((select MIN(CHAR_LENGTH(CITY)) 
            from STATION ) 
        )
    order by CITY ASC 
    limit 1;