// print only valid dates in the form mm/dd/yyyy or mm/dd/yy

grep -E "^[0-9]{2}/[0-9]{2}/([0-9]{4}|[0-9]{2})$" practice.txt