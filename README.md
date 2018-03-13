# MKDocs Docker Build Container

[![GitHub release](https://img.shields.io/github/release/joostvdg/mkdocs-docker-build-container.svg)]()
[![license](https://img.shields.io/github/license/joostvdg/mkdocs-docker-build-container.svg)]()
[![Docker Pulls](https://img.shields.io/docker/pulls/caladreas/mkdocs-docker-build-container.svg)]()
[![](https://images.microbadger.com/badges/image/caladreas/mkdocs-docker-build-container.svg)](https://microbadger.com/images/caladreas/mkdocs-docker-build-container "Get your own image badge on microbadger.com")

This is a docker container for being able to build a site with [MKDocs](http://www.mkdocs.org/).

It includes [MKDocs Material](http://squidfunk.github.io/mkdocs-material/getting-started/) which is a highly recommendable theme.

For more information, see the [requirements.txt](requirements.txt).

<a href='https://ko-fi.com/W7W29DSZ' target='_blank'><img height='36' style='border:0px;height:36px;' src='https://az743702.vo.msecnd.net/cdn/kofi2.png?v=0' border='0' alt='Buy Me a Coffee at ko-fi.com' /></a>-

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