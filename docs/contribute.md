## Contribute to Pharo Launcher

### Prepare an environment
#### Prepare an image from scratch
Download the latest stable Pharo image and use Iceberg (Pharo git client) to clone this repository.
Once done, you can load the project through Metacello integration (uses BaselineOfPharoLauncher).

```Smalltalk
Metacello new
    baseline: 'PharoLauncher';
    repository: 'github://pharo-project/pharo-launcher:dev/src';
    load
```

Then evaluate  "PharoLauncher open". You can also launch it from the World menu.
#### Use the Pharo Launcher app
Open Pharo Launcher and click on the settings button in the toolbar.
There is an option that enables the IDE again - so you can inspect the code or fix a bug.

### What does the Pharo launcher to launch an image? 
To run an image, Pharo launcher needs to determine the appropriate virtual machine to run it and fetch it from the web if it is not available.
The process is as following:

1. determine the image format version
2. find (and optionally fetch) a compatible VM (a VM able to run this image format) and run the image to get its Pharo version number
3. find (and optionally fetch) the appropriate VM for this specific Pharo image version. Sources files are also downloaded with the VM when applicable.
4. run the image with the appropriate VM


### Links
- **Source code:** [https://github.com/pharo-project/pharo-launcher](https://github.com/pharo-project/pharo-launcher)
- **CI:** [https://ci.inria.fr/pharo-ci-jenkins2/blue/organizations/jenkins/PharoLauncher-Pipeline/branches/](https://ci.inria.fr/pharo-ci-jenkins2/blue/organizations/jenkins/PharoLauncher-Pipeline/branches/) [![Build Status](https://ci.inria.fr/pharo-ci-jenkins2/job/PharoLauncher-Pipeline/job/dev/badge/icon)](https://ci.inria.fr/pharo-ci-jenkins2/job/PharoLauncher-Pipeline/job/dev/)
