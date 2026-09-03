// create a regex that returns only the first alphabetic word (upper and lower case) at the start of the in a string

grep -E "^[A-Za-z]+" practice.txt

highlight only the word that is found

grep -o -E "^[A-Za-z]+" practice.txt