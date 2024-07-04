Class {
	#name : 'BaselineOfPharoLauncher',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfPharoLauncher',
	#package : 'BaselineOfPharoLauncher'
}

{ #category : 'baselines' }
BaselineOfPharoLauncher >> baseline: spec [
	<baseline>

	spec for: #'common' do: [

		self ston: spec.
		self osSubprocess: spec.
		self osWinSubprocess: spec.
		self xmlParser: spec.
		self clap: spec.
		self objCBridge: spec.
		self interactions: spec.

		spec
			package: 'PharoLauncher-100Compatibility'; 
			package: 'PharoLauncher-Core' with: [
				spec requires: #(
					'XMLParser' 
					'OSSubprocess' 
					'OSWinSubprocess' 
					'Ston'
					'Interactions'
					'ObjCBridge' 
					'PharoLauncher-100Compatibility'). ];
			package: 'PharoLauncher-Spec2' with: [ 
				spec requires: #('PharoLauncher-Core') ];
			package: 'PharoLauncher-Spec2-Gtk' with: [ 
				spec requires: #('PharoLauncher-Spec2') ];
			package: 'PharoLauncher-GToolkit' with: [ 
				spec requires: #('PharoLauncher-Core') ];
			package: 'PharoLauncher-Squeak' with: [ 
				spec requires: #('PharoLauncher-Core') ];
			package: 'PharoLauncher-Tests-Core' with: [
				spec requires: #('PharoLauncher-Core' ) ];
			package: 'PharoLauncher-Tests-Commands' with: [
				spec requires: #('PharoLauncher-Spec2' ). ];
			package: 'PharoLauncher-Tests-SpecUI' with: [
				spec requires: #('PharoLauncher-Core' 'PharoLauncher-Spec2'). ];
			package: 'PharoLauncher-Tests-Download' with: [
				spec requires: #('PharoLauncher-Tests-Core' ). ];
			package: 'PharoLauncher-Tests-Functional' with: [
				spec requires: #('PharoLauncher-Core' 'PharoLauncher-Tests-Download'). ];
			package: 'PharoLauncher-CLI' with: [ 
				spec requires: #('Clap') ];
			package: 'PharoLauncher-CLI-Tests' with: [ 
				spec requires: #('PharoLauncher-CLI') ].
		spec 
			group: 'Default' with: #(
				'PharoLauncher-Tests-Core' 
				'PharoLauncher-Tests-Download' 
				'PharoLauncher-Core' 
				'PharoLauncher-Spec2'
				'PharoLauncher-Spec2-Gtk' 
				'PharoLauncher-Tests-SpecUI' 
				'PharoLauncher-Tests-Functional'
				'PharoLauncher-CLI-Tests' 
				'PharoLauncher-GToolkit' 
				'PharoLauncher-Squeak') ]
]

{ #category : 'external projects' }
BaselineOfPharoLauncher >> clap: spec [

	spec 
		baseline: #Clap
		with: [ spec repository: 'github://pharo-contributions/clap-st:master/src' ]
]

{ #category : 'external projects' }
BaselineOfPharoLauncher >> interactions: spec [

	spec 
		baseline: #Interactions
		with: [ spec repository: 'github://pharo-contributions/interactions' ]
]

{ #category : 'external projects' }
BaselineOfPharoLauncher >> objCBridge: spec [

	spec 
		baseline: #ObjCBridge
		with: [ spec repository: 'github://estebanlm/objcbridge:v0.9' ]
]

{ #category : 'external projects' }
BaselineOfPharoLauncher >> osSubprocess: spec [

	spec 
		baseline: #OSSubprocess
		with: [ spec repository: 'github://pharo-contributions/OSSubprocess:master/repository' ]
]

{ #category : 'external projects' }
BaselineOfPharoLauncher >> osWinSubprocess: spec [

	spec 
		baseline: #OSWinSubprocess
		with: [ spec repository: 'github://pharo-contributions/OSWinSubprocess:v1' ]
]

{ #category : 'external projects' }
BaselineOfPharoLauncher >> ston: spec [

	spec 
		baseline: #Ston
		with: [ spec repository: 'github://svenvc/ston:master/repository' ]
]

{ #category : 'external projects' }
BaselineOfPharoLauncher >> xmlParser: spec [

	spec 
		baseline: #XMLParser
		with: [ spec 
					repository: 'github://pharo-contributions/XML-XMLParser:3.5.x';
					loads: #('Core') ]
]
