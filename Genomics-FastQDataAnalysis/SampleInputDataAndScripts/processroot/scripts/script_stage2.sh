#!/bin/bash

echo "script_stage2.sh started"

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

echo "picard1 output" > picard1.txt
echo "picard2 output" > picard2.txt
echo "flagstat output" > flagstat.txt

python script_azcopy.py --sourcePath "picard1.txt" --targetPath "output/"$BARCODEID"/picard1.txt" --targetAccount $STORAGEACCOUNT --targetContainer $CONTAINER --targetSASToken $CONTAINERSAS

python script_azcopy.py --sourcePath "picard2.txt" --targetPath "output/"$BARCODEID"/picard2.txt" --targetAccount $STORAGEACCOUNT --targetContainer $CONTAINER --targetSASToken $CONTAINERSAS

python script_azcopy.py --sourcePath "flagstat.txt" --targetPath "output/"$BARCODEID"/flagstat.txt" --targetAccount $STORAGEACCOUNT --targetContainer $CONTAINER --targetSASToken $CONTAINERSAS


echo "script_stage2.sh ended"