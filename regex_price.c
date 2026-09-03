// create a regex that matchs any price in the form of $90.98 $45.89 or $2423 for example




grep -E '^\$[0-9]+(\.[0-9]{2})?$' practice.txt