# id: sp3155
# name: Serene Plummer

BEGIN {
  FS = "[ \t]+"
  required_scores = 3
}
 
NR <= 2 { next }  # Skip header rows
 
{
  name = $1 " " $2
  total = 0
  count = 0
  missing = 0
  note = ""
  
  for (i = 3; i <= required_scores + 2; i++) {
    if (i <= NF && $i ~ /^[0-9]+$/) {
      total += $i
      count++
    } else {
      missing = 1
    }
  }
  
  if (missing || count == 0) {
    grade = "F"
    note = " (missing scores)"
  } else {
    avg = total / count
    if (avg >= 89.5) grade = "A"
    else if (avg >= 79.5) grade = "B"
    else if (avg >= 69.5) grade = "C"
    else if (avg >= 59.5) grade = "D"
    else grade = "F"
  }
  
  printf "%-8s %-8s", $1, $2
  for (i = 3; i <= required_scores + 2; i++) {
    if (i <= NF && $i ~ /^[0-9]+$/) printf "%3d ", $i
    else printf " -- "
  }
  printf "  %s%s\n", grade, note
}
 