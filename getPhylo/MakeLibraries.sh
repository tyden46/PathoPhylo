#!/bin/bash
gunzip library/*.gz
cat library/nodes_split* > nodes.dmp
cat library/fullGb2Tax* > fullGb2Tax.txt
mv library/names.dmp .
