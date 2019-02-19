# trim trailing whitespace from all lines of file arg
sed -i 's/[[:space:]]*$//' $1
