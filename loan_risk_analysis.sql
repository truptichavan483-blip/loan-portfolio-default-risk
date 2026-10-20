
USE loan_risk_analysis;

-- 1. Overall loan and default summary
SELECT
    COUNT(*) AS total_loans,
    SUM(CASE WHEN loan_status = 1 THEN 1 ELSE 0 END) AS defaulted_loans,
    ROUND(100.0 * AVG(loan_status), 2) AS default_rate_pct
FROM credit_risk_dataset;

-- 2. Default rate by loan grade
SELECT
    loan_grade,
    COUNT(*) AS total_loans,
    SUM(loan_status) AS defaulted_loans,
    ROUND(100.0 * AVG(loan_status), 2) AS default_rate_pct
FROM credit_risk_dataset
GROUP BY loan_grade
ORDER BY default_rate_pct DESC;

-- 3. Default rate by loan purpose
SELECT
    loan_intent,
    COUNT(*) AS total_loans,
    SUM(loan_status) AS defaulted_loans,
    ROUND(100.0 * AVG(loan_status), 2) AS default_rate_pct
FROM credit_risk_dataset
GROUP BY loan_intent
ORDER BY default_rate_pct DESC;

-- 4. Default rate by home ownership
SELECT
    person_home_ownership,
    COUNT(*) AS total_loans,
    SUM(loan_status) AS defaulted_loans,
    ROUND(100.0 * AVG(loan_status), 2) AS default_rate_pct
FROM credit_risk_dataset
GROUP BY person_home_ownership
ORDER BY default_rate_pct DESC;

-- 5. Default rate by loan-to-income ratio
SELECT
    CASE
        WHEN loan_percent_income > 0.30 THEN 'Above 30%'
        WHEN loan_percent_income > 0.20 THEN '20-30%'
        WHEN loan_percent_income > 0.10 THEN '10-20%'
        ELSE '0-10%'
    END AS loan_to_income_group,
    COUNT(*) AS total_loans,
    SUM(loan_status) AS defaulted_loans,
    ROUND(100.0 * AVG(loan_status), 2) AS default_rate_pct
FROM credit_risk_dataset
GROUP BY loan_to_income_group
ORDER BY default_rate_pct DESC;
