#!/bin/bash
#SBATCH --job-name=Mm10
#SBATCH --output=logs/Mm10_axtChain_%a.out
#SBATCH --error=logs/MM10_axtChain_%a.err
#SBATCH --array=1-21
#SBATCH -N 1
#SBATCH --mem=5G
#SBATCH --time=1-00:00:00
#SBATCH -p whwong,normal,stat,hns
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

./bin/axtChain -faT -faQ -linearGap=medium -minScore=3000 /home/users/zyfeng/DataSet/Monkey/LiftOver/MT2T_mm10_axt_out/${CHR}.axt \
	/home/users/zyfeng/DataSet/Monkey/LiftOver/mm10_split/${CHR}.fa ../fasta/Macaque_Assembly.v3-for-encode.fa \
	/home/users/zyfeng/DataSet/Monkey/LiftOver/MT2T_mm10_axt_out/${CHR}.chain
