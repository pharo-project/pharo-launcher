"
See PhLVirtualMachine's comment for general details. GToolkit VM/image bundles can be downloaded at https://gtoolkit.com/download/

#Setup
Two things unique to GToolkit setup:
1. Gtoolkit currently puts some libraries in non-standard locations e.g. on Mac, several dylibs are outside the .app bundle in its parent folder. Make sure to include all these libraries and any other needed resources - like the sources file - when placing the VM in the Launcher VM folder.
2. For the time being, each image must be launched with the VM distributed with that image version, even for minor and patch releases*. No assumptions can be made about compatibility other than that because the VM may change with every image version.

* Per the GToolkit team on 8/28/2020 on the GT Discord Server, general channel
"
Class {
	#name : #PhLGToolkitVirtualMachine,
	#superclass : #PhLVirtualMachine,
	#category : #'PharoLauncher-GToolkit'
}

{ #category : #querying }
PhLGToolkitVirtualMachine class >> executableName [
	^ 'GlamorousToolkit'
]

{ #category : #accessing }
PhLGToolkitVirtualMachine class >> versionPrefix [
	^ 'gt-'
]
