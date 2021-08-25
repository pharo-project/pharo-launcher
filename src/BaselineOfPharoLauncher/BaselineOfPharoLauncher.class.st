Class {
	#name : #BaselineOfPharoLauncher,
	#superclass : #BaselineOf,
	#category : #BaselineOfPharoLauncher
}

{ #category : #baselines }
BaselineOfPharoLauncher >> baseline: spec [
	<baseline>

	spec for: #'common' do: [
		spec 
			baseline: #Ston
				with: [ spec repository: 'github://svenvc/ston:master/repository' ];
			baseline: #Spec2
				with: [ spec repository: 'github://pharo-spec/Spec:spec-pharo-launcher/src' ];
			baseline: #OSSubprocess
				with: [ spec repository: 'github://pharo-contributions/OSSubprocess:v1.2' ];
			baseline: #OSWinSubprocess
				with: [ spec repository: 'github://pharo-contributions/OSWinSubprocess:v1' ];
			baseline: #XMLParser
				with: [ spec 
							repository: 'github://pharo-contributions/XML-XMLParser:3.5.x';
							loads: #('Core') ];
			baseline: 'Clap'
				with: [ spec repository: 'github://cdlm/clap-st/src' ].
		
		spec
			package: #'PharoLauncher-80Compatibility'; 
			package: #'Compression-Pharo10'; 
			package: #'PharoLauncher-Pharo9ToRemove-FileLocator'; 
			package: #'PharoLauncher-80Compatibility'; 
			package: #'PharoLauncher-Core' with: [
				spec requires: #(#'XMLParser' #'OSSubprocess' #'OSWinSubprocess' #'Ston' #'PharoLauncher-80Compatibility' #'PharoLauncher-Pharo9ToRemove-FileLocator' #'Compression-Pharo10'). ];
			package: #'PharoLauncher-Spec2' with: [ 
				spec requires: #(#'PharoLauncher-Core' #Spec2). ];
			package: #'PharoLauncher-GToolkit' with: [ 
				spec requires: #(#'PharoLauncher-Core'). ];
			package: #'PharoLauncher-Squeak' with: [ 
				spec requires: #(#'PharoLauncher-Core'). ];
			package: 'PharoLauncher-CLI' with: [ spec requires: #('Clap')];

			package: #'PharoLauncher-Tests-Core' with: [
				spec requires: #(#'PharoLauncher-Core' ). ];
			package: #'PharoLauncher-Tests-Commands' with: [
				spec requires: #(#'PharoLauncher-Spec2' ). ];
			package: #'PharoLauncher-Tests-SpecUI' with: [
				spec requires: #(#'PharoLauncher-Core' #'PharoLauncher-Spec2'). ];
			package: #'PharoLauncher-Tests-Download' with: [
				spec requires: #(#'PharoLauncher-Tests-Core' ). ];
			package: #'PharoLauncher-Tests-Functional' with: [
				spec requires: #(#'PharoLauncher-Core' #'PharoLauncher-Tests-Download'). ];
			package: 'PharoLauncher-CLI-Tests' with: [ 
				spec requires: #('PharoLauncher-CLI') ].

		spec 
			group: 'Default' with: #(#'PharoLauncher-Tests-Core' #'PharoLauncher-Tests-Download' #'PharoLauncher-Core' #'PharoLauncher-Spec2' #'PharoLauncher-Tests-SpecUI' #'PharoLauncher-Tests-Functional' #'PharoLauncher-CLI-Tests' #'PharoLauncher-GToolkit' #'PharoLauncher-Squeak'). ].
]
