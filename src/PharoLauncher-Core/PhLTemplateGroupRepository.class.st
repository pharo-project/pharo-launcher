"
I maintain a collection of PhLTemplateGroup. I take care of adding a cache to each group.
"
Class {
	#name : #PhLTemplateGroupRepository,
	#superclass : #PhLRepository,
	#instVars : [
		'groupCaches'
	],
	#classVars : [
		'Groups'
	],
	#category : 'PharoLauncher-Core-Model'
}

{ #category : #private }
PhLTemplateGroupRepository class >> activate: aBoolean GroupNamed: aString [
	^ self groups at: (self allGroups detect: [ :group | group name = aString ]) put: aBoolean
]

{ #category : #private }
PhLTemplateGroupRepository class >> allGroups [
	^ self groups keys
]

{ #category : #'instance creation' }
PhLTemplateGroupRepository class >> forAllGroups [
	^ self newFromGroups: self allGroups
]

{ #category : #'instance creation' }
PhLTemplateGroupRepository class >> forSelectedGroups [
	^ self newFromGroups: (self allGroups select: [ :group | self wantGroupNamed: group name ])
]

{ #category : #private }
PhLTemplateGroupRepository class >> groups [
	"self resetGroups"
	"self groups"
	^ Groups
		ifNil: [ 
			Groups := OrderedDictionary new.
			Groups at: PhLJenkins2Server inriaRmod put: false.
			Groups at: PhLJenkins2Server inriaPharoContribution put: true.
			Groups at: PhLJenkins2Server inriaPharo put: true.
			Groups at: PhLJenkins2Server inriaMoose put: true.
			Groups at: PhLHTTPListingTemplateGroup pharo60 put: true.
			Groups at: PhLHTTPListingTemplateGroup pharo70 put: true.
			Groups at: PhLFixedURLsTemplateGroup forDeprecatedDistributions put: true.
			Groups at: PhLFixedURLsTemplateGroup forOfficialDistributions put: true.
			Groups at: PhLFixedURLsTemplateGroup forPharoMooc put: true.
			Groups at: PhLDownloadedTemplateGroup default put: true.
			^ Groups ]
]

{ #category : #private }
PhLTemplateGroupRepository class >> newFromGroups: aCollection [
	^ self new
		setGroups: aCollection;
		yourself
]

{ #category : #private }
PhLTemplateGroupRepository class >> resetGroups [
	"self resetGroups"

	<script>
	Groups := nil
]

{ #category : #settings }
PhLTemplateGroupRepository class >> wantCommontools [
	^ self wantGroupNamed: PhLFixedURLsTemplateGroup forOfficialDistributions name
]

{ #category : #settings }
PhLTemplateGroupRepository class >> wantCommontools: aBoolean [
	self activate: aBoolean GroupNamed: PhLFixedURLsTemplateGroup forOfficialDistributions name
]

{ #category : #private }
PhLTemplateGroupRepository class >> wantGroupNamed: aString [
	^ self groups at: (self allGroups detect: [:group | group name = aString ])
]

{ #category : #private }
PhLTemplateGroupRepository class >> wantLocal [
	^ self wantGroupNamed: PhLDownloadedTemplateGroup default name
]

{ #category : #private }
PhLTemplateGroupRepository class >> wantLocal: aBoolean [
	self activate: aBoolean GroupNamed: PhLDownloadedTemplateGroup default name
]

{ #category : #settings }
PhLTemplateGroupRepository class >> wantMooseJenkins [
	"method only kept to avoid errors at startup of Pharo Launcher for users having these old settings stored in their preferences."
]

{ #category : #settings }
PhLTemplateGroupRepository class >> wantMooseJenkins: aBoolean [
		"method only kept to avoid errors at startup of Pharo Launcher for users having these old settings stored in their preferences."
]

{ #category : #settings }
PhLTemplateGroupRepository class >> wantPharo20oldstable [
	^ self wantGroupNamed: PhLHTTPListingTemplateGroup pharo20 name
]

{ #category : #settings }
PhLTemplateGroupRepository class >> wantPharo20oldstable: aBoolean [
	self activate: aBoolean GroupNamed: PhLHTTPListingTemplateGroup pharo20 name
]

{ #category : #settings }
PhLTemplateGroupRepository class >> wantPharo30oldstable [
	^ true
]

{ #category : #settings }
PhLTemplateGroupRepository class >> wantPharo30stable [
	^ self wantGroupNamed: PhLHTTPListingTemplateGroup pharo30 name
]

{ #category : #settings }
PhLTemplateGroupRepository class >> wantPharo30stable: aBoolean [
	self activate: aBoolean GroupNamed: PhLHTTPListingTemplateGroup pharo30 name
]

{ #category : #settings }
PhLTemplateGroupRepository class >> wantPharo40beta [
	^ true
]

{ #category : #settings }
PhLTemplateGroupRepository class >> wantPharo40beta: aBoolean [
]

{ #category : #settings }
PhLTemplateGroupRepository class >> wantPharo40stable [
	^ true
]

{ #category : #settings }
PhLTemplateGroupRepository class >> wantPharo40stable: aBoolean [
	self activate: aBoolean GroupNamed: PhLHTTPListingTemplateGroup pharo40 name
]

{ #category : #settings }
PhLTemplateGroupRepository class >> wantPharo50stable: aBoolean [
	self activate: aBoolean GroupNamed: PhLHTTPListingTemplateGroup pharo50 name
]

{ #category : #settings }
PhLTemplateGroupRepository class >> wantPharo60beta [
	^ true
]

{ #category : #settings }
PhLTemplateGroupRepository class >> wantPharo70alpha [
	^ true
]

{ #category : #settings }
PhLTemplateGroupRepository class >> wantPharoContributionJenkins [
	"method only kept to avoid errors at startup of Pharo Launcher for users having these old settings stored in their preferences."
]

{ #category : #settings }
PhLTemplateGroupRepository class >> wantPharoContributionJenkins: aBoolean [
	"method only kept to avoid errors at startup of Pharo Launcher for users having these old settings stored in their preferences."
]

{ #category : #settings }
PhLTemplateGroupRepository class >> wantPharoJenkins [
	"method only kept to avoid errors at startup of Pharo Launcher for users having these old settings stored in their preferences."
]

{ #category : #settings }
PhLTemplateGroupRepository class >> wantPharoJenkins: aBoolean [
		"method only kept to avoid errors at startup of Pharo Launcher for users having these old settings stored in their preferences."
]

{ #category : #settings }
PhLTemplateGroupRepository class >> wantRMoDJenkins [
	"method only kept to avoid errors at startup of Pharo Launcher for users having these old settings stored in their preferences."
]

{ #category : #settings }
PhLTemplateGroupRepository class >> wantRMoDJenkins: aBoolean [
	"method only kept to avoid errors at startup of Pharo Launcher for users having these old settings stored in their preferences."
]

{ #category : #private }
PhLTemplateGroupRepository >> addGroup: aGroup [
	| cache |
	cache := PhLCacheTemplateGroup group: aGroup. "wrap all groups inside a cache."
	aGroup isFast "always put the fast groups before the rest for rapid access"
		ifTrue: [ groupCaches addFirst: cache ]
		ifFalse: [ groupCaches addLast: cache ]
]

{ #category : #action }
PhLTemplateGroupRepository >> createLocalTemplateFrom: anImage named: aString [
	(self hasLocalTemplateNamed: aString)
		ifTrue: [ PhLError signal: 'A local template with the same name already exists' ].
	self createZipArchiveFrom: anImage named: aString.
	self createLocalTemplateNamed: aString.
	self refresh
]

{ #category : #action }
PhLTemplateGroupRepository >> createLocalTemplateNamed: aString [
	| localTemplate |
	localTemplate := PhLLocalTemplate name: aString zipFile: PhLDownloadedTemplateGroup default baseDirectory / aString , 'zip'.
	PhLDownloadedTemplateGroup default register: localTemplate withZip: localTemplate zipArchive
]

{ #category : #action }
PhLTemplateGroupRepository >> createZipArchiveFrom: anImage named: aString [
	ZipArchive new
		addFile: anImage imageFile as: aString , '.image';
		addFile: anImage changesFile as: aString , '.changes';
		writeToFileNamed: PhLDownloadedTemplateGroup default baseDirectory / aString , 'zip'
]

{ #category : #action }
PhLTemplateGroupRepository >> deleteTemplate: aTemplate [ 
	aTemplate zipArchive delete.
	self refresh.
]

{ #category : #action }
PhLTemplateGroupRepository >> deleteTemplates: someTemplates [ 
	self dontNotifyDuring: [ someTemplates do: [ :template | self deleteTemplate: template ] ].
	self refresh
]

{ #category : #testing }
PhLTemplateGroupRepository >> hasLocalTemplateNamed: aString [
	^ PhLDownloadedTemplateGroup default templatesAndGroups 
		anySatisfy: [ :each | each name = aString ]
]

{ #category : #accessing }
PhLTemplateGroupRepository >> localTemplateNamed: aString [
	^ PhLDownloadedTemplateGroup default templatesAndGroups 
		detect: [ :each | each name = aString ]
]

{ #category : #action }
PhLTemplateGroupRepository >> makeUniqueTemplateName: aString [
	|  localTemplateNames |
	localTemplateNames := PhLDownloadedTemplateGroup default templatesAndGroups collect: [ :each | each name ].
	^ self makeUniqueTemplateName: aString among: localTemplateNames
]

{ #category : #action }
PhLTemplateGroupRepository >> makeUniqueTemplateName: baseTemplateName among: existingTemplateNames [
	"Provide a reasonable default template name using the next incremental count for images with similar basenames"

	"See #testMakeUniqueImageName for samples"

	^ self makeUniqueName: baseTemplateName among: existingTemplateNames
]

{ #category : #action }
PhLTemplateGroupRepository >> refresh [
	groupCaches do: #refresh.
	self contentsChanged.
]

{ #category : #accessing }
PhLTemplateGroupRepository >> roots [
	^ groupCaches
]

{ #category : #'initialize-release' }
PhLTemplateGroupRepository >> setGroups: aCollection [
	| names |
	names := Set new.
	groupCaches := OrderedCollection new.
	aCollection
		do: [ :group | 
			(names includes: group name)
				ifTrue: [ PhLError signal: '2 groups must not have the same name' ]
				ifFalse: [ self addGroup: group ] ]
]
