Templates are the only way to create images. They are materialized by a zip file contining the Pharo image and all its associated file.

For example, the Pharo 8 official template is composed of:

* the sources file: Pharo8.0-32bit-278304f.sources
* the image: Pharo8.0-SNAPSHOT-64bit-278304f.image
* the changes file: Pharo8.0-SNAPSHOT-64bit-278304f.changes
* the pharo version number file (used by Pharo Launcher if present): pharo.version

## Template categories
![List of official template categories](images/template-categories.png){: style="width:200px"}

* Official distributions : list of templates officialy supported by Pharo. You will find here latest Pharo images (development, stabl, old stable) and Moose images.
* Pharo Mooc: convenient category for newcomers to discover Pharo. It contains the MOOC image needed for the practical part of the MOOC.
* Deprecated distributions: old Pharo and Moose images version (since Pharo 2.0)
* Pharo Contribution Jenkins: This category represents jobs available on the Jenkins server https://ci.inria.fr/pharo-contribution. If the job provides a zip file as artefact, it will be used as a template to create an image.
* Moose Jenkins: This category represents jobs available on the Jenkins server https://ci.inria.fr/moose. If the job provides a zip file as artefact, it will be used as a template to create an image.
* Pharo xx (stable): all versions of the current stable Pharo version
* Pharo xx (development version): all versions of the current development Pharo version
* Templates: This category contains templates that are available locally (i.e. without network connection). By default, it only contains the current Pharo stable image that is shipped with Pharo Launcher. Once you start downloading some templates, they are cached in this category for further reuse. Warning: if the template is updated on the server, the cached version will NOT be invalidated, so local and server version of the template will differ.

There are different kind of categories:

* Fixed URL: Represent a list of templates that is defined at construction time. The interesting property of this group is that is does not require the network to be shown. The network is only needed to actually download a template.
* HTTP listing: Represent a list of templates as given by an HTML webpage. `<a href="*.zip">` are searched in the webpage. You can also provide a regular expression to filter files.
* Jenkins server: group of templates provided by a Jenkins server. I use Jenkins' JSON API to get the data from the server.
* Cache: special group taking care of caching locally downloaded templates from other template categories.

## Create your own template
You can create your own templates from Pharo Launcher. From any image in the image list, right-click and select `Create template` or `Create template and delete image`. It will create a zip file from the selected image and put it in the Templates category under the provided name.

## Create your own list of template categories
Pharo already provides a wide range of templates but you can provide your own categories. It is useful to add templates that are private (e.g. private jenkins instance) or only of interest for you. It is doable thanks to the `mysources.list` file located in the Pharo folder. If present, this file defines additional template sources to the official list of templates. At this time, there is no UI to add them but you can take inspiration from the following examples.
Warning: take care to separate each template category by a comma. All categories should be enclosed inside `[]`.

Here is an example of a `mysources.list` file:
```json
[
	PhLTemplateSource {
		#type : #HttpListing,
		#name : 'User-defined http listing',
		#url : 'http://myserver.org/myimages/'
	},
	PhLTemplateSource {
        #type : #JenkinsServer,
        #name : 'My Jenkins server',
        #url : 'https://jenkins.mycompany.org',
        #username : 'john',
        #password: 'doefkwoiekfdoekdw2302ek349039e'
    }
]
```
### Add a Jenkins server
You can declare your own Jenkins server by providing its URL and using the #JenkinsServer type.
```json
    PhLTemplateSource {
        #type : #JenkinsServer,
        #name : 'Another Jenkins server',
        #url : 'https://ci.inria.fr/moose/'
    }
```
The name will be displayed as the template category. Url will be used to determine Jenkins API to query to get jobs, builds, runs, etc.

You can alse declare a **private Jenkins server** by providing a secure (i.e. using **https** protocol) URL to access it, a username and its associated token. 
We advise you to generate an API token and not to use directly your password. See https://jenkins.io/blog/2018/07/02/new-api-token-system/ for more information.
The token has to be specified in the `password` entry.
```json
    PhLTemplateSource {
        #type : #JenkinsServer,
        #name : 'My Jenkins server',
        #url : 'https://jenkins.mycompany.org',
        #username : 'john',
        #password : 'doefkwoiekfdoekdw2302ek349039e'
    }
```
### Add a group from an URL (HTPP listing)
An easy way to add a template category is the HTTP listing. You just provide the category name and a URL. Then the category will see all Zip files under this URL as a template available for Pharo Launcher. 
Here is an example:
```json
	PhLTemplateSource {
		#type : #HttpListing,
		#name : 'Http listing example',
		#url : 'http://files.pharo.org/pharo-launcher/1.9.2/'
	}
```
If needed, you can specify a filter pattern to exclude some files to be considered as templates.
Here is an example:
```json
	PhLTemplateSource {
		#type : #HttpListing,
		#name : 'Pharo 7.0 (development version)',
		#url : 'https://files.pharo.org/image/70/',
		#filterPattern : 'href="(Pharo-?7.0.0-(alpha|rc\\d+).build.[^"]*.zip)"'
	}
```
filterPattern is given as parameter to `RxParser>>#parse:`. The filter pattern must have parenthesis because this is what we want to extract for each match. For more information on the regex, see [Pharo by example book, regex chapter](https://ci.inria.fr/pharo-contribution/job/UpdatedPharoByExample/lastSuccessfulBuild/artifact/book-result/Regex/Regex.html).

You can also specify a server protected by a login / password as following:
```json
    PhLTemplateSource {
        #type : #HttpListing,
        #name : 'My main images',
        #url : 'https://intranet.mycompany.org/files',
        #username : 'john',
        #password : 'Doe!'
    }
```
### Add a group with individual URL templates
It is also possible to create a group that will contain individual URL templates. The group name will be the template category name.

Each Template you declare in this group should be of type #URL. A template basically has a name and a URL to the template. You can also specify URLs protected by a password with the **#username** and **#password** keywords.
```json
    PhLTemplateSource {
        #type : #URLGroup,
        #name : 'My main images',
        #templates : [
            PhLTemplateSource {
                #type : #URL,
                #name : 'MyProject2',
                #url : 'https://www.mycompany.org/downloads/project2.zip'
            },
            PhLTemplateSource {
                #type : #URL,
                #name : 'MyProject1 from private',
                #url : 'https://intranet.mycompany.org/files/project1.zip',
                #username : 'john',
                #password : 'Doe!'
            }
        ]
    }
```
