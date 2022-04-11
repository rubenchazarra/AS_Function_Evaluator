#!/bin/bash

#SBATCH --nodes=1
#SBATCH --job-name="4.Map-GenCoords"
#SBATCH -o slurm-%j.out
#SBATCH -e slurm-%j.err
#SBATCH --qos=debug
#SBATCH --ntasks-per-node=48
#SBATCH --cpus-per-task=1
#SBATCH --time "02:00:00"


# Params
#transcript_list=/gpfs/projects/bsc83/Projects/RubenChazarra/1.Projects/1.Alternative_Splicing/1.AS_Function_Evaluator/Transcript_lists/6.DS-Events-All-Tissues-Approach-1/Transcript-List-Prot-Coding-Approach-1-25Oct2021.txt
transcript_list=/gpfs/projects/bsc83/Projects/RubenChazarra/1.Projects/1.Alternative_Splicing/1.AS_Function_Evaluator/Manual-Execution/0.Scripts/4.Map-GenCoords/Transcript-List-22
#transcript_list=/gpfs/projects/bsc83/Projects/RubenChazarra/1.Projects/1.Alternative_Splicing/1.AS_Function_Evaluator/Manual-Execution/test_list.txt
pfam_dir=/gpfs/projects/bsc83/Projects/RubenChazarra/1.Projects/1.Alternative_Splicing/1.AS_Function_Evaluator/Manual-Execution/1.Output/10-2021-22/3.PFAM-Parsed/
gtf_dir=/gpfs/projects/bsc83/Projects/RubenChazarra/1.Projects/1.Alternative_Splicing/1.AS_Function_Evaluator/Manual-Execution/1.Output/10-2021-22/1.Protein-FASTA/
outdir=/gpfs/projects/bsc83/Projects/RubenChazarra/1.Projects/1.Alternative_Splicing/1.AS_Function_Evaluator/Manual-Execution/1.Output/10-2021-22/4.Map-GenCoords-GTF/

# Get rid of already loaded modules
# module purge # This is failing

# Load required modules
# module load gcc/6.1.0
# module load CURL/7.49.0
# module load BZIP2/1.0.6
module load R/3.6.1

while read -r transcript_id; 
do
echo $transcript_id
pfam_tbl=${pfam_dir}/${transcript_id}-pfam-alignment.txt
gtf=${gtf_dir}/${transcript_id}.gtf
protein_fasta=${gtf_dir}/${transcript_id}.protein.fasta

/gpfs/projects/bsc83/Projects/RubenChazarra/1.Projects/1.Alternative_Splicing/1.AS_Function_Evaluator/bin/Map-PFAM-to-genomic-coord-GTF.R --pfam_alignment ${pfam_tbl} --gtf ${gtf} --transcript_id ${transcript_id} --protein_fasta ${protein_fasta} --output_coord ${outdir}${transcript_id}-PFAM-GenCoords-GTF.txt
done < ${transcript_list}
