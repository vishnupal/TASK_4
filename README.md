# DEVOPS_TASK_4
### Here is i use Jenkins bcz Jenkins supports the master-agent architecture (many build agents completing work scheduled by a master server) making it highly scalable. The master’s job is to schedule build jobs, distribute the jobs to agents for actual execution, monitor the agents, and get the build results. Master servers can also execute build job directly.

### The agents’ task is to build the job sent by the master. A job can be configured to run on a particular type of agent, or if there are no special requirements, Jenkins can simply choose the next available agent.

### This project will help to deploy a website using a Dynamic Distributed Jenkins Cluster on Kubernetes using a remote Slave Node. Everything is configured in such a way that at the moment developer will commit the Dockerfile and webUI code on GitHub, the slave will launch the Distributed cluster and the image will be built and pushed to Dockerhub and the Deployment will be started on K8s. If the developer updates the code and recommits it, the Cluster will use its Rolling Updates feature to update the Website and the website will be uploaded with zero Down Time.

## TASK DESCRIPTION

### Create container image that’s has Linux and other basic configuration required to run Slave for Jenkins. ( example here we require kubectl to be configured ) 


### The slave image should have the ssh enabled with credentials and the root directory , java installed

### Here i create Dockerfile for building an image which would work as Jenkins Agent having kubectl setup.
![](images/dockerfile.jpg)
### here i create a config file for k8s this help me  When i launch the job it should automatically starts job on slave based on the label provided for dynamic approach.
![](images/config.jpg)


### I configure docker service file for launching the Dynamic slave using Docker containers remotely ,we have to do the following changes in the /usr/lib/systemd/system/docker.service so that the docker client can remotely connect to docker server.
### here i add 
```
-H tcp://0.0.0.0:<port_number>
```

![](images/docker-service.jpg)

### when we sucessfully changing in the service file, then  to update internal settings we need to run the following commands
```
       systemctl daemon-reload

       systemctl restart docker 
```
### Now I Configure Cloud Node  in Jenkins
### First of all for this setup we need to have Docker plugin installed. 

### Go to Manage Jenkins > Manage Nodes and Clouds > Configure Clouds > Add a new Cloud > Docker

![](images/cloud-config.jpg)
![](images/cloud-config1.jpg)


### Here we need to specify the Docker Image Name , Name of the Node and the remote root directory and also the Label to be provided so that we can use it to restrict the job on this dynamic slave node.



![](images/cloud-config2.jpg)

### Here we need to specify our username and password for ssh remote login and remote program execution.

## Job1: Here I Pull the Github repo automatically when some developers push repo to Github and perform the following operations as:

### Create the new image dynamically for the application and copy the application code into that corresponding docker image

### Push that image to the docker hub (Public repository) 
### ( Github code contain the application code and Dockerfile to create a new image )
![](images/dockerfile-httpd.jpg)

![](images/Task1.jpg)
![](images/Task2.jpg)
![](images/Task3.jpg)
