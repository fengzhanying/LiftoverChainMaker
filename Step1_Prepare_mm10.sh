./faSplit byname ../../../EnformerPro/Genome/Mouse/mm10.fa /home/users/zyfeng/DataSet/Monkey/LiftOver/mm10_split/
for i in `ls /home/users/zyfeng/DataSet/Monkey/LiftOver/mm10_split | grep fa | sed s/.fa//g`
do
	./faSize /home/users/zyfeng/DataSet/Monkey/LiftOver/mm10_split/${i}.fa -detailed > /home/users/zyfeng/DataSet/Monkey/LiftOver/mm10_split/${i}.sizes
	./faToTwoBit /home/users/zyfeng/DataSet/Monkey/LiftOver/mm10_split/${i}.fa /home/users/zyfeng/DataSet/Monkey/LiftOver/mm10_split/${i}.2bit
	echo $i
done
