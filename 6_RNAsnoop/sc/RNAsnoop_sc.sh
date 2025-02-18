#!/bin/bash

CMD1="RNAsnoop --query ./input/Sc.fas --target ./input/Aln_18S_Human_Btaurus_MUSCLE.fas > ./output/18S_Consensus/RNAsnoop_Sc_18S_Consensus.log"
CMD2="RNAsnoop --query ./input/Sc.fas --target ./input/28S_Btaurus.fas > ./output/28S_Btaurus/RNAsnoop_Sc_28S_Btaurus.log"
CMD3="RNAsnoop --query ./input/Sc.fas --target ./input/28S_Human.fas > ./output/28S_Human/RNAsnoop_Sc_28S_Human.log"

RNAsnoop -V > ./output/RNAsnoop_version.log


echo $CMD1
eval $CMD1
mv *_Consensus_18S_* ./output/18S_Consensus

echo $CMD2
eval $CMD2
mv *_Bos_taurus_* ./output/28S_Btaurus

echo $CMD3
eval $CMD3
mv *_Human_ribosomal_DNA_* ./output/28S_Human