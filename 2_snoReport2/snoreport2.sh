#!/bin/bash

# Install SnoReport 2.0 according to https://joaovicers.github.io/snoreport2/index.html

# Before using this script, put fasta files in the input folder.

exec &> ./output/SnoReport.log

echo "######################################"
echo "######## SnoReport_2 version #########"
echo "######################################"
CMD1="snoreport_2 -h"
eval $CMD1
echo ""

echo "######################################"
echo "######## SnoReport_2 analysis ########"
echo "######################################"

#snoreport_2 -i <fasta_file> [-CD|-HACA] [-trainCD|-trainHACA] [OPTIONS]
CMD2="snoreport_2 -i input/Sa.fas -CD -HACA --positives -o output/Sa/output.txt --PS"
CMD3="snoreport_2 -i input/Sc.fas -CD -HACA --positives -o output/Sc/output.txt --PS"

echo $CMD2
eval $CMD2
echo $CMD3
eval $CMD3