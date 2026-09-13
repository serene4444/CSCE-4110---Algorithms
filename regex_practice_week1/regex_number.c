// regex that finds phone numbers 333-232-3403 (333) 232 3403

grep -E "^\(?[0-9]{3}\)?[- ]?[0-9]{3}[- ]?[0-9]{4}$" practice.txt

// create a regex that matchs any price in the form of $90.98 $45.89 or $2423 for example

grep -E '^\$[0-9]+(\.[0-9]{2})?$' practice.txt