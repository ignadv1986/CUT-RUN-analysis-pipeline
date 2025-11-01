# CRAMP1-CUT_RUN
CUT&RUN analysis of CRAMP1 protein in human cells

## Project summary

In this project, we analyzed the DNA-binding ability of wild-type CRAMP1 and two distinct mutants (∆SANT and ∆D1) using CUT&RUN. The experiment was performed in CRAMP1 knockout human osteosarcoma U2OS cells reconstituted with inducible expression of GFP-tagged CRAMP1 WT, ∆SANT, or ∆D1. Cells expressing an empty GFP vector served as a control.

The experimental procedures are detailed in [this publication](https://www.sciencedirect.com/science/article/pii/S1097276525003090?via%3Dihub)

Here, we present the bioinformatics workflow used to process and analyze the resulting sequencing data, highlighting key quality control steps, peak calling, and downstream interpretation.

**Note:** Raw sequencing data processing (adapter trimming with fastp, sequence mapping with bowtie2 and removal of duplicated sequences with Picard MarkDuplicates) was performed by the sequencing facility using standard pipelines. This portfolio focuses on the subsequent steps starting with BAM files.

---
## Background

Through CRISPR/Cas9 screens, we identified the previously uncharacterized protein CRAMP1 as a regulator of sensitivity to Topoisomerase 2 inhibitors, a class of anticancer drugs. Subsequent experiments revealed that CRAMP1 localizes to nuclear condensates known as histone locus bodies (HLBs), sites of histone gene transcription. Surprisingly, CRAMP1 knockout did not affect core histone levels but caused approximately a 50% reduction in linker histone H1 levels. The GBD1 domain of CRAMP1 (here termed D1 for simplicity) regulates both localization to HLBs and H1 expression, while the SANT domain is dispensable for localization but essential for maintaining correct H1 levels. To investigate whether CRAMP1 binds histone gene promoters and to determine the roles of these domains, we performed CUT&RUN on GFP-CRAMP1 expressing cell lines.

---
## Goals

- Perform quality control and peak analysis of CUT&RUN data.
- Visualize and interpret peaks.
- Determine CRAMP1 ability to bind the promoters of histone H1 genes.
- Assess differences between WT and mutant proteins. 
---
## Tools

- **bash, conda** - workflow/environment control.
- **bowtie2** - sequence alignment.
- **samTools** - sample quality check.
- **bamPEFragmentSize** - fragment size distribution.
- **bedtools** - peak intersection
- **deepTools** (bigwigCompare, multiBigwigSummary, plotCorrelation, computeMatrix, plotProfile, multiBigWigSummary)
- **MACS2** - peak calling.
- **SeqMonk/IGV** - track visualization.
- **R/Bioconductor** - extraction of genomic coordinates and plotting.
- **GraphPad Prism** - graph generation.
- **Adobe Illustrator** - figure polishing.
---
## Workflow
1. **Sample Quality Assessment**
- Aligned reads were quality-checked using samtools.
- Fragment size distributions were confirmed with bamtools to ensure expected CUT&RUN fragment profiles.
2. **Spike-In Normalization**
- Sequencing reads were mapped to *Saccharomyces cerevisiae* spike-in DNA using bowtie2.
- A scaling factor was calculated based on yeast read counts to normalize for technical variation across samples.
3. **Filtering Reads**
- Only reads mapping to canonical chromosomes (1–22, X, and Y) were retained for further analysis.
4. **Visualization and Replicate Assessment**
- Initial visualization of mapped reads was done in SeqMonk.
5. **Processing of Bam Files**
- Bam files were filtered for standard chromosomes (1-22, X and Y).
- Bam files were merged using samtools.
6. **Generation of Coverage Tracks**
- BigWig files were generated from BAMs with spike-in scaling applied.
7. **Peak Calling, Replicate Assessment and Intersection Analysis**
- Peaks were called form bam files on both merged replicates and individual samples using MACS2.
- Peaks present in at least 2 replicates of a sample were defined as consensus peaks using bedtools intersect and replicate correlation was assessed with multiBigWigSummary.
- Unique and shared peaks between conditions were identified using bedtools intersect and visualized in R.
8. **Binding Profile Analysis at Regions of Interest**
- Binding at transcription start sites (TSS) was quantified using deepTools’ computeMatrix with reference to TSS.
- Profiles were plotted with plotProfile to compare binding patterns across different gene subsets.
## Results
1) **Sample quality assessment**
Quality assessment performed on pre-processed BAM files (after adapter trimming, quality filtering, and duplicate removal) showed exceptionally high alignment rates, with 100% of reads mapped and properly paired. No duplicates or secondary alignments were detected, confirming the efficacy of the preprocessing steps and the high quality of the final dataset for analysis.
2) **Fragment size distribution analysis**
Fragment size distribution analysis revealed a predominant enrichment of short DNA fragments, mostly between 30 and 150 bp, consistent with the expected cleavage pattern in CUT&RUN assays. The presence of a strong peak around 50-60 bp suggests efficient targeting of sub-nucleosomal regions, supporting the high specificity and quality of the sample preparation.
3) **SeqMonk/IGV visualization**
Initial assessment of mapped reads in SeqMonk provided a quick quality check and overview of the data distribution across the genome, confirming CRAMP1´s DNA-binding and enrichment at histone locus bodies. This enrichment was abolished in the D1 mutant and, while still able to accumulate at this genomics regions, the SANT mutant was absent from H1 promoter [Figure 1](./graphs/CRAMP1_tracks.pdf)
4) **Correlation analysis**
Spearman correlation was applied to all replicates. The different replicates of each individual sample showed high correlation (>0.65), while demonstrating big differences between the different conditions, specially for the D1 mutant [Figure 2](./graphs/Sample_correlation_heatmap_CRAMP1_CUTRUN.pdf).
5) **Assessment of differences between WT and mutants**
Peaks in WT samples were clearly enriched in promotor regions, with double the amount of peaks as compared to either SANT or D1 mutants, demonstrating the importance of both domains in CRAMP1´s role as a transcription factor. Additionally, most histone loci showed unique peaks in WT as compared to both mutants, with CRAMP1 SANT having a significant reduced peaks at H1 genes [Figure 3](./graphs/WT_vs_mutants_intersection.pdf)
6) **Analysis of CRAMP1 enrichment at replication-dependent histones and H1 genes**
CRAMP1 was highly enriched at H1 genes promoters as compared to both the SANT and the D1 mutants, while only the D1 mutation seemed to show a big impact in the overall recruitment of CRAMP1 to the promoters of replication-dependent histones [Figure 4](./graphs/CRAMP1_peaks.pdf).
