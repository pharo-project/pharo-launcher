# Pharo Laucher command-line
This is list of subject oriented CLI commands of Pharo launcher, where subjects are Pharo VM, image or image template of launcher.  
(launcher parent command is not listed, it is implicit)

| Command | Sub-command |                   | Description | 
| ------- | ----------- | ----------------- | ----------- |
| [help](#help-command) |             | | Prints all supported Pharo launcher commands. |
| [image](#images-commands) |           |  | All sub-commands related to management of local Pharo images. (Prints help only) |
|         | [copy](#image-copy-command)   |   | Creates copy of given image with new name. 
|         | [create](#image-create-command)  |  | Downloads and creates new image on local computer from remote site based on template name. |
|         |            | [fromBuild](#image-create-fromBuild)    | Downloads and creates new image based on a the build number. |
|         |            | [fromPR](#image-create-fromPR)    | Downloads and creates new image based on a Github pull request number (from Inria CI server). |
|         |            | [fromRepo](#image-create-fromRepo)    | Downloads and creates new image based on a template and loads user defined project from Github remote repository. |
|         |            | [fromSHA](#image-create-fromSHA)    | Downloads and creates new image based on the commit SHA (7 letter string contained in the name of Pharo dev template). |
|         | [delete](#image-delete-command)    | | Deletes the local image, including image directory content. |
|         | [info](#image-info-command)      | | Prints information about image: name, description, origin template, etc. |
|         | [kill](#image-kill-command)      | | Kills the running process(es) of given local image. |
|         | [launch](#image-launch-command)  | | Launches image with using default (auto-detected) VM. |
|         | [list](#list-images-command)     | | Lists all local images from Pharo laucher repository. |
|         | [package](#image-package-command)     | | Creates a package containing all necessary artefacts to launch the image. |
|         | [processList](#image-processList-command)     | | Lists all running Pharo image processes. |
|         | [recreate](#image-recreate-command)     | | Recreates the local image, the image argument determines the image name to recreate. |
| [template](#templates-commands) |         | | All sub-commands related to image templates. (Prints help only) | 
|         | [categories](#template-categories-command) | | Lists all image template categories, based on which are image templates categorized. |
|         | [info](#template-info-command)      | | Prints information about image template name, origin url. |
|         | [list](#list-templates-command)    |  | Prints list of image templates. |
| [vm](#vms-commands)    |            | | All sub-commands related to VM management. (Prints help only) |
|         | [delete](#delete-vm-command)    | | Deletes VM executable from local computer, including dependencies. |
|         | [info](#info-vm-command)     | | Prints information about VM: name, remote-site URL, last update status, etc. |
|         | [list](#list-vms-command)     | | Lists all available VMs, with status. |
|         | [update](#update-vm-command)   | | Updates VM executable, including depedent libs to latest version from remote site. |


# Getting started
Command line interface of Pharo Launcher is avaliable from directory, where launcher is installed.  
Pharo Launcher CLI can be executed using: `pharo-launcher.sh <command>` (choosing on of the commands above).
## 1. List Pharo images
You can start listing Pharo images deployed by Pharo launcher by: `pharo-launcher.sh image list`
This will give output like:
```
#  Name                                             Architecture Pharo version Last modified      
-- ------------------------------------------------ ------------ ------------- -------------------
1  Pharo 9.0 - 64bit (stable)                       64           90            2021-11-13 13:18:02
2  P8                                               64           80            2022-03-01 17:05:56
3  Pharo 11.0 - 64bit (development version, latest) 64           110           2022-05-30 15:40:21
4  Pharo10.0-PR-10553-64bit-5ce32be                 64           100           2022-06-02 16:50:21
5  Pharo 10.0 - 64bit (stable)                      64           100           2022-06-17 12:26:09
```
## 2. Create new Pharo image
New Pharo image can be created by executing: `pharo-launcher.sh image create myImage`  
This will efectively create Pharo image based on latest stable Pharo release template.
Output looks like this:
```
Creating the local Pharo image based on template: Pharo 10.0 - 64bit (stable).
Please wait a moment.
Done!
```
You could check result by listing Pharo images again.  
> __Note__: There are other ways to create images, check sub-commands. 

## 3. Launching Pharo image
To launch image, execute following: `pharo-launcher.sh image launch myImage`  
This will start new Pharo process and window with Pharo should be visible. Check command options, to see how to pass launch configuration.

## 4. Listing running Pharo images
To see, which Pharo images are running: `pharo-launcher.sh image processList`  
Output will look similar like this:
```
3093 /home/dbajger/Pharo/vms/100-x64/lib/pharo /home/dbajger/Pharo/images/myImage/myImage.image
```
## 5. Kill running Pharo image process
To kill running Pharo process execute:  `pharo-launcher.sh image kill myImage`  
This will kill all running images with name `myImage`.  
You can also use specific PID, to precisely specify process to kill instead of name of image.

## 6. Create package with Pharo image
To pack existing image with VM and all artefacts you can run: `pharo-launcher.sh image package myImage /home/dbajger/fresh`  
This will create new directory in `/home/dbajger/fresh` with image and all artefacts.
> __Note__: You can also use `--zip` option to have just zip archive with image artifacts (see details below). 

## 7. Deleting existing image
To delete image and its directory, run: `pharo-launcher.sh image delete myImage`  
You can list Pharo images again to check that image is deleted.

# Description of all Pharo Launcher CLI commands
# TODO
### Help command  

This is help for command line interface of Pharo Launcher.
Common purpose of laucher is to create Pharo image locally from remote site template, launch Pharo, eventually delete an image, update VMs, etc.
```
Usage:  [command] [--help]

Commands:
TOTO

Options:
-h, --help                Prints help about this command. 
```


## Images commands
### List images command

Lists all available Pharo images on local computer.
Images are ordered by recent modification date.
```
Usage:  image list [--help] 

Options:
-h, --help                Prints help about this command.
--name                    List the images including the substring given after the flag.
```
Example of use:  
```
$ ./pharo-launcher image list
Image name                                 
1: P9-64b-devel                             
2: PharoWeb                                   
3: Pharo 7.0 - 32bit (Exercism new 23) 

$ ./pharo-launcher image list --name dev
1: P9-64b-devel
```

### Image launch command
Launch an image. If it is used with the script flag it launch the image executing the selected script. The script needs to have an st extension. The image full path or the image name can be given to launch it.  
```
Usage:  image launch <imageName> [--script] [scriptPath]

Options:
-h, --help ,               Prints help about this command.
--script ,     			   Launch the image and run the selected script when the image is launched (need the script path)
```
Example of use:  
```
$ ./pharo-launcher image launch "Pharo 7.0 - 32bit (Exercism new 23)"

$ ./pharo-launcher image launch "Pharo 7.0 - 32bit (Exercism new 23)" --script /script/path/myScript.st
```

### Image create command
Create an image. The image will be create in the default image location (if you want to change it see here). If the command is runned without template name, the last Pharo 64bit stable version will be selected. If a template name is given without template category the template will be searched in the 'official distributions' template category. If you want to list the templates or templates categories check the [templates commands](#templates-commands).   
```
Usage:  image create <imageName> [<templateName>] [--templateCategory] [<templateCategoryName>] 

Options:
-h, --help ,               Prints help about this command.
--templateCategory ,       search the template in a specified template category. 
```
Example of use:  
```
$ ./pharo-launcher image create myNewImageName
creates an image based on the last pharo stable 64bits version. 

$ ./pharo-launcher image create myNewImageName "Pharo 7.0 - 64bit (old stable)"
creates an image based on the template 'Pharo 7.0 - 64bit (old stable)' which will be searched in the official distributions template category.

$ ./pharo-launcher image create myNewImageName "Pharo Mooc" --templateCategory "Pharo Mooc"
creates an image based on the template 'Pharo Mooc' which will be searched in the template category 'Pharo Mooc'.
```

### Image copy command
Copy an image to make a new image. 
```
Usage:  image copy <existingImageName> <newImageName>

Options:
-h, --help ,               Prints help about this command.
```
Example of use:  
```
$ ./pharo-launcher image copy "Pharo 7.0 - 32bit (Exercism new 23)" myNewImageName
```

### Image delete command
Delete an image from an image name.

```
Usage:  image delete <newImageName>

Options:
-h, --help ,               Prints help about this command.
```
Example of use:  
```
$ ./pharo-launcher image delete "Pharo 7.0 - 32bit (Exercism new 23)" 
```
### Image info command
Displays informations on an image. The informations displayed are Image name, Last modified, Description, Origin template, Origin template URL and Image directory. An image path or an image name can be given. 
```
Usage:  image info <imageName>  

Options:
-h, --help                Prints help about this command.
```
Example of use:  
```
$ ./pharo-launcher image info "Pharo 7.0 - 32bit (Exercism new 23)"
Image name:           Pharo 7.0 - 32bit (Exercism new 23
Last modified:        2019-10-10T08:34:59+1:00
Description:          (not available)
Origin template:      Pharo 7.0 - 32bit (stable)
Origin template URL:  https://files.pharo.org/image/70/latest.zip
Image directory:      "/usr/local/user/images/Pharo 7.0 - 32bit (Exercism new 23"

```
## Templates commands
### List templates command

Lists all templates in a template categrory. By default in 'official distributions'. You can select another template category with the flag --templateCategory. If you want the list of the templates categories see [here](#template-categories-command).
```
Usage:  template list [--templateCategory] [<aTemplateCategoryName>] 

Options:
-h, --help                Prints help about this command.
--templateCategory        Select another template category 
```
Example of use:  
```
$ ./pharo-launcher template list
1: Pharo 9.0 - 32bit (development version, latest)
2: Pharo 9.0 - 64bit (development version, latest)
3: Pharo 8.0 - 32bit (stable)
4: Pharo 8.0 - 64bit (stable)
5: Pharo 7.0 - 32bit (old stable)
6: Pharo 7.0 - 64bit (old stable)
7: Moose Suite 9.0 (development)
8: Moose Suite 8.0 (stable)

$ ./pharo-launcher template list --templateCategory "Deprecated distributions"
1: Pharo 6.1 - 32bit
2: Pharo 6.1 - 64bit
3: Pharo 5.0
4: Pharo 4.0
5: Pharo 3.0
6: Pharo 2.0
```
### Template categories command
Displays all the existing templates categories.
```
Usage:  template categories

Options:
-h, --help                Prints help about this command.
```
Example of use:  
```
$ ./pharo-launcher template categories
1: Templates
2: Pharo Mooc
3: Official distributions
4: Deprecated distributions
5: Pharo Contribution Jenkins
6: Moose Jenkins
7: Pharo 8.0 (stable)
8: Pharo 9.0 (development version)
9: Pharo IoT (PharoThings)
10: Pharo Remote Development (TelePharo)
```

### Template info command
Displays the url of a template. By default the template will be searched in 'official distributions'. You can select another template category with the flag --templateCategory. If you want the list of the templates categories see [here](#template-categories-command).
```
Usage:  template info <templateName> [--templateCategory] [<templateCategoryName>]  

Options:
-h, --help                Prints help about this command.
--templateCategory        Select another template category 
```
Example of use:  
```
$ ./pharo-launcher template info "Pharo 8.0 - 64bit (stable)"
https://files.pharo.org/image/80/stable-64.zip

$ ./pharo-launcher template info "Pharo Mooc" --templateCategory "Pharo Mooc"
https://mooc.pharo.org/image/PharoWeb.zip
```
## VMs commands
### List VMs command

Lists all the virtual machines available.
```
Usage: vm list 

Options:
-h, --help                Prints help about this command.
```
Example of use:  
```
$ ./pharo-launcher vm list
1: 90-x64
2: 80-x64-headless
3: 70-x64
4: 80-x64
5: 70-x86
```
### Info VM command
Gives informations on a virtual machines, the informations displayed are Name, last update and dowload Url.
```
Usage: vm info <vmName> 

Options:
-h, --help                Prints help about this command.
```
Example of use:  
```
$ ./pharo-launcher vm info 90-x64
name: 90-x64
last update: 2020-02-12T05:07:16+02:00
download Url: https://files.pharo.org/get-files/90/pharo64-linux-stable.zip
```

### Update VM command
Update the selected virtual machine.
```
Usage: vm update <vmName> 

Options:
-h, --help                Prints help about this command.
```
Example of use:  
```
$ ./pharo-launcher vm update 90-x64
```

### Delete VM command
Delete the given virtual machine.
```
Usage: vm delete <vmName> 

Options:
-h, --help                Prints help about this command.
```
Example of use:  
```
$ ./pharo-launcher vm delete 90-x64
```

# Exemple scenarios 
## Example: Launch the last pharo stable image with a script
First lets write a script, this script changes the default police colors. 
```bash
Metacello new
    baseline: 'PharoDawnTheme';
    repository: 'github://sebastianconcept/PharoDawnTheme';
    load

``` 
Then we save our script with the st extention (in our exemple we save it at /home/user/Desktop/demoScript.st).
Now lets create or image using the last stable pharo version:
```bash 
./pharo-launcher image create myNewImage
```
see [here](#image-create-command) if you don't understand the previous command.
Finaly lets run the launch command with a script flag: 
```bash
./pharo-launcher image launch myNewImage --script /home/user/Desktop/demoScript.st
```
see [here](#image-launch-command) if you don't understand the previous command.
Here we go, our image is launch and the script we created is runned at startup.

## Example: Create a Mooc image
The first step is to find in which template category the pharo mooc image might be. Lets list the templates categories:
```bash 
$ ./pharo-launcher template categories
1: Templates
2: Pharo Mooc
3: Official distributions
4: Deprecated distributions
5: Pharo Contribution Jenkins
6: Moose Jenkins
7: Pharo 8.0 (stable)
8: Pharo 9.0 (development version)
9: Pharo IoT (PharoThings)
10: Pharo Remote Development (TelePharo)
```
Now that we know that there is a Pharo Mooc template category lets list the image in it:
```bash
$ ./pharo-launcher template list --templateCategory "Pharo Mooc"
1: Pharo Mooc
```
There is only one image, named "Pharo Mooc"
We can now create our new image:
```bash
./pharo-launcher image create myPharoMoocImage "Pharo Mooc" --templateCategory "Pharo Mooc"
```
We have create a new image called myPharoMoocImage and based on the Pharo Mooc template.
