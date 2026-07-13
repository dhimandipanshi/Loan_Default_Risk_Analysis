# Loan Default Risk Analysis

## Project Overview

Horizon Financial Group issued over **600 personal loans** across 2024–2025 and observed an overall **loan default rate of approximately 25%**, exceeding its target of **12%**.

This project analyzes borrower and loan application data to identify the key drivers of loan defaults and provide data-driven recommendations to strengthen underwriting decisions and reduce portfolio risk.

---

## Business Objectives

This analysis answers the following business questions:

- What is the overall loan default rate?
- Which credit score segments have the highest default rates?
- How does Debt-to-Income (DTI) ratio influence default risk?
- Which loan purposes are associated with higher default rates?
- Does employment status and years employed impact repayment behavior?
- What underwriting thresholds should be recommended?

---

## Dataset

Two datasets were analyzed:

- **Borrower Profiles** – Credit score, annual income, DTI, employment status, and years employed
- **Loan Applications** – Loan amount, loan purpose, interest rate, loan term, and default status

The datasets were joined using **Borrower ID**.

---

## Tech Stack

- SQL
- Python (Pandas)
- Excel

---

## Analysis Performed

- Data cleaning and preprocessing
- Exploratory Data Analysis (EDA)
- Data quality validation
- Dataset joining and transformation
- Credit score segmentation
- Debt-to-Income (DTI) analysis
- Loan purpose analysis
- Employment risk analysis
- Correlation analysis
- Business recommendation development

---

## Key Findings

The analysis identified four major factors influencing loan default risk:

- **Credit Score:** Lower credit scores were associated with higher default rates.
- **Debt-to-Income Ratio:** Higher DTI ratios increased the likelihood of default.
- **Loan Purpose:** Certain loan purposes exhibited higher default rates than others.
- **Employment Stability:** Borrowers with shorter employment tenure demonstrated higher default risk.

---

## Business Recommendations

| Risk Factor | Recommended Threshold |
|-------------|-----------------------|
| Credit Score | **Minimum 650** |
| Debt-to-Income Ratio | **Maximum 40%** |
| Employment Tenure | **Minimum 2 Years** |
| Loan Purpose | Enhanced review for high-risk categories |

These recommendations support more consistent underwriting decisions, improved portfolio quality, and lower default risk.

---

## Skills Demonstrated

- SQL
- Data Cleaning
- Exploratory Data Analysis (EDA)
- Data Transformation
- Risk Segmentation
- Correlation Analysis
- Business Analytics
- Credit Risk Analysis
- Data Storytelling
- Business Recommendation Development

---

## Future Enhancements

- Build a predictive default model using Logistic Regression
- Develop a credit risk scorecard
- Implement automated underwriting rules
- Incorporate macroeconomic indicators
- Perform portfolio stress testing
- Create a real-time loan portfolio monitoring pipeline
