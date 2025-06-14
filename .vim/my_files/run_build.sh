#!/bin/bash

# Quit on errors, and using an undefined variable is an error
set -eu

# Print all lines as they are executed
#set -x

# echo Searching from: $PWD
pushd $PWD > /dev/null

while true; do
    # echo checking $PWD
    if [ -f build.sh ]; then
        # echo Found build.sh in $PWD
        ./build.sh;
        break;
    else
        if [ "$PWD" = "/" ]; then
            echo Failed to find build.sh in any parent directory
            break;
        else
            cd ..;
        fi
    fi
done

#set +x

popd > /dev/null
