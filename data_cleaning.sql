SELECT *
FROM borrower_profiles;

-- Step 1: Add column
ALTER TABLE borrower_profiles
ADD credit_bucket VARCHAR(20);

-- Step 2: Update it
UPDATE borrower_profiles
SET credit_bucket = 
    CASE 
        WHEN credit_score BETWEEN 520 AND 599 THEN 'Poor'
        WHEN credit_score BETWEEN 600 AND 649 THEN 'Fair'
        WHEN credit_score BETWEEN 650 AND 699 THEN 'Good'
        WHEN credit_score BETWEEN 700 AND 749 THEN 'Very Good'
        WHEN credit_score >= 750 THEN 'Excellent'
        ELSE 'Unknown'
    END;

SELECT *
FROM loan_applications;

CREATE TABLE `loan_staging` (
  `loan_id` text,
  `borrower_id` text,
  `application_date` text,
  `loan_purpose` text,
  `loan_amount` double DEFAULT NULL,
  `term_months` int DEFAULT NULL,
  `interest_rate` double DEFAULT NULL,
  `monthly_payment` double DEFAULT NULL,
  `dti_ratio` double DEFAULT NULL,
  `loan_status` text,
  `days_delinquent` int DEFAULT NULL,
  `defaulted` int DEFAULT NULL,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO loan_staging
SELECT *,
ROW_NUMBER () OVER( partition by loan_id, borrower_id, application_date, loan_purpose , loan_amount , term_months , interest_rate , monthly_payment , dti_ratio,
loan_status , days_delinquent , defaulted)
AS row_num
FROM loan_applications ;

SELECT *
FROM loan_staging;

ALTER TABLE loan_staging
DROP COLUMN row_num;

