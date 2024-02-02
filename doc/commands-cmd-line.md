# Pharo Laucher command-line
This is list of subject oriented CLI commands of Pharo launcher, where subjects are Pharo VM, image or image template of launcher.  
Use: `pharo-launcher <command>`

| Command | Sub-command |                   | Description | 
| ------- | ----------- | ----------------- | ----------- |
| [help](#help) |             | | Prints all supported Pharo launcher commands. |
| [image](#image) |           |  | All sub-commands related to management of local Pharo images. (Prints help only) |
|         | [copy](#image-copy)   |   | Creates copy of given image with new name. 
|         | [create](#image-create)  |  | Downloads and creates new image on local computer from remote site based on template name. |
|         |            | [fromBuild](#Image-create-from-build-number)    | Downloads and creates new image based on a the build number. |
|         |            | [fromPR](#Image-create-from-pull-request)    | Downloads and creates new image based on a Github pull request number (from Inria CI server). |
|         |            | [fromRepo](#Image-create-from-remote-repository)    | Downloads and creates new image based on a template and loads user defined project from Github remote repository. |
|         |            | [fromSHA](#Image-create-from-SHA-commit)    | Downloads and creates new image based on the commit SHA (7 letter string contained in the name of Pharo dev template). |
|         | [delete](#image-delete)    | | Deletes the local image, including image directory content. |
|         | [info](#image-info)      | | Prints information about image: name, description, origin template, etc. |
|         | [launch](#image-launch)  | | Launches image with using default (auto-detected) VM. |
|         | [list](#image-list)     | | Lists all local images from Pharo laucher repository. |
|         | [package](#image-package)     | | Creates a package containing all necessary artefacts to launch the image. |
|         | [recreate](#image-recreate)     | | Recreates the local image, the image argument determines the image name to recreate. |
| [process](#process) |         | | All sub-commands related to Pharo processes. (Prints help only) | 
|         | [kill](#process-kill)      | | Kills the running Pharo process(es) of given image. |
|         | [list](#process-list)     | | Lists all running Pharo image processes. |
| [template](#template) |         | | All sub-commands related to image templates. (Prints help only) | 
|         | [categories](#template-categories) | | Lists all image template categories, based on which are image templates categorized. |
|         | [info](#template-info)      | | Prints information about image template name, origin url. |
|         | [list](#template-list)    |  | Prints list of image templates. |
| [vm](#vm)    |            | | All sub-commands related to VM management. (Prints help only) |
|         | [delete](#vm-delete)    | | Deletes VM executable from local computer, including dependencies. |
|         | [info](#vm-info)     | | Prints information about VM: name, remote-site URL, last update status, etc. |
|         | [list](#vm-list)     | | Lists all available VMs, with status. |
|         | [update](#vm-update)   | | Updates VM executable, including depedent libs to latest version from remote site. |


# Getting started
Command line interface of Pharo Launcher is avaliable from directory, where launcher is installed.  
Pharo Launcher CLI can be executed using: `pharo-launcher <command>` (choosing on of the commands above).
## 1. List Pharo images
You can start listing Pharo images deployed by Pharo launcher by: `pharo-launcher image list`
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
New Pharo image can be created by executing: `pharo-launcher image create myImage`  
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
To launch image, execute following: `pharo-launcher image launch myImage`  
This will start new Pharo process and window with Pharo should be visible. Check command options, to see how to pass launch configuration.

## 4. Listing running Pharo images
To see, which Pharo images are running: `pharo-launcher process list`  
Output will look similar like this:
```
3093 /home/dbajger/Pharo/vms/100-x64/lib/pharo /home/dbajger/Pharo/images/myImage/myImage.image
```
## 5. Kill running Pharo image process
To kill running Pharo process execute:  `pharo-launcher process kill myImage`  
This will kill all running images with name `myImage`.  
You can also use specific PID, to precisely specify process to kill instead of name of image.

## 6. Create package with Pharo image
To pack existing image with VM and all artefacts you can run: `pharo-launcher image package myImage /home/dbajger/fresh`  
This will create new directory in `/home/dbajger/fresh` with image and all artefacts.
> __Note__: You can also use `--zip` option to have just zip archive with image artifacts (see details below). 

## 7. Deleting existing image
To delete image and its directory, run: `pharo-launcher image delete myImage`  
You can list Pharo images again to check that image is deleted.

# Description of all Pharo Launcher CLI commands

## Help  

This is help for command line interface of Pharo Launcher.
Common purpose of laucher is to create Pharo image locally from remote site template, launch Pharo, eventually delete an image, update VMs, etc.  
Run: `pharo-launcher help`

# Image commands
## Image 
Root command of all image commands, prints help only.  
Run: `pharo-launcher image` to see help.

## Image copy
Creates copy of given image with new name.

### Usage
```bash
pharo-launcher image copy [--help] [<existingImageName>] [<newImageName>]
```
### Parameters
    <existingImageName>
                Local image name to be copied.
    <newImageName>
                New image name of a copied image.

### Options
    --help      Prints this documentation

### Examples
**#1:** To copy existing image `myImage` and create new copy `newImage` from it, run: 
```
pharo-launcher image copy myImage newImage
``` 
## Image create
Downloads and creates new image on local computer from remote site based on template name (latest stable template is used by default).
### Usage
```bash
pharo-launcher image create [--help] [--templateName <templateName-value>] [--templateCategory <templateCategory-value>] [<newImageName>]
```
### Parameters
    <newImageName>
                Name of the new Pharo image.

### Options
    --help      Prints this documentation
    --templateName <templateName-value>
                Template which will be used to create the image
    --templateCategory <templateCategory-value>
                Specifies the template category to search the target template.

### Commands
    fromBuild, fromPR, fromRepo, fromSHA

### Examples
**#1:** Creates an image (passing new image name as argument) based on the last pharo stable 64bits version:
```
pharo-launcher image create myNewImageName
```
**#2:** Creates an image based on the template `Pharo 7.0 - 64bit (old stable)` listed in `Official distributions` (default) template category:
```
pharo-launcher image create myNewImageName "Pharo 7.0 - 64bit (old stable)"
```
**#3:** Creates an image based on the template `Pharo Mooc` from template category `Pharo Mooc`:
```
pharo-launcher image create myNewImageName "Pharo Mooc" --templateCategory "Pharo Mooc"
```

## Image create from build number
Downloads and creates new image based on a the build number contained in the Pharo development template.  

### Usage
```bash
pharo-launcher image create fromBuild [--help] [--pharoVersion <pharoVersion-value>] [--newImageName <newImageName-value>] [<buildNumber>]
```
### Parameters
    <buildNumber>
                Pharo build number, from which will be template found and image created.

### Options
    --help      Prints this documentation
    --pharoVersion <pharoVersion-value>
                Version of Pharo to be downloaded.
    --newImageName <newImageName-value>
                Name of the new Pharo image (template name is used by default).
### Examples
No examples yet.

## Image create from pull request
Downloads and creates new image based on a Github pull request number from the successful build of Inria CI server used by Pharo project.

### Usage
```bash
pharo-launcher image create fromPR [--help] [--newImageName <newImageName-value>] [--templateName <templateName-value>] [--templateCategory <templateCategory-value>] [<pullRequest>]
```
### Parameters
    <pullRequest>
                Github pull request number, from which will be image created. If missing, project with its baseline is used to determine correct template.

### Options
    --help      Prints this documentation
    --newImageName <newImageName-value>
                Name of the new Pharo image (template name is used by default).
    --templateName <templateName-value>
                Template which will be used to create the image
    --templateCategory <templateCategory-value>
                Specifies the template category to search the target template.
### Examples
No examples yet.
## Image create from remote repository
Downloads and creates new image based on a template and loads user defined project from Github remote repository into image.

### Usage
```bash
pharo-launcher image create fromRepo [--help] [--newImageName <newImageName-value>] [--templateName <templateName-value>] [--templateCategory <templateCategory-value>] [--subfolder <subfolder-value>] [--baseline <baseline-value>] [--group <group-value>] [<repository>]
```

### Parameters
    <repository>
                Github Repository full name (e.g. {owner}/{project} or {owner}/{project}:{branchOrTag}), from which will be project loaded (based on baseline) into created image.

### Options
    --help      Prints this documentation
    --newImageName <newImageName-value>
                Name of the new Pharo image (template name is used by default).
    --templateName <templateName-value>
                Template which will be used to create the image
    --templateCategory <templateCategory-value>
                Specifies the template category to search the target template.
    --subfolder <subfolder-value>
                The sub-folder containing the code. By default ''src'' sub-folder is used.
    --baseline <baseline-value>
                Specifies the project baseline to be loaded by Metacello command (e.g. PharoLauncher) in PascalCase format. If not specified, baseline is determined from repository name.
    --group <group-value>
                Defines the group as a loadable spec containing only a sub part of the project. If not specified, group 'default' is used.
### Examples
No examples yet.

## Image create from SHA commit
Downloads and creates new image based on the commit SHA (7 letter string) of Pharo build process contained in the name of Pharo development template.

### Usage
```bash
pharo-launcher image create fromSHA [--help] [--pharoVersion <pharoVersion-value>] [--newImageName <newImageName-value>] [<sha>]
```
### Parameters
    <sha>       Commit SHA (7 letters) of Pharo image development template, from which will be  image created.

### Options
    --help      Prints this documentation
    --pharoVersion <pharoVersion-value>
                Version of Pharo to be downloaded.
    --newImageName <newImageName-value>
                Name of the new Pharo image (template name is used by default).
### Examples
No examples yet.

## Image delete
Deletes the local image, including image directory content.

### Usage
```bash
pharo-launcher image delete [--help] [<existingImageName>]
```
### Parameters
    <existingImageName>
                Local image name to be deleted.

### Options
    --help      Prints this documentation

### Examples
No examples yet. 

## Image info
Prints information about image: name, description, origin template, etc.

### Usage
```bash
pharo-launcher image info [--help] [--brief] [--rowMode] [--delimiter <delimiter-value>] [--ston] [<existingImageName>]
```
### Parameters
    <existingImageName>
                Determines the local image name to print detailed information.

### Options
    --help      Prints this documentation
    --brief     Prints only name attribute (with leading sequence number).
    --rowMode   Prints one attribute per line only.
    --delimiter <delimiter-value>
                Specifies the table-cell delimiter that delimits listed information attributes.
    --ston      Prints information in STON format.
### Examples
No examples yet.

## Image launch
Launches image with using default (auto-detected) VM.

### Usage
```bash
pharo-launcher image launch [--help] [--script <script-value>] [<existingImageName>]
```

### Parameters
    <existingImageName>
                Specifies the local image name to be launched.

### Options
    --help      Prints this documentation
    --script <script-value>
                Determines a path to the script when launching an Image.
### Examples
**#1:** To launch image (passing image name argument) with default VM use:
```
pharo-launcher image launch "Pharo 7.0 - 32bit (new 23)"
```
**#2:** To launch image with launch script:
```
pharo-launcher image launch "Pharo 7.0 - 32bit (new 23)" --script /script/path/myScript.st
```

## Image list
Lists all local images from Pharo laucher repository.

### Usage
```bash
pharo-launcher image list [--help] [--nameFilter <nameFilter-value>] [--brief] [--rowMode] [--delimiter <delimiter-value>] [--ston]
```

### Options
    --help      Prints this documentation
    --nameFilter <nameFilter-value>
                Images listing will be filtered by the provided name filter.
    --brief     Prints only name attribute (with leading sequence number).
    --rowMode   Prints one attribute per line only.
    --delimiter <delimiter-value>
                Specifies the table-cell delimiter that delimits listed information attributes.
    --ston      Prints information in STON format.
### Examples
No examples yet.

## Image package
Creates a package containing all necessary artefacts to launch the image.

### Usage
```bash
pharo-launcher image package [--help] [--zip] [--vm <vm-value>] [<existingImageName>] [<location>]
```
### Parameters
    <existingImageName>
                Local image name, for which is package created.
    <location>
                Specifies the directory path, where resulting package will be stored.

### Options
    --help      Prints this documentation
    --zip       Creates the package with image as a ZIP file.
    --vm <vm-value>
                Specifies the VM used for launching the image.

### Examples
No examples yet.

## Image recreate
Recreates the local image, the image argument determines the image name to recreate.

### Usage
```bash
pharo-launcher image recreate [--help] [<existingImageName>]
```
### Parameters
    <existingImageName>
                Local image name to recreate.

### Options
    --help      Prints this documentation


# Process commands

## Process
Root command of all process commands, prints help only.  
Run: `pharo-launcher process` to see help.

## Process kill
Kills the running Pharo process(es) of given local image.

### Usage
```bash
pharo-launcher process kill [--help] [--all] [<existingImageName>]
```

### Parameters
    <existingImageName>
                Specifies the local image name to kill its process.

### Options
    --help      Prints this documentation
    --all       Determines whether to kill all running Pharo image processes.

### Examples
No examples yet.

## Process list
Lists all running Pharo image processes.

### Usage
```bash
pharo-launcher process list [--help]
```
### Options
    --help      Prints this documentation

### Examples
No examples yet.


# Template commands

## Template
Root command of all template commands, prints help only.  
Run: `pharo-launcher template` to see help.

## Template categories
Prints list of image template categories.

### Usage
```bash
pharo-launcher template categories [--help] [--brief] [--rowMode] [--delimiter <delimiter-value>] [--ston]
```

### Options
    --help      Prints this documentation
    --brief     Prints only name attribute (with leading sequence number).
    --rowMode   Prints one attribute per line only.
    --delimiter <delimiter-value>
                Specifies the table-cell delimiter that delimits listed information attributes.
    --ston      Prints information in STON format.
### Examples
No examples yet.

## Template info
Prints information about image template name, origin url.

### Usage
```bash
pharo-launcher template info [--help] [--templateCategory <templateCategory-value>] [<templateName>]
```

### Parameters
    <templateName>
                Specifies the template name to print information.

### Options
    --help      Prints this documentation
    --templateCategory <templateCategory-value>
                Specifies the template category name to list image templates.
### Examples
No examples yet.

## Template list
Prints list of image templates.

### Usage
```bash
pharo-launcher template list [--help] [--templateCategory <templateCategory-value>] [--brief] [--rowMode] [--delimiter <delimiter-value>] [--ston]
```

### Options
    --help      Prints this documentation
    --templateCategory <templateCategory-value>
                Specifies the template category name to list image templates from given category.
    --brief     Prints only name attribute (with leading sequence number).
    --rowMode   Prints one attribute per line only.
    --delimiter <delimiter-value>
                Specifies the table-cell delimiter that delimits listed information attributes.
    --ston      Prints information in STON format.

### Examples
No examples yet. 


# Virtual machine commands

## VM 
Root command of all VM commands, prints help only.  
Run: `pharo-launcher vm` to see help.

## VM delete
Deletes VM executable from local computer, including dependencies.

### Usage
```bash
pharo-launcher vm delete [--help] [<existingVirtualMachineId>]
```

### Parameters
    <existingVirtualMachineId>
                Specifies the local Virtual Machine ID.

### Options
    --help      Prints this documentation

### Examples
No examples yet.

## VM info 
Prints information about VM: name, remote-site URL, last update status, etc.

### Usage
```bash
pharo-launcher vm info [--help] [<existingVirtualMachineId>]
```

### Parameters
    <existingVirtualMachineId>
                Specifies the local Virtual Machine ID.

### Options
    --help      Prints this documentation

### Examples

## VM list 
Lists all available VMs, with status.

### Usage
```bash
pharo-launcher vm list [--help] [--brief] [--rowMode] [--delimiter <delimiter-value>] [--ston] [<existingVirtualMachineId>]
```

### Parameters
    <existingVirtualMachineId>
                Specifies the local Virtual Machine ID.

### Options
    --help      Prints this documentation
    --brief     Prints only name attribute (with leading sequence number).
    --rowMode   Prints one attribute per line only.
    --delimiter <delimiter-value>
                Specifies the table-cell delimiter that delimits listed information attributes.
    --ston      Prints information in STON format.
### Examples
No examples yet.

## VM update
Updates VM executable, including dependent libs to latest version from remote site.

### Usage
```bash
pharo-launcher vm update [--help] [<existingVirtualMachineId>]
```

### Parameters
    <existingVirtualMachineId>
                Specifies the local Virtual Machine ID.

### Options
    --help      Prints this documentation

### Examples
No examples yet.