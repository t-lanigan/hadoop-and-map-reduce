
# allows for bash script to recognize aliases defined in system.
# specifically the 'hs' command.
shopt -s expand_aliases
source ~/.bashrc

hadoop fs -rm -r purchases_p1
hadoop fs -rm -r purchases_p1q1
hadoop fs -rm -r purchases_p1q2
hadoop fs -rm -r purchases_p1q3

cd /home/training/udacity_training/code/P1/

hadoop fs -mkdir purchases
hadoop fs -put ../../data/purchases.txt purchases/


time hs p1_mapper.py p1_reducer.py purchases purchases_p1
hadoop fs -get purchases_p1/part* purchases_p1.tsv


time hs p1q1_mapper.py p1q1_reducer.py purchases purchases_p1q1
hadoop fs -get purchases_p1q1/part* purchases_p1q1.tsv


time hs p1q2_mapper.py p1q2_reducer.py purchases purchases_p1q2
hadoop fs -get purchases_p1q2/part* purchases_p1q2.tsv


time hs p1q3_mapper.py p1q3_reducer.py purchases purchases_p1q3
hadoop fs -get purchases_p1q3/part* purchases_p1q3.tsv
