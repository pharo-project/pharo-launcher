"
Gives informations about an image 
"
Class {
	#name : #ClapImageInfo,
	#superclass : #Object,
	#instVars : [
		'stream'
	],
	#category : #'PharoLauncher-CLI-Old-PharoLauncher-CLI-Old'
}

{ #category : #'as yet unclassified' }
ClapImageInfo class >> imageInfo [
"
	| anImage |
	^(ClapCommand withName: 'images2')
	 description: 'for images';
	 add: ((ClapCommand withName: 'info')
		description: 'Prints information about image: name, description, origin template, etc.';
		add: ClapFlag forHelp;
		meaning: [ :args |
			args atName: 'help' ifFound: [ :help |
				help value; exitSuccess ].
			anImage := args parent parent arguments at:2.
         self outputImageInfo: anImage.  
		 ])"
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
   | imageOriginTemplate imageName imageDescription imagePharoVersion lastModified imageOriginTemplateURL imageDirectory anImage |
   anImage := ClapImageInfo new.
   [anImage := anImage findImage: anImageName]on:Error,NotFound do:[:c|stream nextPutAll:'please enter a correct local image'.stream cr.^0].
   imageOriginTemplate := anImage originTemplateName.
   imageName := anImage name.
   lastModified := anImage lastModification.
   imageOriginTemplateURL := anImage originTemplateUrl.
   imageDirectory := anImage location.
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
          cr;
          nextPutAll: ' image template URL: ';
          nextPutAll: imageOriginTemplateURL asString;
          cr;
          nextPutAll: ' image path: ';
          nextPutAll: imageDirectory asString;
          cr;
          nextPutAll: ' image last modification ';
          nextPutAll: lastModified asString;
          cr.




]

{ #category : #'as yet unclassified' }
ClapImageInfo >> stream: aWriteStream [ 
	stream := aWriteStream
]
