#Install sdk Ebay#
1.  cd to folder /lib in project peace

cd /src/main/webapp/WEB-INF/lib


2.  Run 3 command:

mvn install:install-file -Dfile=ebaysdkcore.jar -DgroupId=com.ebay.sdk -DartifactId=core -Dversion=987 -Dpackaging=jar -DgeneratePom=true



mvn install:install-file -Dfile=ebaycalls.jar -DgroupId=com.ebay.sdk -DartifactId=api -Dversion=987 -Dpackaging=jar -DgeneratePom=true


mvn install:install-file -Dfile=helper.jar -DgroupId=com.ebay.sdk -DartifactId=helper -Dversion=987 -Dpackaging=jar -DgeneratePom=true



#end install ebay#

# README #

This README would normally document whatever steps are necessary to get your application up and running.

### What is this repository for? ###

* Quick summary
* Version
* [Learn Markdown](https://bitbucket.org/tutorials/markdowndemo)

### How do I get set up? ###

* Summary of set up
* Configuration
* Dependencies
* Database configuration
* How to run tests
* Deployment instructions

### Contribution guidelines ###

* Writing tests
* Code review
* Other guidelines

### Who do I talk to? ###

* Repo owner or admin
* Other community or team contact