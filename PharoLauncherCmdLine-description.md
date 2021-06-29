# Introduction  
Purpose of this document is to describe command line interface for Pharo launcher with description of necessary commands.  

# Plans
1. At first, estabilish structure/design of cmd-line interface and what operations, arguments should be supported (this document).
2. Implement stub of cmd-line interface using CLAP. It won't contain necessary connection to Pharo launcher commands yet.
3. If cmd-line design is good to go, we can start on moving Pharo launcher backend code to dedicated package, which could be used by CLAP commands in previous step.
4. Build of headless Pharo launcher (resulting in change of Pharo launcher baseline and change of corresponding Github actions) can be then initiated. Resulting app (executable) will no longer open UI of Pharo launcher. 

# Open questions
1. What if there is some interaction needed? E.g. network is unavailable, should we offer dialog-like options (e.g.: "Reconnect Y/N?"), or rather to avoid that?
2. What is priority of every command? I guess some of them are more important than others (order of how it should be implemented).
3. How to escape path parameters? What type of quotes should be used? (single like 'path to dir' or rathter "this is path"
4. How to print-out errors? Some kind of formatting? (E.g. "ERROR: Could not create image to directory: usr/local/Pharo/images")
5. How to display progress (if ever)? This could be useful during downlaod commands, like "INFO: Fetching from remote-site URL..." (dot's added every second, or maybe percentage?).

# Overview of Pharo Laucher commands  
This is list of subject oriented commands of Pharo launcher, where subjects are Pharo VM, image, configuration of launcher.  
(launcher parent command is not listed, it is implicit)

| Command | Sub-command | Sub-Sub-command | Description | 
| ------- | ----------- | --------------- | ------------- |
| `help`  |             | | Prints all supported Pharo launcher commands. |
| `vm`    |             | | All sub-commands related to VM management. |
|         | `list`      | | Lists all available VMs. |
|         | `info`      | | Prints information about VM: name, remote-site URL, last update status, etc. |
|         | `update`    | | Updates VM executable, including depedent libs to latest version from remote site. |
|         | `delete`    | | Deletes VM executable from local computer, including dependencies. |
| `image` |             | | All sub-commands related to management of local Pharo images. |
|         | `list`      | | Lists all downloaded images on local computer. |
|         | `info`      | | Prints information about image: name, description, origin template, etc. |
|         | `launch`    | | Launches image with using default (auto-detected) VM. |
|         | `create`    | | Downloads and creates new image on local computer from remote site based on template name. |
|         | `copy`      | | Creates copy of given image with new name. 
|         | `delete`    | | Deletes image from computer, including local image directory content. |
| `template` |          | | All sub-commands related to templates of Pharo image. | 
|         | `list`      | | Lists all image templates. |
|         | `categories`| | Lists all image template categories, based on which are image templates categorized. |
|         | `info`      | | Prints, informations (url) about templates  |


# Description of Pharo Launcher commands  
## Help command  
```
This is help for command line interface of Pharo Launcher.
Common purpose of laucher is to create Pharo image locally from remote site template, lauch Pharo, eventually delete image, update VMs, etc.

Usage:  [command] [--help]

Commands:
TOTO

Options:
-h, --help                Prints help about this command. 
```
### Help command help
```
Prints help about given command.

Usage: help [<command>] [--help]

Parameters: 
<command>                 Name of given command, for which is help printed.

Options:
-h, --help                Prints help about this command. 
```

## List of VMs command
Example of use:
```
$ vm list
VM name                 Last Update               Remote URL
-------                 -----------               ----------                 
90-x86                  N/A                       https://files.pharo.org/get-files/90/pharo-win-stable.zip
90-x64-headless         N/A                       https://files.pharo.org/get-files/90/pharo64-win-headless-latest.zip
80-x64                  2020-11-03 10:32:47       https://files.pharo.org/get-files/80/pharo64-win-stable.zip
70-x86                  2020-02-26 15:47:31       https://files.pharo.org/get-files/70/pharo-win-stable.zip
```

### Help for list of VMs command
```
Lists all available VMs, with last update status, remote site URL, from which was VM copied (if ever).
(N/A status (last update) means that VM is not on local computer available.)

Usage:  vm list [--help] 

Options:
-h, --help                Prints help about this command.
```
## List images command
Example of use:  
```
$ image list
Image name                                  Architecture          Pharo Version           Last Modified               Last modified (ago)
----------                                  ------------          -------------           -------------               -------------------       
P9-64b-devel                                64                    90                      2021-03-01T12:22:11+1:00    last week
PharoWeb                                    32                    50                      2019-10-10T08:34:59+1:00    more than year ago
Pharo 7.0 - 32bit (Exercism new 23)         32                    70                      2019-03-21T11:11:23+1:00    more than year ago
```
### Help for list images command
```
Lists all available Pharo images on local computer, with image name, architecture, Pharo version, last modified date.
Images are ordered by recent modification date.

Usage:  image list [--help] 

Options:
-h, --help                Prints help about this command.
```
## Image info command
Example of use:  
```
$ PharoLauncher-cli image info "Pharo 7.0 - 32bit (Exercism new 23)"
Image name:           Pharo 7.0 - 32bit (Exercism new 23
Last modified:        2019-10-10T08:34:59+1:00
Description:          (not available)
Origin template:      Pharo 7.0 - 32bit (stable)
Origin template URL:  https://files.pharo.org/image/70/latest.zip
Image directory:      "/usr/local/user/images/Pharo 7.0 - 32bit (Exercism new 23"

```

