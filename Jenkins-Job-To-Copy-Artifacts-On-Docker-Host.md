# Creating a job on Jenkins to copy artifacts to docker host
Creating a job on Jenkins that pulls the code from git and builds an artifact then copies the artifact on to docker host server, once the artifact is in docker host server then copying and using that artifact on docker containers will be easy.

### 1. Create a new job on Jenkins provided git address for the project. 
### 2. Within the new build in "Post-build Actions" choose "Send build Artifacts over SSH" using the plugin we installed in Jenkins-Docker-Integration.md file.
### 3. Choose the SSH Server

```sh
# At this point we enter the source files path under the target job. 
/var/lib/jenkins/workspace # This is where the jobs created on Jenkins are.

# Once we find the job within the workspace directory we navigate inside the job and get the source path which is as below
/var/lib/jenkins/workspace/Deploy_On_Tomcat_Server*/webapp/target*
webapp/target/ # The source path for the artifact is under whatever the job name is

# In source file input on Jenkins we enter the path as below to find the artifact ending with .war
webapp/target/*.war

# To remove the prefix before the artifact enter the path in "Remove prefix" field to remove it from the web
webapp/target

# "Remote Directory" is where the artifact is going to be copied on the docker host server, which is in this case the home directory of dockeradmin user that we had created. To allow it copy to the home directory enter a "/"
```

