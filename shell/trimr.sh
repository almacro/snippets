# trim trailing whitespace from all lines of file arg
sed -i -e 's/[[:space:]]*$//' $1
