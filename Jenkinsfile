pipeline {
  
  agent any  
  
  stages {
    stage('checkout') {
      steps {
        checkout scm
  	    }
    	}
    
 
    stage('kubectl command') {
      steps {
	    sh 'kubectl get svc '
      }
    }


  }
  
  
}