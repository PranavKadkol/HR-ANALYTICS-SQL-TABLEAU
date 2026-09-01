USE [H.R ANALYTICS];
CREATE TABLE dbo.hr_staging
(
    Employee_ID VARCHAR(50) NULL,
    Full_Name VARCHAR(500) NULL,
    Department VARCHAR(100) NULL,
    Job_Title VARCHAR(500) NULL,
    Hire_Date VARCHAR(50) NULL,
    Performance VARCHAR(100) NULL,
    Experience VARCHAR(50) NULL,
    Status VARCHAR(50) NULL,
    Work_Mode VARCHAR(50) NULL,
    Salary VARCHAR(50) NULL,
    Year VARCHAR(50) NULL,
    Country VARCHAR(100) NULL,
    City VARCHAR(100) NULL,
    Age VARCHAR(50) NULL,
    Job_Level VARCHAR(100) NULL
);
bulk insert dbo.hr_staging
from 'C:\Users\Pranav Kadkol\OneDrive\Desktop\files\H.R analytics\data\raw\hr_raw.csv'
WITH(
    format = 'csv',
    firstrow = 2,
    fieldquote = '"',
    codepage  = '65001'
);
SELECT
    SUM(CASE WHEN Employee_ID IS NULL OR TRIM(Employee_ID) = '' THEN 1 ELSE 0 END) AS Employee_ID_Missing,
    SUM(CASE WHEN Full_Name IS NULL OR TRIM(Full_Name) = '' THEN 1 ELSE 0 END) AS Full_Name_Missing,
    SUM(CASE WHEN Department IS NULL OR TRIM(Department) = '' THEN 1 ELSE 0 END) AS Department_Missing,
    SUM(CASE WHEN Job_Title IS NULL OR TRIM(Job_Title) = '' THEN 1 ELSE 0 END) AS Job_Title_Missing,
    SUM(CASE WHEN Hire_Date IS NULL OR TRIM(Hire_Date) = '' THEN 1 ELSE 0 END) AS Hire_Date_Missing,
    SUM(CASE WHEN Performance IS NULL OR TRIM(Performance) = '' THEN 1 ELSE 0 END) AS Performance_Missing,
    SUM(CASE WHEN Experience IS NULL OR TRIM(Experience) = '' THEN 1 ELSE 0 END) AS Experience_Missing,
    SUM(CASE WHEN Status IS NULL OR TRIM(Status) = '' THEN 1 ELSE 0 END) AS Status_Missing,
    SUM(CASE WHEN Work_Mode IS NULL OR TRIM(Work_Mode) = '' THEN 1 ELSE 0 END) AS Work_Mode_Missing,
    SUM(CASE WHEN Salary IS NULL OR TRIM(Salary) = '' THEN 1 ELSE 0 END) AS Salary_Missing,
    SUM(CASE WHEN Year IS NULL OR TRIM(Year) = '' THEN 1 ELSE 0 END) AS Year_Missing,
    SUM(CASE WHEN Country IS NULL OR TRIM(Country) = '' THEN 1 ELSE 0 END) AS Country_Missing,
    SUM(CASE WHEN City IS NULL OR TRIM(City) = '' THEN 1 ELSE 0 END) AS City_Missing,
    SUM(CASE WHEN Age IS NULL OR TRIM(Age) = '' THEN 1 ELSE 0 END) AS Age_Missing,
    SUM(CASE WHEN Job_Level IS NULL OR TRIM(Job_Level) = '' THEN 1 ELSE 0 END) AS Job_Level_Missing
FROM dbo.hr_staging;

select 
Performance,
count(*) as employee_COUNT
from dbo.hr_staging
GROUP BY Performance
ORDER BY employee_COUNT DESC;

SELECT
employee_id,
COUNT(*) as id_count
FROM dbo.hr_staging
group by Employee_ID
having COUNT(*) > 1
order by id_count desc;

SELECT
department,
COUNT(*) as employee_COUNT
from dbo.hr_staging
GROUP BY Department
order by employee_COUNT desc;

select 
status,
count(*) as employee_status
from dbo.hr_staging
group by [Status]
order by employee_status;

SELECT
work_mode,
count(*)as employee_work_mode
from dbo.hr_staging
GROUP BY Work_Mode
order by employee_work_mode;

SELECT
performance,
COUNT(*) as employee_performance
from dbo.hr_staging
GROUP BY Performance
order by employee_performance DESC;

SELECT
job_level,
COUNT(*) as employee_job_level
from dbo.hr_staging
GROUP BY Job_Level
order by employee_job_level DESC;

select
MIN(cast(age as int)) as min_age,
max(cast(age as int)) as max_age,
min(cast(experience as int)) as min_experience,
max(cast(experience as int)) as max_experience,
min(cast(salary as decimal(12,2))) as min_salary,
max(cast(salary as decimal(12,2))) as max_salary
from dbo.hr_staging;

select count(*) as negative_experience_count
from dbo.hr_staging
where TRY_CONVERT(int,experience) < 0;

select count(*) as negative_salary_count
from dbo.hr_staging
where TRY_CONVERT(decimal(12,2),salary) < 0;

select*
from dbo.hr_staging
where try_convert(int,AGE) < 18
or try_convert(int,AGE) > 100;

select 
status,
count(*) as employee_count
from dbo.hr_staging
group by [Status]
order by employee_count DESC;

SELECT
Employee_ID,
salary AS negative_salary,
COUNT(*) OVER () AS negative_salary_count
FROM dbo.hr_staging
WHERE TRY_CONVERT(decimal(12,2), salary) < 0;

SELECT
    SUM(CASE
        WHEN TRY_CONVERT(INT, Experience) < 0
         AND TRY_CONVERT(DECIMAL(12,2), Salary) < 0
        THEN 1 ELSE 0
    END) AS Both_Negative,

    SUM(CASE
        WHEN TRY_CONVERT(INT, Experience) < 0
         AND TRY_CONVERT(DECIMAL(12,2), Salary) >= 0
        THEN 1 ELSE 0
    END) AS Only_Negative_Experience,

    SUM(CASE
        WHEN TRY_CONVERT(INT, Experience) >= 0
         AND TRY_CONVERT(DECIMAL(12,2), Salary) < 0
        THEN 1 ELSE 0
    END) AS Only_Negative_Salary
FROM dbo.hr_staging;

SELECT
    Employee_ID,
    Full_Name,
    Experience,
    Salary,
    Status,
    Job_Title,
    Department
FROM dbo.hr_staging
WHERE TRY_CONVERT(INT, Experience) < 0
   OR TRY_CONVERT(DECIMAL(12,2), Salary) < 0;

   SELECT
    Experience,
    Salary,
    COUNT(*) AS Record_Count
FROM dbo.hr_staging
WHERE TRY_CONVERT(INT, Experience) < 0
   OR TRY_CONVERT(DECIMAL(12,2), Salary) < 0
GROUP BY Experience, Salary
ORDER BY Record_Count DESC;