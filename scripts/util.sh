#  Append text to the end of a file if not already present
append_if_missing(){
 grep -qxF "$1" $2 || echo "$1" >> $2
}

# Create files only if not extant and append contents if not already present
create_and_append(){
 touch -c $2
 append_if_missing "$1" $2
}
