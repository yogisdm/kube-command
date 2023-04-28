pipeline {
  
  agent any  
  
  stages {
    stage('checkout') {
      steps {
        checkout scm
  	    }
    	}
    
 
    stage('Config-View') {
	steps {
    
        sh 'curl -LO "https://storage.googleapis.com/kubernetes-release/release/v1.20.5/bin/linux/amd64/kubectl"'  
        sh 'chmod u+x ./kubectl'  
		sh 'pwd'
        sh './kubectl get svc'
		sh './kubectl config view'
		sh 'cat ~/.kube/config'
		sh 'cd /home/ubuntu/'
		sh 'cat ~/.kube/config'
    
  }
  }


  }
  
  
}