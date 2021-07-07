SELECT 
	concat(left(first_name, 1), '. ', last_name) AS fullName,
    income,
    round(income) AS incomeRounded,
    (income * 2) AS doubledIncome,
    income / work_days AS incomePerDay
FROM calculations;
