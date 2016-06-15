# gpdb-docker-lab
Docker lab for setting up GPDB testing env

# Steps to deploy gpdb on Mac OS
1. Download Docker Toolbox and install. Just click "Next" to complete the installation.
2. Download the gpdb-docker.sh script and run it like this. It will take several minutes to pull the image from 10.152.9.39 and run it.
   
   ./gpdb-docker.sh \<port\> \<image\>
3. Access the gpdb env on local Mac.

   ssh gpadmin@\`docker-machine ip\` -p \<port specified in step 2\>

