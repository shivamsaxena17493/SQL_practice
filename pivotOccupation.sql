create view OCCUPATIONS_view as (
  select
    OCCUPATIONS.Name,
    case when Occupation = "Doctor" then Occupation end as Doctor,
    case when Occupation = "Professor" then Occupation end as Professor,
    case when Occupation = "Singer" then Occupation end as Singer
    case when Occupation = "Actor" then Occupation end as Actor
  from OCCUPATIONS
);

create view OCCUPATIONS_view_pivot as (
  select
    Cust_Names,
    sum(Computer) as Computer,
    sum(Monitor) as Monitor,
    sum(Software) as Software 
  from OCCUPATIONS_view
  group by Cust_Names
);

create view OCCUPATIONS_view_pivot_pretty as (
  select 
    Cust_Names, 
    coalesce(Computer, 0) as Computer, 
    coalesce(Monitor, 0) as Monitor, 
    coalesce(Software, 0) as Software
  from OCCUPATIONS_view_pivot
);