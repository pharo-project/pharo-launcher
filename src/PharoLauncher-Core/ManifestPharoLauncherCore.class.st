"
I stores metadata on true and false positive critics. These meta data are used by the SmalllintManifestChecker and the critics Browser 
"
Class {
	#name : #ManifestPharoLauncherCore,
	#superclass : #Object,
	#category : #'PharoLauncher-Core-Model'
}

{ #category : #'meta data' }
ManifestPharoLauncherCore class >> rejectClasses [
^ #()
]

{ #category : #'meta data' }
ManifestPharoLauncherCore class >> rejectRules [
^ #()
]

{ #category : #'meta data' }
ManifestPharoLauncherCore class >> ruleAbstractClassRuleV1FalsePositive [
^ #(#(#(#RGClassDefinition #(#PhLError)) #'2013-06-27T15:21:58.6527+02:00') )
]

{ #category : #'meta data' }
ManifestPharoLauncherCore class >> ruleImplementedNotSentRuleV1FalsePositive [
^ #(#(#(#RGMethodDefinition #(#'PhLJenkinsServer class' #inriaPharo #true)) #'2013-06-27T17:14:56.694694+02:00') )
]

{ #category : #'meta data' }
ManifestPharoLauncherCore class >> ruleInconsistentMethodClassificationRuleV1FalsePositive [
^ #(#(#(#RGMethodDefinition #(#PhLImage #name #false)) #'2013-06-27T17:14:57.998691+02:00') #(#(#RGMethodDefinition #(#PhLAbstractTemplateGroup #name #false)) #'2013-06-27T17:14:57.998691+02:00') #(#(#RGMethodDefinition #(#PhLError #name #false)) #'2013-06-27T17:14:57.998691+02:00') #(#(#RGMethodDefinition #(#PhLAbstractTemplate #name #false)) #'2013-06-27T17:14:57.998691+02:00') #(#(#RGMethodDefinition #(#PhLJenkinsArtifact #name #false)) #'2013-06-27T17:14:57.998691+02:00') )
]

{ #category : #'meta data' }
ManifestPharoLauncherCore class >> ruleMissingYourselfRuleV1FalsePositive [
^ #(#(#(#RGMethodDefinition #(#'PhLError class' #signalUrl: #true)) #'2013-06-27T15:21:58.5907+02:00') #(#(#RGMethodDefinition #(#PhLDownloadManager #downloadToPositionableStream:mimeType: #false)) #'2013-06-27T15:21:58.5907+02:00') )
]
