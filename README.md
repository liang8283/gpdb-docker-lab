# gpdb-docker-lab
Docker lab for setting up GPDB testing env

# Steps to deploy gpdb on Mac OS
1. Download Docker Toolbox (https://www.docker.com/products/docker-toolbox) and install. Just click "Next" to complete the installation.
2. Download and run the gpdb-docker.sh (https://drive.google.com/open?id=0B0xXFikI5TCIcDRnOG02ZXlrZ0k) script on local Mac. It will take several minutes to pull the image from 10.152.9.39 and run it.
   
   Images available at the moment:

   1) gpdb_4382

   2) gpdb_ccb
   
   ./gpdb-docker.sh \<port\> \<image\>

   For example:
   ./gpdb-docker.sh 4382 gpdb_4382

3. Access the gpdb env on local Mac.

   ssh gpadmin@\`docker-machine ip\` -p \<port specified in step 2\>

