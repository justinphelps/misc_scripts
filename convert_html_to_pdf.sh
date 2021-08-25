#!/bin/bash 

function usage {
	echo "Batch converts html docs to pdf"
	echo "usage $0 input_directory output_directory"
}

function convert_html_to_pdf() {
	#assumes macos, otherwise point to your chrome binary
	/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome \
  --headless \
  --no-margins \
  --print-to-pdf $1
}

#require input and output dirs
if [[ ${#} -ne 2 ]]; then
   usage
   exit 1
fi

#Set input/output
INDIR=$1
OUTDIR=$2

#Cleanup
#Chrome pdf conversion doesn't seem to support naming the output file, just output.pdf
rm output.pdf

#setup

if [ ! -d $INDIR ]; then
	echo "$INDIR doesn't exist"
	usage
	exit 1
fi

if [ ! -d $OUTDIR ]; then
	echo "Creating $OUTDIR since it doesn't exist"
	mkdir $OUTDIR
fi


#the main loop
for i in $INDIR/*.html
do 
	BASENAME=$(basename $i .html)
	convert_html_to_pdf $INDIR/$i
	mv output.pdf $OUTDIR/$BASENAME.pdf
done
