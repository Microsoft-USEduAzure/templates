#!/bin/bash

echo "script_stage1.sh started"

printenv > environmentvariablestrace.txt

FASTQ1=$1
FASTQ2=$2
STORAGEACCOUNT=$3
CONTAINER=$4
CONTAINERSAS=$5
BARCODEID=$6

echo $FASTQ1
echo $FASTQ2
echo $STORAGEACCOUNT
echo $CONTAINER
echo $CONTAINERSAS
echo $BARCODEID

FASTQ1UNZIPPED=${FASTQ1::-9}
FASTQ1UNZIPPED+=.fastq

FASTQ2UNZIPPED=${FASTQ2::-9}
FASTQ2UNZIPPED+=.fastq

FASTQ1STAGE1DONE=${FASTQ1::-9}
FASTQ1STAGE1DONE+=.done

zcat $FASTQ1 > $FASTQ1UNZIPPED
zcat $FASTQ2 > $FASTQ2UNZIPPED

echo "star output" > staroutput.txt
echo "salmon output" > salmonoutput.txt
echo "done file content" > salmonoutput.txt

python script_azcopy.py --sourcePath $FASTQ1UNZIPPED --targetPath "output/"$BARCODEID"/"$FASTQ1UNZIPPED --targetAccount $STORAGEACCOUNT --targetContainer $CONTAINER --targetSASToken $CONTAINERSAS

python script_azcopy.py --sourcePath $FASTQ2UNZIPPED --targetPath "output/"$BARCODEID"/"$FASTQ2UNZIPPED --targetAccount $STORAGEACCOUNT --targetContainer $CONTAINER --targetSASToken $CONTAINERSAS

python script_azcopy.py --sourcePath "staroutput.txt" --targetPath "output/"$BARCODEID"/staroutput.txt" --targetAccount $STORAGEACCOUNT --targetContainer $CONTAINER --targetSASToken $CONTAINERSAS

python script_azcopy.py --sourcePath "salmonoutput.txt" --targetPath "output/"$BARCODEID"/salmonoutput.txt" --targetAccount $STORAGEACCOUNT --targetContainer $CONTAINER --targetSASToken $CONTAINERSAS


echo "script_stage1.sh ended"