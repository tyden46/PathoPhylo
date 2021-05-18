#!/bin/bash
MIN_SUM_ABUNDANCE=${1}
if [ $# -lt 1 ]; then
    echo "A minimum abundance value is required. Please re-run the script with such a value ie 'bash run.sh 0.01'" 
    exit 1
fi
Rscript PathoscopeOutputMerge.R $MIN_SUM_ABUNDANCE
sh RunForIds.sh > taxaAndRanks.txt
Rscript getTax.R
