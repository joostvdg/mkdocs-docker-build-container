# MKDocs Docker Build Container

[![GitHub release](https://img.shields.io/github/release/joostvdg/mkdocs-docker-build-container.svg)]()
[![license](https://img.shields.io/github/license/joostvdg/mkdocs-docker-build-container.svg)]()
[![Docker Pulls](https://img.shields.io/docker/pulls/caladreas/mkdocs-docker-build-container.svg)]()

This is a docker container for being able to build a site with [MKDocs](http://www.mkdocs.org/).

It includes [MKDocs Material](http://squidfunk.github.io/mkdocs-material/getting-started/) which is a highly recommendable theme.

For more information, see the [requirements.txt](requirements.txt).

## Jenkins 2.0 & Pipeline

This is image is made and maintained for the use in Jenkins pipelines.

Either via the Groovy based Pipeline DSL or the declarative pipeline syntax.

### Groovy DSL

```groovy
node('docker') {
    stage('SCM') {
        checkout scm
    }

    stage('Build Docs') {
        docker.image('caladreas/mkdocs-docker-build-container').inside {
            sh 'mkdocs build'
        }

    }
}

```

### Declarative

```groovy
pipeline {
    agent none
    options {
        timeout(time: 10, unit: 'MINUTES')
        timestamps()
        buildDiscarder(logRotator(numToKeepStr: '5'))
    }
    stages {
        stage('Checkout'){
            agent { label 'docker' }
            steps {
                checkout scm
            }
        }
        stage('Build Docs') {
            agent {
                docker {
                    image "caladreas/mkdocs-docker-build-container"
                    label "docker"
                }
            }
            steps {
                sh 'mkdocs build'
            }
        }
    }
}
```