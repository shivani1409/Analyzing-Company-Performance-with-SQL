SELECT
emp.first_name|| '' || emp.last_name AS employee_full_name,
emp.title AS employee_title, EXTRACT(YEAR FROM age(emp.hire_date,emp.birth_date)) AS employee_age,
TRUNC((CURRENT_DATE-emp.hire_date)/365) AS employee_tenure,
mgr.first_name || '' || mgr.last_name AS manager_full_name,
mgr.title AS manager_title
FROM employees emp INNER JOIN employees mgr
ON emp.reports_to = mgr.employee_id
WHERE emp.birth_date IS NOT NULL
ORDER BY employee_age,employee_full_name ASC;