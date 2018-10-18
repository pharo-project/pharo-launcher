"
I stores metadata on true and false positive critics. These meta data are used by the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestPharoLauncherUI,
	#superclass : #Object,
	#category : 'PharoLauncher-Spec'
}

{ #category : #'meta data' }
ManifestPharoLauncherUI class >> rejectClasses [
^ #()
]

{ #category : #'meta data' }
ManifestPharoLauncherUI class >> rejectRules [
^ #()
]

{ #category : #'meta data' }
ManifestPharoLauncherUI class >> ruleMissingYourselfRuleV1FalsePositive [
^ #(#(#(#RGMethodDefinition #(#'PharoLauncher class' #openAll #true)) #'2013-06-27T15:21:58.5427+02:00') )
]

{ #category : #'meta data' }
ManifestPharoLauncherUI class >> ruleOnlyReadOrWrittenVariableRuleV1FalsePositive [
	^ #(#(#(#RGClassDefinition #(#PhLStatusbar)) #'2013-06-27T15:21:58.7647+02:00') #(#(#RGClassDefinition #(#PhLTitledTreePresenter)) #'2013-06-27T15:21:58.7647+02:00') #(#(#RGClassDefinition #(#PharoLauncher)) #'2013-06-27T15:21:58.7647+02:00'))
]
