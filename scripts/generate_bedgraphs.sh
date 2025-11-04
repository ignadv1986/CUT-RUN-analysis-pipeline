#!/bin/bash
set -e

GENOME="hg38.chrom.sizes"

# Sample names
samples=(
  CRAMP1_WT_R1
  CRAMP1_WT_R2
  CRAMP1_WT_R3
  CRAMP1_SANT_R1
  CRAMP1_SANT_R2
  CRAMP1_SANT_R3
  CRAMP1_D1_R1
  CRAMP1_D1_R2
  CRAMP1_D1_R3
)

# Corresponding scale factors (in the same order)
scaleFactors=(
  0.968018822
  0.986725607
  1.029437376
  0.848108507
  1.14318556
  1.075516719
  0.93768421
  1.094972833
  0.916350365
)

# Loop through both arrays
for i in "${!samples[@]}"; do
  sample="${samples[$i]}"
  factor="${scaleFactors[$i]}"

  echo "📈 Processing $sample (scaling factor: $factor)..."

  bamfile="${sample}_final.bam"
  bedgraph="${sample}.bedgraph"

  # Generate scaled BedGraph
  bedtools genomecov -bg -ibam "$bamfile" -g "$GENOME" | \
    awk -v scale="$factor" '{OFS="\t"; $4 = $4 * scale; print}' > "$bedgraph"

  echo "✅ Finished $sample → $bedgraph"
done

echo "🎉 All BedGraphs generated!"

