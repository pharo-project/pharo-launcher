"
Represent a list of templates that is defined at construction time. The interesting property of this group is that is does not require the network to be shown. The network is only needed to actually download a template.
"
Class {
	#name : #PhLFixedURLsTemplateGroup,
	#superclass : #PhLAbstractTemplateGroup,
	#instVars : [
		'templates',
		'name'
	],
	#category : 'PharoLauncher-Core-Model'
}

{ #category : #'instance creation' }
PhLFixedURLsTemplateGroup class >> forDeprecatedDistributions [
	^ self new
		setName: 'Deprecated distributions'
			Templates:
			 
				{(self pharo40).
					(self pharo30).
					(self pharo20).
					(self moose51).
					(self moose50)};
		isHighlighted: false;
		yourself
]

{ #category : #'instance creation' }
PhLFixedURLsTemplateGroup class >> forOfficialDistributions [
	^ self new
		setName: 'Official distributions'
			Templates: {
				self pharo70_32.
				self pharo70_64.
				self pharo60_32.
				self pharo60_64.
				self pharo50.
				self moose61.
				self moose60
			};
		isHighlighted: true;
		yourself
]

{ #category : #'instance creation' }
PhLFixedURLsTemplateGroup class >> forPharoMooc [
	^ self new
		setName: 'Pharo Mooc'
			Templates: { self pharoMooc };
		yourself
]

{ #category : #private }
PhLFixedURLsTemplateGroup class >> moose50 [
	^ PhLRemoteTemplate name: 'Moose Suite 5.0' url: 'http://moosetechnology.org/res/download/moose_image_5_0.zip' asUrl
]

{ #category : #private }
PhLFixedURLsTemplateGroup class >> moose51 [
	^ PhLRemoteTemplate name: 'Moose Suite 5.1 (old stable)' url: 'https://ci.inria.fr/moose/job/moose-5.1/lastSuccessfulBuild/artifact/moose-5.1.zip' asUrl
]

{ #category : #private }
PhLFixedURLsTemplateGroup class >> moose60 [
	^ PhLRemoteTemplate name: 'Moose Suite 6.0 (stable)' url: 'https://ci.inria.fr/moose/job/moose-6.0/lastSuccessfulBuild/artifact/moose-6.0.zip' asUrl
]

{ #category : #private }
PhLFixedURLsTemplateGroup class >> moose61 [
	^ PhLRemoteTemplate name: 'Moose Suite 6.1 (beta)' url: 'https://ci.inria.fr/moose/job/moose-6.1/lastSuccessfulBuild/artifact/moose-6.1.zip' asUrl
]

{ #category : #private }
PhLFixedURLsTemplateGroup class >> pharo20 [
	^ PhLRemoteTemplate name: 'Pharo 2.0' url: 'http://files.pharo.org/image/20/latest.zip' asUrl
]

{ #category : #private }
PhLFixedURLsTemplateGroup class >> pharo30 [
	^ PhLRemoteTemplate name: 'Pharo 3.0' url: 'http://files.pharo.org/image/30/latest.zip' asUrl
]

{ #category : #private }
PhLFixedURLsTemplateGroup class >> pharo40 [
	^ PhLRemoteTemplate name: 'Pharo 4.0' url: 'http://files.pharo.org/image/40/latest.zip' asUrl
]

{ #category : #private }
PhLFixedURLsTemplateGroup class >> pharo50 [
	^ PhLRemoteTemplate name: 'Pharo 5.0' url: 'http://files.pharo.org/image/50/latest.zip' asUrl
]

{ #category : #private }
PhLFixedURLsTemplateGroup class >> pharo60_32 [
	^ PhLRemoteTemplate name: 'Pharo 6.1 - 32bit (stable)' url: 'http://files.pharo.org/image/60/latest.zip' asUrl
]

{ #category : #private }
PhLFixedURLsTemplateGroup class >> pharo60_64 [
	^ PhLRemoteTemplate name: 'Pharo 6.1 - 64bit (tech preview)' url: 'http://files.pharo.org/image/60/latest-64.zip' asUrl
]

{ #category : #private }
PhLFixedURLsTemplateGroup class >> pharo70_32 [
	^ PhLRemoteTemplate name: 'Pharo 7.0 - 32bit (development version)' url: 'http://files.pharo.org/image/70/latest.zip' asUrl
]

{ #category : #private }
PhLFixedURLsTemplateGroup class >> pharo70_64 [
	^ PhLRemoteTemplate name: 'Pharo 7.0 - 64bit (development version)' url: 'http://files.pharo.org/image/70/latest-64.zip' asUrl
]

{ #category : #private }
PhLFixedURLsTemplateGroup class >> pharoMooc [
	^ PhLRemoteTemplate name: 'Pharo Mooc' url: 'http://mooc.pharo.org/image/PharoWeb.zip' asUrl
]

{ #category : #testing }
PhLFixedURLsTemplateGroup >> isFast [
	^ true
]

{ #category : #accessing }
PhLFixedURLsTemplateGroup >> name [
	^ name
]

{ #category : #initialization }
PhLFixedURLsTemplateGroup >> setName: aString Templates: aCollection [
	name := aString.
	templates := aCollection
]

{ #category : #accessing }
PhLFixedURLsTemplateGroup >> templatesAndGroups [
	^ templates
]
