// write a regex that would match both word "gray" and "grey"

grep -E 'gr(a|e)y' practice.txt

//write a regex that would match a word that starts with an uppercase letter and followed by at least one lowercase letters, like "Apple", "Banana", or "Carrot"

grep -E '^[A-Z][a-z]+' practice.txtls

// regex that captures words that start with a vowel (a, e, i, o, u) can be any number of characters from a-z after the vowel (including zero), and end with a consonant (any letters that are not a,e,i,o,u) like "unicorn", "it", and "element".

grep -E '^[aeiou][a-z]*[^aeiou]$' practice.txt

// construct a regex to find legal variable names in C
// A legal variable name in C must start with a letter (uppercase or lowercase) or an underscore, followed by any combination of letters, digits, or underscores. The regex above captures this pattern.

grep -E '^[a-zA-Z_][a-zA-Z0-9_]*$' practice.txt

//regex to capture numbers with 5-7 digits. for example: 48105 103028 1234567

grep -E '^[0-9]{5,7}$' practice.txt





