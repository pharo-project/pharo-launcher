# Pharo Launcher

The Pharo Launcher is a cross-platform application that
- lets you manage your Pharo images (launch, rename, copy and delete);
- lets you download image templates (i.e., zip archives) from many different sources (e.g., Jenkins, files.pharo.org, and your local cache);
- lets you create new images from any template,
- automatically find and download the appropriate VM to launch your images.

With the Pharo Launcher, you will be able to access any image very quickly from your OS application launcher. Then, launching an image is never more than 3 clicks away.

## Installation

Download latest stable Pharo Launcher from [http://files.pharo.org/pharo-launcher](http://files.pharo.org/pharo-launcher).
- For Linux, download PharoLauncher-linux-xxx.zip
- For Mac OS X, download PharoLauncher-xxx.dmg
- For Windows, download pharo-launcher-installer-xxx-x86.exe.
For Linux and Mac, there are both 32-bits (x86) and 64-bits (x64) bundles.

## How to Use - First Steps

The Pharo Launcher is a desktop application.

<img src="https://github.com/pharo-project/pharo-launcher/raw/master/figures/pharo-launcher-main-window.png" height="450" alt="A Pharo Launcher screenshot">


The UI presents two main concepts:
 - templates, used to create new images, on the left pane
 - images, the actual pharo images to work with, on the right pane

You can create a new image by selecting a template from the left pane and clicking on the "new" button on the top, or just double click on it. For instance, you can download "Pharo6.0" -> "60546" which is the latest image stable version of Pharo6.* as of today. Then the new image will appear in the list on the right.

To launch your image, you select it on the list on the right, and click on the "launch" button on the top, or just double click on it.

### Special cases for Windows Users

#### ‘The system administrator has set policies to prevent this installation’
When installing the .msi file for PharoLauncher, a user might encounter the following error when trying to install to their AppData folder:

> The system administrator has set policies to prevent this installation

This can be resolved using the following procedure. The procedure will work as long as the user has local administrator rights.

- Start gpedit.exe
- Go to Computer Configuration > Administrative Templates > Windows Components > Windows Installer > "Turn off Windows Installer".
- Set the value to ‘Enable’ and options “Never”

#### Non-Ascii paths

The launcher cannot correctly handle right now paths containing non-ascii characters in Windows.
The launcher will still be able to create and download images and templates, but it will not be able to launch them.

If your account's username contains non-ascii characters, change the images/vm directories from settings to a path containing non-ascii values.

## FAQ

### Where are my images?

The launcher downloads images and virtual machines into a directory in your users HOME directory. 
Launcher files are considered as user documents and so, they are stored in the user document folder, i.e.:
- *$HOME/Documents/Pharo* on OS X,
- *$HOME/My Documents/Pharo* on windows,
- *$HOME/Pharo* on Linux (some linux distributions provide a document folder but some others not, so we put it in the HOME directory in all cases).
In this folder, you will find your images and virtual machines needed to run images.

The directories where they are stored is configurable in the settings, accessed from the button at the bottom right of the window. Keep in mind that images and VMs should be in different directories.

### How are images/VMs stored?

Each image/vm gets its own folder, inside the corresponding image/vm folder.

### How does the Pharo launcher launch an image? 

To run an image, Pharo launcher determines the appropriate virtual machine to run it and downloads it if not available. The process is as following:
1. determine the image format version
2. find (and optionnaly fetch) a compatible VM (a VM able to run this image format) and run the image to get its Pharo version number
3. find (and optionnaly fetch) the appropriate VM for this specific Pharo image version. Sources files are also downloaded with the VM when applicable.
4. run the image with the appropriate VM

### What are all those templates?

The most used templates are the default Pharo downloads.
However, images created from the pharo-contribution Continuous Integration server are also available. This makes available build results like "Artefact", "Moose", etc.

### How can I add my own template?

- The easiest way would be to add a CI job on https://ci.inria.fr/pharo-contribution/. This job should archive a zip file with your image and the changes file. Then you will be able to browse your image as a template from *Pharo contribution Jenkins* / *<your job name>* / *Latest sucessful build*.
- Another way is to create a fresh image from the *Templates* panel, launche the image, add what you want in the image, save it and then convert the image to a template : right-click on the image on the right panel (*Existing images*) and select *Create Template*. The newly created template will appear in the *Templates* panel under the *Downloaded templates* category.

More ways to extend this will be added in the future.

### How does the launcher do if I "Save as" an image?

The launcher currently does not fit with the "Save as" image style - since each launcher image
has to be in a new directory. So either use the "Copy" image, then "Launch" and then only "Save" in the target image or copy the "Saved as" image in a new folder and refresh the Launcher view on the right side.

## Contribute

Please report bugs on the 'Launcher' project at [https://github.com/pharo-project/pharo-launcher/issues](https://github.com/pharo-project/pharo-launcher/issues)

You can contribute to this project. All classes and most methods are commented. There are unit tests. Please contribute!

### CI

Currently the launcher is built and tested on Jenkins: 
[https://ci.inria.fr/pharo-ci-jenkins2/job/PharoLauncher/](https://ci.inria.fr/pharo-ci-jenkins2/job/PharoLauncher/)

![Build Status](https://ci.inria.fr/pharo-ci-jenkins2/job/PharoLauncher/buildStatus/icon?job=PharoLauncher)


### Developing the Pharo Launcher

- Versions <= 1.4.* are stored on Monticello's [http://www.smalltalkhub.com/#!/~Pharo/PharoLauncher](http://www.smalltalkhub.com/#!/~Pharo/PharoLauncher). They can be loaded by loading the ConfigurationOfPharoLauncher from the repository.


- The *development* branch contains now the new version, basis for the incoming 2.* versions. You can load them in latest Pharo7 with Iceberg.


### Go into "Development Mode"
From an existing launcher, you can activate development mode, and have development tools to change and debug. Then you can evaluate "PharoLauncher open". You can also launch it from the World menu.


## ChangesLog

### Version 1.4.4
 - Fixing windows shortcut packaging

### Version 1.4.3
 - Fixing tests

### Version 1.4.2
 - Improvements: Better handling of encoding while launching images
 - Add a warning when trying to run a command with non ASCII characters on Windows
 
### Version 1.4.1
 - Improvements: Better handling of encoding while reading environment variables

### Version 1.4.0

- Improvements:
  - Add Origin Template Column
  - Simplify Timestamp Printing
- Bug fixes:
  - #233 Cannot launch recent Pharo 7 images