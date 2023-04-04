# Pharo Launcher [![Build Status](https://ci.inria.fr/pharo-ci-jenkins2/job/PharoLauncher-Pipeline/job/dev/badge/icon)](https://ci.inria.fr/pharo-ci-jenkins2/job/PharoLauncher-Pipeline/job/dev/)
The Pharo Launcher is a cross-platform application that
- lets you manage your Pharo images (launch, rename, copy and delete);
- lets you download image templates (i.e., zip archives) from many
  different sources (e.g., Jenkins, files.pharo.org, and your local cache);
- lets you create new images from any template,
- automatically find and download the appropriate VM to launch your images.

<img src="./docs/images/pharo-launcher-main-window.png" height="450" alt="A Pharo Launcher screenshot">

The idea behind the Pharo Launcher is that you should be able to access it very rapidly from your OS application launcher. As a result,
launching any image is never more than 3 clicks away.

Please report bugs on the 'Launcher' project at [https://github.com/pharo-project/pharo-launcher/issues](https://github.com/pharo-project/pharo-launcher/issues)

You can contribute to this project. All classes and most methods are commented. There are unit tests. Please contribute!

- **Source code:** [https://github.com/pharo-project/pharo-launcher](https://github.com/pharo-project/pharo-launcher)
- **CI:** [https://ci.inria.fr/pharo-ci-jenkins2/blue/organizations/jenkins/PharoLauncher-Pipeline/branches/](https://ci.inria.fr/pharo-ci-jenkins2/blue/organizations/jenkins/PharoLauncher-Pipeline/branches/) [![Build Status](https://ci.inria.fr/pharo-ci-jenkins2/job/PharoLauncher-Pipeline/job/dev/badge/icon)](https://ci.inria.fr/pharo-ci-jenkins2/job/PharoLauncher-Pipeline/job/dev/)

## Motivations
In the past, I had several folders with images everywhere on my HD. Sometimes with the VM, sometimes without. Lots of image searching as you can imagine.
Now, my HD is now much cleaner - all images are in a central place and I need only one icon/starter on the desktop to open. PharoLauncher is also a convenient tool to download specific image update versions if you want to reproduce or fix Pharo bugs. I also associated one of the unused laptop keys with PharoLauncher - so the world of Smalltalk is just one click away...

## How to install?
See http://pharo.org/download for detailed download and installation instructions.

## How to use it?
Just launch the Pharo launcher app.
Usually for "end user experience" the launcher opens in full world mode - so you do not see Pharo background/world menu - only the launcher.

Initially, on a new computer, the right side with local images is empty. On the left side are the template images that are available on the web. Note that there are refresh buttons at the top of the list.

Click "Refresh" on the left list to fetch all available template lists from the web.

Select the template image you like and download it. For instance, you can download "Pharo6.0" -> "60528" which is the latest image as of today. Note that also the images from contribution CI are available.
So you can easily download "Artefact", "Moose", ... images if you like.

The launcher will download the image into a specific directory somewhere in your users home directory (you can configure whereby clicking the Settings button at the bottom of the window).
Each image gets its own folder. Use the "Show in folder" menu item if you want to open this location.

After download, you can "Launch" the image from the context menu in the right list. This will open the new image and close the launcher image. So you are ready to start working.

### Warning: Antinvirus can prevent Pharo Launcher to behave correctly
It has been reported on Windows that the Antivirus prevents Pharo Launcher to download the VMs needed to run images. A workaround is to whitelist PharoLauncher or to temporary disable the antivirus when you need to download new VMs.

## Where are my images?
Launcher files are considered as user documents and so, they are stored in the user document folder, i.e.:
- *$HOME/Documents/Pharo* on OS X,
- *$HOME/My Documents/Pharo* on windows,
- *$HOME/Pharo* on Linux (some Linux distributions provide a document folder but some others not, so we put it in the HOME directory in all cases).
In this folder, you will find your images and virtual machines needed to run images.

### What does the Pharo launcher to launch an image? 
To run an image, Pharo launcher needs to determine the appropriate virtual machine to run it and fetch it from the web if it is not available.
The process is as following:
1. determine the image format version
2. find (and optionally fetch) a compatible VM (a VM able to run this image format) and run the image to get its Pharo version number
3. find (and optionally fetch) the appropriate VM for this specific Pharo image version. Sources files are also downloaded with the VM when applicable.
4. run the image with the appropriate VM

## How would I make my own templates available via Pharo Launcher?
There are different ways:
- The easiest way would be to add a CI job on https://ci.inria.fr/pharo-contribution/. This job should archive a zip file with your image and the changes file. Then you will be able to browse your image as a template from *Pharo contribution Jenkins* / *<your job name>* / *Latest successful build*.
- Another way is to create a fresh image from the *Templates* panel, launch the image, add what you want in the image, save it and then convert the image to a template: right-click on the image on the right panel (*Existing images*) and select *Create Template*. The newly created template will appear in the *Templates* panel under the *Downloaded templates* category.

## Things to know:
At the bottom, there is a button to open a settings browser with specific settings for PharoLauncher. There is an option that enables the IDE again - so you can inspect the code or fix a bug.

If it does not launch on your box then set a breakpoint in PhLImage>>launch to debug.

**Important note**: the launcher currently does not fit with the "Save as" image style - since each launcher image
has to be in a new directory. So either use the "Copy" image, then "Launch" and then only "Save" in the target image or copy the "Saved as" image in a new folder and refresh the Launcher view on the right side.

## Develop the Pharo Launcher

Download the latest stable Pharo image and use Iceberg (Pharo git client) to clone this repository.
Once done, you can load the project through Metacello integration (uses BaselineOfPharoLauncher).

```Smalltalk
Metacello new
	baseline: 'PharoLauncher';
	repository: 'github://pharo-project/pharo-launcher:development/src';
	load
 ```

Then evaluate  "PharoLauncher open". You can also launch it from the World menu.
