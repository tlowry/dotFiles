#  Append text to the end of a file if not already present
append_if_missing(){
 grep -qxF "$1" $2 || echo "$1" >> $2
}

# Create files only if not extant and append contents if not already present
create_and_append(){
 touch -c $2
 append_if_missing "$1" $2
}

# Add a directory to the system path only if missing
add_to_path () {
  
    # Just quit if first arg is empty
    if [ -z '$1' ];then
        return 0
    fi

    if [ -z "$PATH" ];then
        # Path empty, just set it to new var
        PATH=$1
    else
        # Path not empty, append if needed
        if ! echo "$PATH" | /bin/grep -Eq "(^|:)$1($|:)" ; then
            if [ "$2" = "before" ] ; then
                PATH="$1:$PATH"
            else
                PATH="$PATH:$1"
            fi
        fi
    fi
}

# Add a directory to the python path if not already present
add_to_py_path () {
        if ! echo "$PYTHONPATH" | /bin/grep -Eq "(^|:)$1($|:)" ; then
           if [ "$2" = "before" ] ; then
              PATH="$1:$PYTHONPATH"
           else
              PATH="$PYTHONPATH:$1"
           fi
        fi
}

# Add a directory to the system path
add_to_path () {
        if ! echo "$PATH" | /bin/grep -Eq "(^|:)$1($|:)" ; then
           if [ "$2" = "before" ] ; then
              PATH="$1:$PATH"
           else
              PATH="$PATH:$1"
           fi
        fi
}
