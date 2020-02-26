"
I'm in charge of building the list of templates groups and its associated templates from a list of template sources.

I use as input an instance of PhLTemplateSources.
The default input is the serialized ston file 'sources.list' defining templates sources (stored in Launcher directory) + the user ston file 'mysources.list' if exists.
I'm used at Launcher creation, see PharoLauncherApplication >>#resetTemplateRepository.

To update the list of official sources, please update the sources files hosted at http://files.pharo.org/pharo-launcher/sources.list
"
Class {
	#name : #PhLTemplateGroupsBuilder,
	#superclass : #Object,
	#instVars : [
		'sources',
		'groups',
		'templates'
	],
	#category : #'PharoLauncher-Core-Model'
}

{ #category : #'instance creation' }
PhLTemplateGroupsBuilder class >> build [
	^ self buildFrom: PhLTemplateSources defaultSources
]

{ #category : #'instance creation' }
PhLTemplateGroupsBuilder class >> buildFrom: aPhLTemplateSourcesList [
	^ self new 
		initializeWithSources: aPhLTemplateSourcesList;
		build
]

{ #category : #building }
PhLTemplateGroupsBuilder >> build [
	^ groups := sources
		collect: [ :source | 
			source asTemplateGroup 
				in: [ :group |
					source templatesDo: [ :templateSource | group addTemplate: templateSource asTemplate ] ];
			yourself ]
]

{ #category : #initialization }
PhLTemplateGroupsBuilder >> initializeWithSources: aListOfTemplateSource [ 
	sources := aListOfTemplateSource.
	groups := OrderedCollection new.
]
