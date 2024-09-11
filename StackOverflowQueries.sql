SELECT
    Respondent,  -- Assuming there's an ID column

    -- Convert job satisfaction text to numeric values
    CASE 
        WHEN JobSatisfaction = 'Extremely satisfied' THEN 7
        WHEN JobSatisfaction = 'Moderately satisfied' THEN 6
        WHEN JobSatisfaction = 'Slightly satisfied' THEN 5
        WHEN JobSatisfaction = 'Neither satisfied nor dissatisfied' THEN 4
        WHEN JobSatisfaction = 'Slightly dissatisfied' THEN 3
        WHEN JobSatisfaction = 'Moderately dissatisfied' THEN 2
        WHEN JobSatisfaction = 'Extremely dissatisfied' THEN 1
        ELSE NULL  -- Handle any unexpected values
    END AS job_satisfaction_score,

    -- Create binary columns for each programming language
    CASE WHEN `Lang(clean)` LIKE '%C%' THEN 1 ELSE 0 END AS C,
    CASE WHEN `Lang(clean)` LIKE '%C++%' THEN 1 ELSE 0 END AS Cpp,
    CASE WHEN `Lang(clean)` LIKE '%Java%' THEN 1 ELSE 0 END AS Java,
    CASE WHEN `Lang(clean)` LIKE '%Matlab%' THEN 1 ELSE 0 END AS Matlab,
    CASE WHEN `Lang(clean)` LIKE '%R%' THEN 1 ELSE 0 END AS R,
    CASE WHEN `Lang(clean)` LIKE '%SQL%' THEN 1 ELSE 0 END AS `SQL`,
    CASE WHEN `Lang(clean)` LIKE '%Bash/Shell%' THEN 1 ELSE 0 END AS Bash_Shell,
    CASE WHEN `Lang(clean)` LIKE '%Python%' THEN 1 ELSE 0 END AS Python,
    CASE WHEN `Lang(clean)` LIKE '%HTML%' THEN 1 ELSE 0 END AS HTML,
    CASE WHEN `Lang(clean)` LIKE '%Assembly%' THEN 1 ELSE 0 END AS Assembly,
    CASE WHEN `Lang(clean)` LIKE '%CoffeeScript%' THEN 1 ELSE 0 END AS CoffeeScript,
    CASE WHEN `Lang(clean)` LIKE '%PHP%' THEN 1 ELSE 0 END AS PHP
    
    
    
    

FROM
    surveyclean;
    
------------------------------------------

SELECT
    country,
    AVG(
        CASE 
            WHEN JobSatisfaction = 'Extremely satisfied' THEN 7
			WHEN JobSatisfaction = 'Moderately satisfied' THEN 6
			WHEN JobSatisfaction = 'Slightly satisfied' THEN 5
			WHEN JobSatisfaction = 'Neither satisfied nor dissatisfied' THEN 4
			WHEN JobSatisfaction = 'Slightly dissatisfied' THEN 3
			WHEN JobSatisfaction = 'Moderately dissatisfied' THEN 2
			WHEN JobSatisfaction = 'Extremely dissatisfied' THEN 1
            ELSE NULL
        END
    ) AS avg_job_satisfaction
FROM
    surveyclean
GROUP BY
    country;
    
    
    ------------------------------------------
    
    SELECT 
	JobSatisfaction,
    SalaryType,
    ConvertedSalary,
    CASE 
		WHEN SalaryType = 'Weekly' THEN ConvertedSalary * 53
        WHEN SalaryType = 'Monthly' THEN ConvertedSalary * 12
        WHEN SalaryType = 'Yearly' THEN ConvertedSalary
        ELSE NULL -- Handle 'NA' values
    END AS yearly_salary
FROM 
    surveyclean
WHERE 
    SalaryType IS NOT NULL
    AND SalaryType != "NA"
    AND ConvertedSalary != "NA"
    AND ConvertedSalary != 0;