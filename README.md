# Hadoop and MapReduce
----------

## Introduction
This repository contains source code for the assignments of Udacity's course, [Introduction to Hadoop and MapReduce](https://www.udacity.com/course/ud617), which was unveiled on 15th November, 2013.

The exercises have been done in Python using Hadoop Streaming.

## Instructions for Virtual Machine download and setup
Refer to the [instructions document](https://docs.google.com/document/d/1v0zGBZ6EHap-Smsr3x3sGGpDW-54m82kDpPKC2M6uiY/pub) provided by Course Instructors for details on the Hadoop Virtual Machine (VM) setup required for running these examples.

As mentioned in the instructions, the VM image with Hadoop installed and preconfigured, can be downloaded from [Udacity CDN](http://content.udacity-data.com/courses/ud617/Cloudera-Udacity-Training-VM-4.1.1.c.zip). The VM includes the data used in the project, however alternative links to download the data are given in the instructions.

To login to this Virtual Machine, the password and username are: `training` / `training`. Just in case if you need it, the password for `root` is `training`.

## Instructions to interact with Virtual Machine

From the terminal, the virtual machine can be accessed using `ssh training@address`

To find the address, go to the virtual machine consol and type ifconfig. For more instructions please see this [link](https://docs.google.com/document/d/1MZ_rNxJhR4HCU1qJ2-w7xlk2MTHVqa9lnl_uj-zRkzk/pub). To exit, simply type `exit`. The VM will also need to have a 'Bridged Connection' setting for its network settings.

File can be copied back and forth easily using `scp` or `sftp`. The mains commands used in sftp are: `put <file>`, to place the file in the present working directory to the remote; and `get <file>` to download the file form the remote to the local. Refer to the help menu for sftp for further instructions.

## Instructions for use of code

Using sftp, copy the P1 and P2 folders to udacity_training/code and run the bash scripts execution_steps_1.sh and execution_steps_2.sh respectively. In order to copy a entire folder to a remote, first a folder with the same name (e.g P1) must be created in the remote. This can be done using `mkdir` in the sftp interactive shell.

If running the whole bash script takes too long, Individual mapper and reducer combinations can be run using:

>`hs mapper.py reducer.py input_folder output_folder`

Look inside the bash script file to get a list of all the commands used.

To increase performance, see the notes below for use of combiners with the mappers and reducers.

To observe the in progress jobs, go to localhost:50030 on your web brower in the virtual machine.

## Explaination of Projects

### Project 1

Question 1:<br> 
What is the value of total sales for the following categories?<br>
* Toys<br>
* Consumer Electronics<br>

Question 2:<br>
Find the monetary value for the highest individual sale for each separate store.<br>

What are the values for the following stores?
* Reno<br>
* Toledo<br>
* Chandler<br>

Question 3:<br>
1. Find:<br>
* Total sales value across all the stores<br>
* Total number of sales<br>

### Project 2

Question 1:<br>
Write a MapReduce program which will display the number of hits for each different file on the Web site.<br>

Find:<br>
* How many hits were made to the page: /assets/js/the-associates.js?<br>

Question 2:<br>
Find:<br>
* How many hits were made by the IP address: 10.99.99.186?<br>

Question 3:<br>
Find the most popular file on the Web site. In other words, the file which had the most hits. The reducer should just write out the name of the file and number of hits into HDFS.<br>

Find:<br>
* Full path to the most popular file?
* Number of hits to that file?


## Notes

The 'hs' alias from the .basrc file in the virtual machine is as
follows:<br>

```
run_mapreduce() {
	hadoop jar /usr/lib/hadoop-0.20-mapreduce/contrib/streaming/hadoop-streaming-2.0.0-mr1-cdh4.1.1.jar -mapper $1 -reducer $2 -file $1 -file $2 -input $3 -output $4
}

alias hs=run_mapreduce
```

The amount of mappers and reducers can be edited through the `hs` alias

## Adding Combiners

Add the following to the .bashrc file in the home directory on the VM.

```
run_mapreduce_with_combiner() {
	hadoop jar /usr/lib/hadoop-0.20-mapreduce/contrib/streaming/hadoop-streaming-2.0.0-mr1-cdh4.1.1.jar -mapper $1 -reducer $2 -combiner $2 -file $1 -file $2 -input $3 -output $4
}


alias hsc=run_mapreduce_with_combiner
```

The copy settings for the VM should be set to bidirectional to copy and paste from a local to a remote VM.

The above command will use the same reducer.py file as the reducer on the output of each mapper. With the combiners, running map reduce will be faster. When there is a large amount of data, it is sometimes nessesary to have a combiners pre-reduction step. Running map reduce with a combiner on p1q1 results in hadoop completing the job in 192s. With only the reducer and mapper, the same job is completed in 242s. This difference is significant!




