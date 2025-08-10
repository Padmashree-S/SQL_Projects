/* Question 1
   Find the total milk production for the year 2023 */

select SUM(Value) 
from milk_production mp
where Year = 2023;



/* Question 2
   Show coffee production data for the year 2015. What is the total value? */

select Value
from coffee_production cp
where Year = 2015;



/* Question 3
   Find the average honey production for the year 2022 */

select *, AVG(Value)
from honey_production hp
where Year = 2022;



/* Question 4
   Get the state names with their corresponding ANSI codes from the state_lookup table. What number is Iowa? */

select *
from state_lookup sl;

select *
from state_lookup sl 
where State = 'IOWA';



/* Question 5
   Find the highest yogurt production value for the year 2022 */

select MAX(Value)
from yogurt_production yp
where year = 2022;



/* Question 6
   Find states where both honey and milk were produced in 2022. Did State_ANSI "35" produce both honey and milk in 2022? */

select  DISTINCT hp.State_ANSI
from honey_production hp
inner join milk_production mp on hp.State_ANSI = mp.State_ANSI
And hp.Year = mp.Year
Where hp.Year = 2022 And mp.Year = 2022;

select  CASE
	WHEN EXISTS(
		select 1
		from honey_production hp
		inner join milk_production mp on hp.State_ANSI = mp.State_ANSI
			And hp.Year = mp.Year
	where hp.Year = 2022
			And hp.State_ANSI = 35 )
	THEN 'Yes'
	ELSE 'No'
	END AS Produced_Both;



/* Question 7
   Find the total yogurt production for states that also produced cheese in 2022 */

select SUM(yp.Value) AS total_yogurt_production, yp.State_ANSI
from yogurt_production yp 
inner join cheese_production cp on yp.State_ANSI = cp.State_ANSI 
and cp.Year = 2022
where yp.Year = 2022;



/* Question 8
   Can you find out the total milk production for 2023? Your manager wants this information for the yearly report.
   What is the total milk production for 2023? */

select SUM(Value) 
from milk_production mp
where Year = 2023;



/* Question 9
   Which states had cheese production greater than 100 million in April 2023? The Cheese Department wants to focus their marketing efforts there. 
   How many states are there? */

select DISTINCT cp.State_ANSI, sl.State
from cheese_production cp
left join state_lookup sl on cp.State_ANSI  = sl.State_ANSI
where Period = 'APR' and Year = 2023 and Value > 100000000;



/* Question 10
   Your manager wants to know how coffee production has changed over the years. 
   What is the total value of coffee production for 2011? */

select *
from coffee_production cp
where Year = 2011;



/* Question 11
   There's a meeting with the Honey Council next week. Find the average honey production for 2022 so you're prepared. */

select AVG(Value)
from honey_production hp
where Year = 2022;



/* Question 12
   The State Relations team wants a list of all states names with their corresponding ANSI codes. Can you generate that list?
   What is the State_ANSI code for Florida? */

select *
from state_lookup sl;

select *
from state_lookup sl 
where State = 'FLORIDA';



/* Question 13
   For a cross-commodity report, can you list all states with their cheese production values, even if they didn't produce any cheese in April of 2023?
   What is the total for NEW JERSEY? */

SELECT 
    sl.State,
    cp.State_ANSI,
    cp.Value
FROM state_lookup sl
LEFT JOIN cheese_production cp 
    ON sl.State_ANSI = cp.State_ANSI
    AND cp.Year = 2023
    AND cp.Period = 'APR'
ORDER BY sl.State;


SELECT 
    sl.State,
    SUM(cp.Value) AS total_cheese_production
FROM state_lookup sl
LEFT JOIN cheese_production cp 
    ON sl.State_ANSI = cp.State_ANSI
    AND cp.Year = 2023
    AND cp.Period = 'APR'
WHERE sl.State = 'NEW JERSEY';



/* Question 14
   Can you find the total yogurt production for states in the year 2022 which also have cheese production data from 2023? 
   This will help the Dairy Division in their planning. */



SELECT SUM(yp.Value) AS total_yogurt_production
FROM yogurt_production yp
INNER JOIN cheese_production cp ON yp.State_ANSI = cp.State_ANSI
WHERE yp.Year = 2022
AND cp.Year = 2023;


/* Question 15
   List all states from state_lookup that are missing from milk_production in 2023.
   How many states are there? */

select count(*) as missing_states_count
from state_lookup sl 
left join milk_production mp  on sl.State_ANSI  = mp.State_ANSI 
and mp.Year = 2023
where mp.State_ANSI IS NULL;



/* Question 16
   List all states with their cheese production values, including states that didn't produce any cheese in April 2023.
   Did Delaware produce any cheese in April 2023? */

SELECT 
    sl.State,
    cp.State_ANSI,
    cp.Value
FROM state_lookup sl
LEFT JOIN cheese_production cp 
    ON sl.State_ANSI = cp.State_ANSI
    AND cp.Period = 'APR'
    AND cp.Year = 2023;

SELECT 
    CASE 
        WHEN cp.Value IS NOT NULL THEN 'Yes'
        ELSE 'No'
    END AS delaware_produced_cheese
FROM state_lookup sl
LEFT JOIN cheese_production cp 
    ON sl.State_ANSI = cp.State_ANSI
    AND cp.Period = 'APR'
    AND cp.Year = 2023
WHERE sl.State = 'Delaware';



/* Question 17
   Find the average coffee production for all years where the honey production exceeded 1 million. */

select AVG(cp.Value) as average_coffee_production
from coffee_production cp
inner join honey_production hp on cp.State_ANSI  = hp.State_ANSI
and cp.Year = hp.Year
where hp.Value > 1000000;