use [H.R ANALYTICS]
SELECT*
from dbo.HR_CLEANSED ;
SELECT
    COUNT(*) AS Total_Rows,

    SUM(CASE WHEN Performance IS NULL THEN 1 ELSE 0 END)
        AS Missing_Performance,

    SUM(CASE WHEN Experience IS NULL THEN 1 ELSE 0 END)
        AS Missing_Experience,

    SUM(CASE WHEN Salary IS NULL THEN 1 ELSE 0 END)
        AS Missing_Salary,

    SUM(CASE WHEN Experience < 0 THEN 1 ELSE 0 END)
        AS Negative_Experience,

    SUM(CASE WHEN Salary < 0 THEN 1 ELSE 0 END)
        AS Negative_Salary
FROM dbo.HR_CLEANSED;