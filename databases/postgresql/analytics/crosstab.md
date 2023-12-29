# Which to use

In PostgreSQL use filtering based solution. Only use CROSSTAB(subquery TEXT) from tablefuncwhen its higher performance is a must.

For portability CASE-based solution is the best, but it has the poorest performance among the real world solutions

Indentity matrix based method is not real world solution, but a nice proof of concept
