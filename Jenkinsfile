node('docker') {
    timestamps {
        step([$class: 'StashNotifier'])         // Notifies BitBucket of an INPROGRESS build
        def imageName = 'cicd-docs-build-image'
        try {
            docker.withRegistry('https://ci.flusso.nl:18443', 'nexus3-docker'){
                stage('SCM') {
                    checkout scm
                }
                def image
                stage('Build Docker Image'){
                    image = docker.build(imageName)
                }
                stage('Dockerfile Lint'){
                    def lintResult = sh returnStdout: true, script: 'docker run --rm -i lukasmartinelli/hadolint < Dockerfile'
                    if (lintResult.trim() == '') {
                        println 'Lint finished with no errors'
                    } else {
                        println 'Error found in Lint'
                        println "${lintResult}"
                        currentBuild.result = 'UNSTABLE'
                    }
                } // end stage
                /* TODO: Currently gives error: Could not analyze layer: Post 172.20.0.3:6060/v1/layers: unsupported protocol scheme
                stage('Docker Image Scan'){
                    step([$class: 'CopyArtifact',
                        filter: 'bin/analyze-local-images',
                        fingerprintArtifacts: true,
                        flatten: true,
                        projectName: 'Scripts/coreos-clair-analyze-local-images',
                        selector: [$class: 'StatusBuildSelector', stable: false]
                    ])
                    def claireImageIp = sh returnStdout: true, script: "docker inspect --format '{{.NetworkSettings.Networks.claire_default.IPAddress }}' clair_clair"
                    claireImageIp = claireImageIp.trim()
                    sh "./analyze-local-images -endpoint ${claireImageIp}:6060 ${imageName}"
                } // end stage
                */
                stage('Tag & Push Docker Image'){
                    image.tag('latest')
                    image.push('latest')
                } // end stage
            } // end withRegistry
        } catch (err) {
            println "Found error: ${err}"
            currentBuild.result = 'FAILED'      // Set result of currentBuild !Important!
        }
        step([$class: 'StashNotifier'])         // Notifies BitBucket of the build result
    } // end timestamps
} // end node
