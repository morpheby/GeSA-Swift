#!/bin/sh

# You will need OmniGraggle to use this script.
# Note: Exporting in OmniGraffle 7.0-7.3 is broken.

set -e

if [[ "$1" == "clean" ]] ; then
    rm -rf VENV omnigraffle-export

    for inname in *.graffle ; do
        outname=${inname%.*}
        rm -rf "${outname}"
    done
    
    exit 0
fi

if [[ ! -d "VENV" ]] ; then
    mkdir -p VENV
    virtualenv --python=/usr/bin/python VENV
    
    . VENV/bin/activate
    
    # Too old version
    # pip install pyobjc omnigraffle_export
    
    # Perform installation from source
    git clone https://github.com/fikovnik/omnigraffle-export.git
    cd omnigraffle-export
    
    # Use a specific checkout
    git checkout 3c94f261
    
    pip install .
    
    cd ../
    
    rm -rf omnigraffle-export
    
else
    . VENV/bin/activate
fi

for inname in *.graffle ; do
    outname=${inname%.*}
    echo "Exporting ${inname}…"
    mkdir -p "${outname}"
    omnigraffle-export -f png "${inname}" "${outname}"
done
