# aws-cicd
This is a repo of ci/cd implementation in AWS. I am using here a simple python flask webapp to deploy it to ec2 using aws CodePipeline.

**Steps:**
* **configure aws CodeCommit** 

  setup Https connection with a aws codeCommit repo with any code editor(like vscode)and push all the files (my git repo files)

* **Configure SSM**
    create 3 secure string **/flaskapp/docker-credentials/username** , **/flaskapp/docker-credentials/password** , **/flaskapp/docker-registry/url** in parameter store [value will the the actual value of like username and password]
     
 * **configure aws CodeBuild**   

   create a build project ->Source provider(aws CodeCommit) ->os(ubuntu ,standard,latest image)
[using this os the project will be builed using the buildspec.yml file]
     
   configure a service a which will have the policies like[AWSCodeCommitPowerUser,AWSCodeCommitFullAccess, AmazonSSMFullAccess,AmazonEC2FullAccess etc] . It is totally depends on the project. 
  
  **Service roles grants permissions to one service to talk to or use other services**

* **configure aws CodeDeploy**    
    
    create an ec2 instance-> create an application(on Ec2) -> then a deployment group [value of name tag will the name of ec2 created]-> then a deployment

Give[security->modify IAM role] the ec2 instance a service role[AmazonEC2RoleforAWSCodeDeploy,AWSCodeDeployFullAccess,AmazonEC2RoleforAWSCodeDeployLimited]
create a service role using polies
    [AmazonEC2FullAccess AmazonEC2RoleforAWSCodeDeploy,AmazonEC2RoleforAWSCodeDeployLimited, AWSCodeDeployRole]

CodeDeploy will deploy the application using the  appspec.yml file 

* **Download CodeDeploy agent**

    The AWS CodeDeploy agent is a software package that, when installed and configured on an instance, makes it possible for that instance to be used in CodeDeploy deployments.

    run the `codedeploy-agent.sh` file on ec2 ssh terminal.

   download docker [`sudo apt-get install docker.io`]

* **create a CodePipeline**

    create a pipeline using CodeCommit as source ,CodeBuild project and CodeDeploy deployment gorup

create a firewall inbound rule for tcp port 5000
the application is running one it ............