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
			baseline: #Spec2
				with: [ spec repository: 'github://pharo-spec/Spec/src' ];
			baseline: #OSSubprocess
				with: [ spec repository: 'github://pharo-contributions/OSSubprocess:v1.1' ];
			baseline: #OSWinSubprocess
				with: [ spec repository: 'github://pharo-contributions/OSWinSubprocess:v1' ];
			project: 'XMLParser' with: [
				spec
					className: #ConfigurationOfXMLParser;
					versionString: #'stable';
					loads: #('Core' );
					repository: 'http://smalltalkhub.com/mc/PharoExtras/XMLParser/main/' ].
		spec
			package: #'PharoLauncher-ZipArchive';
			package: #'PharoLauncher-70Compatibility'; 
			package: #'PharoLauncher-Core' with: [
				spec requires: #(#'XMLParser' #'OSSubprocess' #'OSWinSubprocess' #'PharoLauncher-ZipArchive' #'PharoLauncher-70Compatibility'). ];
			package: #'PharoLauncher-Spec' with: [ 
				spec requires: #(#'PharoLauncher-Core' ). ];
			package: #'PharoLauncher-Spec2' with: [ 
				spec requires: #(#'PharoLauncher-Core' #Spec2). ];

			package: #'PharoLauncher-Tests-Core' with: [
				spec requires: #(#'PharoLauncher-Core' ). ];
			package: #'PharoLauncher-Tests-Commands' with: [
				spec requires: #(#'PharoLauncher-Spec2' ). ];
			package: #'PharoLauncher-Tests-SpecUI' with: [
				spec requires: #(#'PharoLauncher-Core' #'PharoLauncher-Spec'). ];
			package: #'PharoLauncher-Tests-Download' with: [
				spec requires: #(#'PharoLauncher-Tests-Core' ). ];
			package: #'PharoLauncher-Tests-Functional' with: [
				spec requires: #(#'PharoLauncher-Core' #'PharoLauncher-Tests-Download'). ].
		spec 
			group: 'Default' with: #(#'PharoLauncher-Tests-Core' #'PharoLauncher-Tests-Download' #'PharoLauncher-Core' #'PharoLauncher-Spec' #'PharoLauncher-Tests-SpecUI' #'PharoLauncher-Tests-Functional'). ].
]
