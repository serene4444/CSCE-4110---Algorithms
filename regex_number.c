// regex that finds phone numbers 333-232-3403 (333) 232 3403

grep -E "^\(?[0-9]{3}\)?[- ]?[0-9]{3}[- ]?[0-9]{4}$" practice.txt