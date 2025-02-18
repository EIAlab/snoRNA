##!/bin/bash

# Print snoscan version and help
CMD1="snoscan -h"
eval $CMD1

echo "######## snoscan analysis ########"
# Loop through each query file
for query_file in ./query/*.fas; do
  # Loop through each target file
  for target_file in ./target/*.fas; do
    # Construct the snoscan command
    CMD2="snoscan -V $target_file $query_file"
    
    # Print and execute the command
    echo $CMD2
    eval $CMD2
	echo "##################################"
	echo "##################################"
  done
done