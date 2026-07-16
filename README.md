# UFS Land DA v3.0 AWS Parallel Cluster Build Scripts

The Unified Forecast System (UFS) is a community-based, coupled, comprehensive Earth modeling system. It is designed to be the source system for NOAA's operational numerical weather prediction applications while enabling research, development, and contribution opportunities for the broader Weather Enterprise. For more information about the UFS, visit the UFS Portal at https://ufs.epic.noaa.gov/.

This repository includes the build scripts to create AWS Parallel Cluster for Land DA v3 container. Check out the [AWS_Create_UtilityHost_ParallelCluster_Instructions.pdf](https://github.com/NOAA-EPIC/aws-landda-tutorial/blob/main/AWS_Create_UtilityHost_ParallelCluster_Instructions.pdf) for detailed step-by-step instructions. 

The following files were used to build that infrastructure and can be used as reference if any of text below is missing crucial information: _build_da_cluster.pkr.hcl_, _da-cluster-start-script.sh_, and _da_hpc.yaml_. 

_**build-utility.sh**_
Once users are connected to the Utility host, run the utility build script

Copy the Utility build script as follows

`wget https://github.com/NOAA-EPIC/aws-landda-tutorial/blob/main/build-utility.sh`

Run "build-utility.sh" as follows to install git and hashicorp utility packer 

`./build-utility.sh`

Clone the **aws-landda-tutorial** repo to copy the build script required to create the Land DA AWS Parallel Cluster

`git clone https://github.com/NOAA-EPIC/aws-landda-tutorial.git`

_**build_da_cluster.pkr.hcl**_  
This is an automated script used to build a custom AWS AMI for running Land DA v3 test cases. This AMI is will be used by the ParallelCluster configuration file (da_hpc.yaml) to launch the actual cluster.
This script tells HashiCorp Packer how to build a customized AWS EC2 image for AWS region “us-east-1” that includes AWS region, instance type,  compilers (GNU, Intel OneAPI); libraries needed; tools (Rocoto, Lmod); utilities (git, CMake, m4, etc.); directory structure under /opt; environment modules; cluster ready configuration. It automates the entire setup so users can launch a ready to use Land DA cluster on AWS.
Update _build_da_cluster.pkr.hcl_ and run it as follows

`packer build build_da_cluster.pkr.hcl`

_**da-cluster-start-script.sh**_  
This is a startup script for an AWS EC2 instance for Land DA. It sets up the environment for running Land DA workflows, loads required modules, prepares directories, and configures the cluster node

_**da_hpc.yaml** _
This file is an AWS ParallelCluster configuration file that tells the AWS Parallel cluster how to create to deploy a HPC cluster. It defines the cluster type, instructs to use the AMI built earlier using build_da_cluster.pkr.hcl, scheduler, node config etc.
Head node (c7i.2xlarge): This is the controller or login node for the cluster; SSH into it, submit jobs, manage files, and monitor the cluster; can not run computationally heavy Land DA experiments
Compute nodes (c7i.24xlarge): These nodes actually run the Land DA system
Ubuntu 22.04:  The operating system installed 
Other relevant information can be found in _da_hpc.yaml_.

Run the following command to create the initial cluster

`Pcluster create-cluster –region us-east-1 –cluster-name landda-tutorial-cluster --cluster-configuration da_hpc.yaml`
