"
Please describe the package using the class comment of the included manifest class. The manifest class also includes other additional metadata for the package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestPharoLauncherCLI,
	#superclass : #PackageManifest,
	#category : #'PharoLauncher-CLI-Manifest'
}

{ #category : #'code-critics' }
ManifestPharoLauncherCLI class >> ruleTempsReadBeforeWrittenRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#PhLImageCreateFromPullRequestCliCommand #findTemplate #false)) #'2022-07-01T12:08:23.076121+02:00') )
]
