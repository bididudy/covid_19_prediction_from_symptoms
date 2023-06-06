create database covid_tested_006;

use covid_tested_006;

create table clean_data 
(
Ind_Id INT, 
Test_date DATE, 
Cough_symptoms varchar(20), 
Fever varchar(20) ,
Sore_throat varchar(20), 
Shortness_of_breath varchar(20), 
Headache varchar(20), 
Corona varchar(20), 
Age_60_above varchar(20), 
Sex varchar(20), 
Known_contact varchar(30)
);

LOAD DATA INFILE "/Users/bididudy/Downloads/covid_clean_data_file.csv" 
INTO TABLE clean_data 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n' 
IGNORE 1 ROWS;

/* ---------------------------------------------------------------------------------------------------------------- */
# 1. Find the number of corona patients who faced shortness of breath.

select count(Ind_Id) as Patients
from clean_data 
where Corona = "positive" and Shortness_of_breath = "TRUE";

# Answer- 1162 patients.
/* ---------------------------------------------------------------------------------------------------------------- */
# 2. Find the number of negative corona patients who have fever and sore_throat. 

select count(Ind_Id) as Patients
from clean_data 
where Corona = "negative"  and Fever = "TRUE"  and Sore_throat = "TRUE";

# Answer- 121 patients.
/* ---------------------------------------------------------------------------------------------------------------- */
# 3. Group the data by month and rank the number of positive cases.

select monthname(Test_date) as Month,
count(Ind_Id) as positive, 
RANK() OVER(order by count(Ind_Id) DESC) AS 'rank'
from clean_data
where Corona = "positive"
group by monthname(Test_date);

# Answer- April month with 8863 cases.
/* ---------------------------------------------------------------------------------------------------------------- */
# 4. Find the female negative corona patients who faced cough and headache.

select * from clean_data
where Sex = "female" and Corona = "negative" and Cough_symptoms = "TRUE" and Headache = "TRUE";

# Answer- 32 patients.
/* ---------------------------------------------------------------------------------------------------------------- */
# 5. How many elderly corona patients have faced breathing problems?

select count(*)
from clean_data
where Age_60_above = "Yes" and Shortness_of_breath = "TRUE";

# Answer :- 286 patients 
/* ---------------------------------------------------------------------------------------------------------------- */
# 6. Which three symptoms were more common among COVID positive patients?

select 
	(select count(*) from clean_data 
    where Cough_symptoms = "TRUE" and corona = "positive") as Cough,
    
    (select count(*) from clean_data 
    where Fever = "TRUE" and corona = "positive") as Fever,
    
    (select count(*) from clean_data 
    where Sore_throat = "TRUE" and corona = "positive") as Sore_throat,
    
    (select count(*) from clean_data 
    where Shortness_of_breath = "TRUE" and corona = "positive") as short_Breath,
    
    (select count(*) from clean_data 
    where Headache = "TRUE" and corona = "positive") as headache,
    
    (select count(*) from clean_data 
    where corona = "positive") as positive
from clean_data
limit 1;

# Answer :- Cough_Symptoms, Fever and Headache 
/* ---------------------------------------------------------------------------------------------------------------- */
# 7. Which symptom was less common among COVID negative people?

select 
	(select count(*) from clean_data 
    where Cough_symptoms = "TRUE" and corona = "negative") as Cough_count,
    
    (select count(*) from clean_data 
    where Fever = "TRUE" and corona = "negative") as Fever_count,
    
    (select count(*) from clean_data 
    where Sore_throat = "TRUE" and corona = "negative") as Sore_count,
    
    (select count(*) from clean_data 
    where Shortness_of_breath = "TRUE" and corona = "negative") as shortBreath_count,
    
    (select count(*) from clean_data 
    where Headache = "TRUE" and corona = "negative") as headache_count,
    
    (select count(*) from clean_data 
    where corona = "negative") as negative_count
from clean_data
limit 1;

# Answer- Headache, Shortness of Breath, Sore throat.
/* ---------------------------------------------------------------------------------------------------------------- */
# Q.8 What are the most common symptoms among COVID positive males whose known contact was abroad? 

select 
	(select count(*) from clean_data 
    where Cough_symptoms = "TRUE" and corona = "positive" and Known_contact like '%Abroad%') as Cough,
    
    (select count(*) from clean_data 
    where Fever = "TRUE" and corona = "positive" and Known_contact like '%Abroad%') as Fever,
    
    (select count(*) from clean_data 
    where Sore_throat = "TRUE" and corona = "positive" and Known_contact like '%Abroad%') as Sore,
    
    (select count(*) from clean_data 
    where Shortness_of_breath = "TRUE" and corona = "positive" and Known_contact like '%Abroad%') as shortBreath,
    
    (select count(*) from clean_data 
    where Headache = "TRUE" and corona = "positive" and Known_contact like '%Abroad%') as headache,
    
    (select count(*) from clean_data 
    where corona = "positive"  and Known_contact like '%Abroad%') as positive
from clean_data
limit 1;

# Answer- Cough and Fever.

/* ---------------------------------------------------------------------------------------------------------------- */