I'm a matrix job (as defined by Jenkins https://wiki.jenkins-ci.org/display/JENKINS/Building+a+matrix+project).

My artifacts are stored in sub-jobs (aka 'runs') that are configured with varying options. For example, a matrix job could have one sub-job that builds a project on the latest stable Pharo and one sub-job that builds the same project on the latest beta Pharo.