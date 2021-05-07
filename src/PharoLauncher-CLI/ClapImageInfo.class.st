"
Gives informations about an image 
"
Class {
	#name : #ClapImageInfo,
	#superclass : #Object,
	#instVars : [
		'stream'
	],
	#category : #'PharoLauncher-CLI'
}

{ #category : #'as yet unclassified' }
ClapImageInfo class >> imageInfo [
	<commandline>
	| anImage |
	^ (ClapCommand withName: 'imageInfo')
		description: 'Prints information about image: name, description, origin template, etc.';
		add: ClapFlag forHelp;
		meaning: [ :args |
			args atName: 'help' ifFound: [ :help |
				help value; exitSuccess ].
			anImage := args parent parent arguments at:2.
			"
			anImage := anImage arguments.
			anImage := anImage at:2."
         self outputImageInfo: anImage.  
		 ]
]

{ #category : #'as yet unclassified' }
ClapImageInfo class >> outputImageInfo: anImage [ 
  self new outputImageInfo: anImage. 
  
]

{ #category : #'as yet unclassified' }
ClapImageInfo >> findImage: anImageName [
   | repository theImage |
   repository := PhLDirectoryBasedImageRepository default.
   [theImage := repository images detect: [ :anImage | anImage name = anImageName ]] on:Error      do:[:c|theImage:='error'].
   ^theImage 
   
   

]

{ #category : #'as yet unclassified' }
ClapImageInfo >> initialize [
   stream := VTermOutputDriver stdout.
]

{ #category : #'as yet unclassified' }
ClapImageInfo >> outputImageInfo: anImageName [
   | imageOriginTemplate imageName imageDescription imagePharoVersion anImage |
   anImage := ClapImageInfo new.
   anImage := anImage findImage: anImageName.
   anImage = 'error' ifTrue:[stream nextPutAll:'please enter a correct local image'.stream cr.^0 ]. 
   imageOriginTemplate := anImage originTemplateName.
   imageName := anImage name.
   imageDescription := anImage description. 
   imagePharoVersion := anImage pharoVersionFromFile.
   stream nextPutAll: 'image name: ';
          nextPutAll: imageName asString;
          cr;
          nextPutAll: ' image description: ';
          nextPutAll: imageDescription asString;
          cr;
          nextPutAll: ' image version: ';
          nextPutAll: imagePharoVersion asString;
          cr;
          nextPutAll: ' image origin template: ';
          nextPutAll: imageOriginTemplate asString;
          cr.


]

{ #category : #'as yet unclassified' }
ClapImageInfo >> stream: aWriteStream [ 
	stream := aWriteStream
]
