#!/bin/bash
#SBATCH --job-name=Mm10
#SBATCH --output=logs/Mm10_%a.out
#SBATCH --error=logs/Mm10_%a.err
#SBATCH --array=1-21
#SBATCH -N 1
#SBATCH --mem=10G
#SBATCH --time=7-00:00:00
#SBATCH -p whwong
#SBATCH --cpus-per-task=4
#SBATCH --mail-type=FAIL,END      # Type of email notification- BEGIN,END,FAIL,ALL
#SBATCH --mail-user=zyfeng@stanford.edu  # Email to which notifications

CHR_ID=${SLURM_ARRAY_TASK_ID}

if [ "$CHR_ID" -eq 20 ]; then
  CHR="chrX"
else
if [ "$CHR_ID" -eq 21 ]; then
  CHR="chrY"
else
  CHR="chr"$CHR_ID
fi
fi

./bin/lastz-1.04.00 /home/users/zyfeng/DataSet/Monkey/LiftOver/mm10_split/${CHR}.fa ../fasta/Macaque_Assembly.v3-for-encode.fa \
	--scores=./Q/M10Q.txt E=30 K=3000 L=3000 H=2000 \
	--format=axt --ambiguous=n --ambiguous=iupac --allocate:traceback=1.99G \
	--output=/home/users/zyfeng/DataSet/Monkey/LiftOver/MT2T_mm10_axt_out/${CHR}.axt
