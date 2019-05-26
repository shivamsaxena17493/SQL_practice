-- Query the list of CITY names starting with vowels (i.e., a, e, i, o, or u) from STATION. Y
-- our result cannot contain duplicates.
select distinct CITY from STATION 
where CITY regexp '^[a,e,i,o,u]';

-- ending with vowel
select distinct CITY from STATION 
where CITY regexp '[a,e,i,o,u]$'

-- starting and ending with vowel
select distinct CITY from STATION 
where CITY regexp '^[a,e,i,o,u]' 
and CITY regexp '[a,e,i,o,u]$'

-- not starting with vowel
select distinct CITY from STATION 
where CITY not in (select distinct CITY from STATION 
where CITY regexp '^[a,e,i,o,u]');

-- not ending with vowel
select distinct CITY from STATION 
where CITY not in (select distinct CITY from STATION 
where CITY regexp '[a,e,i,o,u]$');

-- not starting and ending with vowel
select distinct CITY from STATION 
where CITY not in (select distinct CITY from STATION 
where CITY regexp '^[a,e,i,o,u]' 
and CITY regexp '[a,e,i,o,u]$')
