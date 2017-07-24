# Pharo Launcher
The Pharo Launcher is a cross-platform application that
- lets you manage your Pharo images (launch, rename, copy and delete);
- lets you download image templates (i.e., zip archives) from many
  different sources (e.g., Jenkins, files.pharo.org, and your local cache);
- lets you create new images from any template,
- automatically find and download the appropriate VM to launch your images.

[![A Pharo Launcher screenshot](https://dl.dropboxusercontent.com/u/152013/pharo-launcher-screenshot.small.png)](https://lut.im/X5a3vwrg/j3dzYp3U?t)

The idea behind the Pharo Launcher is that you should be able to access it very rapidly from your OS application launcher. As a result,
launching any image is never more than 3 clicks away.

Please report bugs on the 'Launcher' project at [https://github.com/pharo-project/pharo-launcher/issues](https://github.com/pharo-project/pharo-launcher/issues)

You can contribute to this project. All classes and most methods are commented. There are unit tests. Please contribute!

- **Source code:** [http://www.smalltalkhub.com/#!/~Pharo/PharoLauncher](http://www.smalltalkhub.com/#!/~Pharo/PharoLauncher) (WARNING: will move very soon in this repository)
- **CI:** [https://ci.inria.fr/pharo/view/Launcher](https://ci.inria.fr/pharo/view/Launcher/)

![Build Status](https://ci.inria.fr/pharo/buildStatus/icon?job=Launcher)

## Motivations
In the past I had several folders with images everywhere on my HD. Sometimes with the VM, sometimes without. Lots of image searching as you can imagine.
Now, my HD is now much cleaner - all images are in a central place and I need only one icon/starter on the desktop to open. PharoLauncher is also a very handy tool to download specific image update versions if you want to reproduce or fix Pharo bugs. I also associated one of the unused laptop keys with PharoLauncher - so the world of Smalltalk is just one click away...

## How to install?
- For Linux, download [https://ci.inria.fr/pharo/view/Launcher/job/Publish-Launcher-stable-Linux/](https://ci.inria.fr/pharo/view/Launcher/job/Publish-Launcher-stable-Linux/)
- For Mac OS X, download [https://ci.inria.fr/pharo/view/Launcher/job/Publish-Launcher-stable-Mac/](https://ci.inria.fr/pharo/view/Launcher/job/Publish-Launcher-stable-Mac/)
- For Windows, download [https://ci.inria.fr/pharo/view/Launcher/job/Package-and-Publish-Launcher-stable-Win/](https://ci.inria.fr/pharo/view/Launcher/job/Package-and-Publish-Launcher-stable-Win/)
- For other platforms: [https://ci.inria.fr/pharo/view/Launcher/job/Launcher](https://ci.inria.fr/pharo/view/Launcher/job/Launcher)

## How to use it?
Just launch the Pharo launcher app.
Usually for "end user experience" the launcher opens in full world mode - so you do not see Pharo background/world menu - only the launcher.

Initially on a new computer the left side with local images is empty. On the right side are the template images that are available on the web. Note that there are refresh buttons at the top
of the list.

Click "Refresh" in the right list to fetch all available template lists from the web.

Select the template image you like and download it. For instance you can download "Pharo3.0" -> "30587" which is the latest image as of today. Note that also the images from contribution CI are available.
So you can easily download "Artefact", "Moose", ... images if you like.

The launcher will download the image into a specific directory somewhere in your users home directory (you can configure where by clicking the Settings button at the bottom of the window).
Each image gets an own folder. Use the "Show in folder" menu item if you want to open this location.

After download you can "Launch" the image from the context menu in the right list. This will open the new image and close the launcher image. So you are ready to start working.

## Where are my images?
Launcher files are considered as user documents and so, they are stored in the user document folder, i.e.:
- *$HOME/Documents/Pharo* on OS X,
- *$HOME/My Documents/Pharo* on windows,
- *$HOME/Pharo* on Linux (some linux distributions provide a document folder but some others not, so we put it in the HOME directory in all cases).
In this folder, you will find your images and virtual machines needed to run images.

### What does the Pharo launcher to launch an image? 
To run an image, Pharo launcher needs to determine the appropriate virtual machine to run it and fetch it from the web if it is not available.
The process is as following:
1. determine the image format version
2. find (and optionnaly fetch) a compatible VM (a VM able to run this image format) and run the image to get its Pharo version number
3. find (and optionnaly fetch) the appropriate VM for this specific Pharo image version. Sources files are also downloaded with the VM when applicable.
4. run the image with the appropriate VM

## Things to know:
At the bottom there is a button to open a settings browser with specific settings for PharoLauncher. There is an option that enables the IDE again - so you can inspect the code
or fix a bug.

If it does not launch on your box then set a breakpoint in PhLImage>>launch to debug.

**Important note**: the launcher currently does not fit with the "Save as" image style - since each launcher image
has to be in a new directory. So either use the "Copy" image, then "Launch" and then only "Save" in the target image or copy the "Saved as" image in a new folder and
refresh the Launcher view on the right side.

## Develop the Pharo Launcher

Either use the latest image from CI and enable the IDE as written before.

You can also download the latest stable image. Just use the ConfigurationOfPharoLauncher
from [http://smalltalkhub.com/#!/~Pharo/PharoLauncher](http://smalltalkhub.com/#!/~Pharo/PharoLauncher).

Then evaluate  "PharoLauncher open". You can also launch it from the World menu.
