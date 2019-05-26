
select sum(tb.POPULATION) from 
    (select CITY.POPULATION from 
        CITY join COUNTRY 
            on CITY.CountryCode = COUNTRY.Code 
                where CONTINENT = 'Asia' ) as tb