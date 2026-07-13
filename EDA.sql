/* =========================================================
   LOAN DEFAULT EXPLORATORY DATA ANALYSIS
   Focus Areas:
   1. Credit Score
   2. Debt-to-Income Ratio
   3. Loan Purpose
   4. Employment
   ========================================================= */


/* =========================================================
   1. CREDIT SCORE VS DEFAULT
   Business Question:
   How does credit score category affect loan default risk?
   ========================================================= */

SELECT 
    COALESCE(b.credit_bucket, 'Unknown') AS credit_bucket,
    COUNT(*) AS total_loans,
	SUM(CASE WHEN l.defaulted = 1 THEN 1 ELSE 0 END) AS total_defaults,
    SUM(CASE WHEN l.defaulted = 0 THEN 1 ELSE 0 END) AS non_defaulted_loans,
    ROUND(100.0 * SUM(CASE WHEN l.defaulted = 1 THEN 1 ELSE 0 END)/ NULLIF(COUNT(*), 0),2) AS default_rate_pct,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) AS portfolio_share_pct
FROM borrower_profiles b
INNER JOIN loan_staging l
    ON b.borrower_id = l.borrower_id
GROUP BY COALESCE(b.credit_bucket, 'Unknown')
ORDER BY default_rate_pct DESC;


/* =========================================================
   2. DEBT-TO-INCOME RATIO VS DEFAULT
   Business Question:
   Does a higher DTI ratio increase loan default risk?
   ========================================================= */

SELECT 
    CASE
        WHEN l.dti_ratio IS NULL THEN 'Unknown'
        WHEN l.dti_ratio <= 20 THEN '0-20 (Low)'
        WHEN l.dti_ratio <= 35 THEN '>20-35 (Moderate)'
        WHEN l.dti_ratio <= 50 THEN '>35-50 (High)'
        ELSE '50+ (Very High)'
    END AS dti_bucket, 
    COUNT(*) AS total_loans,
	SUM(CASE WHEN l.defaulted = 1 THEN 1 ELSE 0 END)AS total_defaults,
    SUM(CASE WHEN l.defaulted = 0 THEN 1 ELSE 0 END) AS non_defaulted_loans,
    ROUND(100.0 * SUM(CASE WHEN l.defaulted = 1 THEN 1 ELSE 0 END)/ NULLIF(COUNT(*), 0),2) AS default_rate_pct,
    ROUND(AVG(l.dti_ratio), 2) AS average_dti_ratio
FROM borrower_profiles b
INNER JOIN loan_staging l
ON b.borrower_id = l.borrower_id
GROUP BY
    CASE
        WHEN l.dti_ratio IS NULL THEN 'Unknown'
        WHEN l.dti_ratio <= 20 THEN '0-20 (Low)'
        WHEN l.dti_ratio <= 35 THEN '>20-35 (Moderate)'
        WHEN l.dti_ratio <= 50 THEN '>35-50 (High)'
        ELSE '50+ (Very High)'
    END
ORDER BY
    CASE dti_bucket
        WHEN '0-20 (Low)' THEN 1
        WHEN '>20-35 (Moderate)' THEN 2
        WHEN '>35-50 (High)' THEN 3
        WHEN '50+ (Very High)' THEN 4
        ELSE 5
    END;


/* =========================================================
   3. LOAN PURPOSE VS DEFAULT
   Business Question:
   Which loan purposes have the highest default risk?
   ========================================================= */

SELECT 
    COALESCE(l.loan_purpose, 'Unknown') AS loan_purpose,
    COUNT(*) AS total_loans,
    SUM(CASE WHEN l.defaulted = 1 THEN 1 ELSE 0 END) AS total_defaults,
    SUM(CASE WHEN l.defaulted = 0 THEN 1 ELSE 0 END) AS non_defaulted_loans,
    ROUND(100.0 * SUM(CASE WHEN l.defaulted = 1 THEN 1 ELSE 0 END) / NULLIF(COUNT(*), 0),2) AS default_rate_pct,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (),2) AS portfolio_share_pct
FROM borrower_profiles b
INNER JOIN loan_staging l
    ON b.borrower_id = l.borrower_id
GROUP BY COALESCE(l.loan_purpose, 'Unknown')
ORDER BY default_rate_pct DESC;


/* =========================================================
   4. EMPLOYMENT VS DEFAULT
   Business Question:
   How do employment status and employment tenure affect
   loan default risk?
   ========================================================= */

SELECT 
    COALESCE(b.employment_status, 'Unknown') AS employment_status,
    CASE
        WHEN b.years_employed IS NULL THEN 'Unknown'
        WHEN b.years_employed < 2 THEN '<2 years'
        WHEN b.years_employed <= 5 THEN '2-5 years'
        ELSE '5+ years'
    END AS employment_tenure,
    COUNT(*) AS total_loans,
    SUM(CASE WHEN l.defaulted = 1 THEN 1 ELSE 0 END) AS total_defaults,
    SUM(CASE WHEN l.defaulted = 0 THEN 1 ELSE 0 END) AS non_defaulted_loans,
    ROUND(100.0 * SUM(CASE WHEN l.defaulted = 1 THEN 1 ELSE 0 END) / NULLIF(COUNT(*), 0),2) AS default_rate_pct,
    ROUND(AVG(b.years_employed), 2)AS average_years_employed
FROM borrower_profiles b
INNER JOIN loan_staging l
    ON b.borrower_id = l.borrower_id
GROUP BY
    COALESCE(b.employment_status, 'Unknown'),
    CASE
        WHEN b.years_employed IS NULL THEN 'Unknown'
        WHEN b.years_employed < 2 THEN '<2 years'
        WHEN b.years_employed <= 5 THEN '2-5 years'
        ELSE '5+ years'
    END
ORDER BY default_rate_pct DESC;