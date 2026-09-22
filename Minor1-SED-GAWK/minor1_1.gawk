# id: sp3155
# name: Serene Plummer

BEGIN {
  OFS = "\t"
}
 
NR == 1 {
  if ($1 != "Degrees") {
    print "Error: Invalid header"
    exit 1
  }
  print "Degrees", "Coterminal"
  next
}
 
{
  angle = $1 % 360
  if (angle < 0) angle += 360
  if (angle == 0) angle = 0
  printf "%6d\t%d\n", $1, angle
}