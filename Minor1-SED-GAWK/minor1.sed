# Remove parentheses
s/(//g
s/)//g

# Remove spaces
s/ //g

# Remove dashes
s/-//g

# Rearrange digits: reverse the 10-digit phone number
s/\([0-9]\)\([0-9]\)\([0-9]\)\([0-9]\)\([0-9]\)\([0-9]\)\([0-9]\)\([0-9]\)\([0-9]\)\([0-9]\)/\10\9\8\7\6\5\4\3\2\1/

# Transliterate digits to letters
y/0123456789/aAbBcCdDeE/

# Append extra data after the third line
3a\
MarkThomps