#!/bin/bash
#SBATCH --job-name=mm10
#SBATCH --output=logs/mm10_axtChain_%a.out
#SBATCH --error=logs/mm10_axtChain_%a.err
#SBATCH --array=1-24
#SBATCH -N 1
#SBATCH --mem=5G
#SBATCH --time=1-00:00:00
#SBATCH -p whwong,normal,stat,hns
#SBATCH --cpus-per-task=81
#SBATCH --mail-type=FAIL,END      # Type of email notification- BEGIN,END,FAIL,ALL
#SBATCH --mail-user=zyfeng@stanford.edu  # Email to which notifications


./bin/chainMergeSort /home/users/zyfeng/DataSet/Monkey/LiftOver/MT2T_mm10_axt_out/chr*.chain > /home/users/zyfeng/DataSet/Monkey/LiftOver/MT2T_mm10_axt_out/all.chain

./bin/chainSort /home/users/zyfeng/DataSet/Monkey/LiftOver/MT2T_mm10_axt_out/all.chain \
	/home/users/zyfeng/DataSet/Monkey/LiftOver/MT2T_mm10_axt_out/all.sorted.chain

./bin/faSize -detailed ../../../EnformerPro/Genome/Mouse/mm10.fa | grep -E "^chr([1-9]|1[0-9]|2[0-2]|X|Y)\s" > /home/users/zyfeng/DataSet/Monkey/LiftOver/mm10.chrom.sizes
#./bin/faSize -detailed ../fasta/Macaque_Assembly.v3-for-encode.fa > /home/users/zyfeng/DataSet/Monkey/LiftOver/MT2T.chrom.sizes

./bin/chainPreNet /home/users/zyfeng/DataSet/Monkey/LiftOver/MT2T_mm10_axt_out/all.sorted.chain \
	/home/users/zyfeng/DataSet/Monkey/LiftOver/mm10.chrom.sizes /home/users/zyfeng/DataSet/Monkey/LiftOver/MT2T.chrom.sizes \
	/home/users/zyfeng/DataSet/Monkey/LiftOver/MT2T_mm10_axt_out/all.pre.chain

./bin/chainNet /home/users/zyfeng/DataSet/Monkey/LiftOver/MT2T_mm10_axt_out/all.pre.chain \
	/home/users/zyfeng/DataSet/Monkey/LiftOver/mm10.chrom.sizes /home/users/zyfeng/DataSet/Monkey/LiftOver/MT2T.chrom.sizes \
	/home/users/zyfeng/DataSet/Monkey/LiftOver/MT2T_mm10_axt_out/mm10.net \
	/home/users/zyfeng/DataSet/Monkey/LiftOver/MT2T_mm10_axt_out/MT2T.net

./bin/netChainSubset /home/users/zyfeng/DataSet/Monkey/LiftOver/MT2T_mm10_axt_out/mm10.net \
	/home/users/zyfeng/DataSet/Monkey/LiftOver/MT2T_mm10_axt_out/all.pre.chain \
	/home/users/zyfeng/DataSet/Monkey/LiftOver/MT2T_mm10_axt_out/lift.chain

./bin/chainSort /home/users/zyfeng/DataSet/Monkey/LiftOver/MT2T_mm10_axt_out/lift.chain \
	/home/users/zyfeng/DataSet/Monkey/LiftOver/MT2T_mm10_axt_out/mm10ToMT2T.over.chain
gzip /home/users/zyfeng/DataSet/Monkey/LiftOver/MT2T_mm10_axt_out/mm10ToMT2T.over.chain
cp /home/users/zyfeng/DataSet/Monkey/LiftOver/MT2T_mm10_axt_out/mm10ToMT2T.over.chain.gz mm10ToMT2T.over.chain.gz

./bin/chainSort /home/users/zyfeng/DataSet/Monkey/LiftOver/MT2T_mm10_axt_out/lift.chain \
	/home/users/zyfeng/DataSet/Monkey/LiftOver/MT2T_mm10_axt_out/mm10ToMT2T.over.chain

./bin/chainSwap /home/users/zyfeng/DataSet/Monkey/LiftOver/MT2T_mm10_axt_out/mm10ToMT2T.over.chain \
	/home/users/zyfeng/DataSet/Monkey/LiftOver/MT2T_mm10_axt_out/MT2TToMm10.over.chain
./bin/chainSort /home/users/zyfeng/DataSet/Monkey/LiftOver/MT2T_mm10_axt_out/MT2TToMm10.over.chain \
	/home/users/zyfeng/DataSet/Monkey/LiftOver/MT2T_mm10_axt_out/MT2TToMm10.sorted.chain
gzip /home/users/zyfeng/DataSet/Monkey/LiftOver/MT2T_mm10_axt_out/MT2TToMm10.sorted.chain
cp /home/users/zyfeng/DataSet/Monkey/LiftOver/MT2T_mm10_axt_out/MT2TToMm10.sorted.chain.gz MT2TToMm10.over.chain.gz
