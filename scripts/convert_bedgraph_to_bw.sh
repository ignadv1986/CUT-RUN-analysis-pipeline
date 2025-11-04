#!/bin/bash

GENOME="hg38.chrom.sizes"

# List of your scaled bedgraph files (adjust if needed)
bedgraphs=(
  CRAMP1_D1_R1.bedgraph
  CRAMP1_D1_R2.bedgraph
  CRAMP1_D1_R3.bedgraph
  CRAMP1_SANT_R1.bedgraph
  CRAMP1_SANT_R2.bedgraph
  CRAMP1_SANT_R3.bedgraph
  CRAMP1_WT_R1.bedgraph
  CRAMP1_WT_R2.bedgraph
  CRAMP1_WT_R3.bedgraph
  CRAMP1_D1_merge.bedgraph
  CRAMP1_SANT_merge.bedgraph
  CRAMP1_WT_merge.bedgraph
)

for bedgraph in "${bedgraphs[@]}"; do
  bw="${bedgraph%.bedgraph}.bw"
  echo "Converting $bedgraph to $bw"
  bedGraphToBigWig "$bedgraph" "$GENOME" "$bw"
  echo "✔️ $bw created"
done

