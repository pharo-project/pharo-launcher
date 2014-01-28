metadata
catalogKeyClassesAndExample
	^ 'The key packages are ==PharoLauncher-Core== (the model) and ==PharoLauncher-Spec== (the GUI).
For ==PharoLauncher-Core==, the key classes are:
- ==PhLAbstractTemplate== and its subclasses ==PhLLocalTemplate== and ==PhLRemoteTemplate==. These classes model an image archive (typically a zip file) somewhere on the disk or the network.
- ==PhLAbstractTemplateGroup== and all its subclasses. These classes model places where templates can be found: a folder somewhere on the hard disk, files.pharo.org, a Jenkins server etc. The ==PhLCacheTemplateGroup== class is a bit special as it just provides caching for other subclasses of ==PhLAbstractTemplateGroup==.
- ==PhLImage== represents an image (a pair of a ==.image== and a ==.changes== files) on the disk.
- ==PhLDirectoryBasedImageRepository== is the class managing the user''s images (instances of ==PhLImage==).
- ==PhLTemplateGroupRepository== is the class managing the template groups (instances of ==PhLCacheTemplateGroup==).
- ==PhLCommand== and all its subclasses model all the things a user can do: creating an image from a template, renaming an image, refreshing the template groups...

For ==PharoLauncher-Spec==, the key classes are:

- ==PharoLauncher== is the main class managing the Launcher''s GUI. This class uses the *Spec framework>http://spec.st*.
- ==PhLCommandToolbar== and ==PhLCommandButton== are used to display buttons in the GUI. Each button is linked to a particular subclass of ==PhLCommand==.
- ==PhLDeploymentScript== takes care of preparing the image so that the launcher can be used as a full desktop application.'