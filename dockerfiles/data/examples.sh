#!/bin/bash
# ssql playground examples — run any of these pipelines
# Uncomment one at a time, or copy-paste into your shell.
# Tab completion: ssql from csv data/employees.csv | ssql where -if <TAB>
# (use <TAB> after "from" for format, after path for files, and after "-if" for field names)

# Get help — see all commands
# ssql -help

# Get help on a specific command
# ssql update -help

# 1. View data — see what's in the table
ssql from data/employees.csv | ssql to table

# 2. Filter — engineers only
# ssql from data/employees.csv | ssql where -if dept eq Engineering | ssql to table

# 3. Sort + limit — top 10 salaries
# ssql from data/employees.csv | ssql sort -desc salary | ssql limit 10 | ssql to table

# 4. Update — add a new field
# ssql from data/employees.csv | ssql update -set magic 42 | ssql limit 5 | ssql to table

# 5. Update — computed field with an expression
# ssql from data/employees.csv | ssql update -set-expr bonus 'salary / 10' | ssql limit 5 | ssql to table

# 6. Group by — count and average by department
# ssql from data/employees.csv | ssql group-by dept -count cnt -avg salary avg_sal | ssql sort -desc cnt | ssql to table

# 7. Chart — bar chart of department sizes
# ssql from data/employees.csv | ssql group-by dept -count cnt | ssql to chart -x dept -y cnt -type bar

# 8. Join — orders with customers
# ssql from data/orders.csv | ssql join <(ssql from data/customers.csv) -using customer_id | ssql limit 10 | ssql to table

# 9. Join + filter — US revenue by product (try: ssql generate ssql -explain)
# ssql from data/orders.csv | ssql join <(ssql from data/customers.csv) -using customer_id | ssql where -if country eq US | ssql group-by product -sum amount total | ssql sort -desc total | ssql to table

# 10. Window — top 3 earners per department
# ssql from data/employees.csv | ssql window -row-number rank -partition dept -order salary -desc | ssql where -if rank le 3 | ssql include dept name salary rank | ssql to table
