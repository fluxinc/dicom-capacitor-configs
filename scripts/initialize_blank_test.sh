#!/usr/bin/bash

# This script is meant to bbe run **on the customer machine, inside WSL**, in /mnt/x/test.
# It will take the original test study provided by the client, that includes their minimum
# views, and will create a new anonymized study with a new SUID, unique Series UIDs, and a new patient

# Having a new patient with each test is important.

EPOCH=`date +"%s.%N"`
SID=FLUXTEST$2
SUID=1.2.276.0.7230010.3.1.2.8323329.16276.$EPOCH

if [ ! -d "$1" ]; then
  echo "First argument must be a directory"
  exit 1
fi

echo "Copying originals"
rm -f input/*
cp $1/* input/
echo "Removing patient data"
dcmodify +dc -nb -ie -e "(7fe0,0010)" ./input/*
dcmodify -nb -gin -gse -e "(0008,1048)" -e "(0008,1050)" -e "(0008,0090)" -e "(0032,1032)" ./input/*
echo "Changing Accession and Study ID"
dcmodify -nb -m "(0010,0010)=FLUX^TEST$2" -m "0010,0020=FLUX0$2" ./input/*
echo "Changing SIDs"
dcmodify -nb -m "0020,000d=$SUID" -m "0008,0050=$SID" -m "0020,0010=$SID" ./input/*
