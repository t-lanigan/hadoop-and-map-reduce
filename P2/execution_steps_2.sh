
# allows for bash script to recognize aliases defined in system.
# specifically the 'hs' command.
shopt -s expand_aliases
source ~/.bashrc

cd /home/training/udacity_training/code/P2

gunzip ../../data/access_log.gz

hadoop fs -rm -r acc_p2q1
hadoop fs -rm -r acc_p2q2
hadoop fs -rm -r acc_p2q3

hadoop fs -mkdir acc
hadoop fs -put ../../data/access_log acc/

#test the mapper and reducer
head -n 10  ../../data/access_log | ./p2q1_mapper.py | ./p2q1_reducer.py 

#run full mapper and reducer
time hs p2q1_mapper.py p2q1_reducer.py acc acc_p2q1
hadoop fs -get acc_p2q1/part* acc_p2q1.tsv

#test the mapper and reducer
head -n 10  ../../data/access_log | ./p2q2_mapper.py | ./p2q2_reducer.py 

#run full mapper and reducer
time hs p2q2_mapper.py p2q2_reducer.py acc acc_p2q2
hadoop fs -get acc_p2q2/part* acc_p2q2.tsv

#test the mapper and reducer
head -n 10  ../../data/access_log | ./p2q3_mapper.py | ./p2q3_reducer.py 

#run full mapper and reducer
time hs p2q3_mapper.py p2q3_reducer.py acc acc_p2q3
hadoop fs -get acc_p2q3/part* acc_p2q3.tsv
