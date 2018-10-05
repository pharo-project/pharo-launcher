baselines
baseline: spec
	<baseline>

	spec for: #'common' do: [
		spec 
			project: 'OSProcess' with: [
				spec
					className: #ConfigurationOfOSProcess;
					versionString: #'stable';
					loads: #('Core with Output' );
					repository: 'http://www.squeaksource.com/MetacelloRepository' ];
			project: 'ProcessWrapper' with: [
				spec
					className: #ConfigurationOfProcessWrapper;
					versionString: #'bleedingEdge';
					loads: #('Core' );
					repository: 'http://smalltalkhub.com/mc/hernan/ProcessWrapper/main/' ];
			project: 'Ston' with: [
				spec
					className: #ConfigurationOfSton;
					versionString: #'stable';
					repository: 'http://ss3.gemstone.com/ss/STON' ];
			project: 'XMLParser' with: [
				spec
					className: #ConfigurationOfXMLParser;
					versionString: #'stable';
					loads: #('Core' );
					repository: 'http://smalltalkhub.com/mc/PharoExtras/XMLParser/main/' ];
				baseline: #Icetray
					with: [ spec repository: 'github://guillep/icetray/src' ];
				package: #FastTableExtentions
					with: [ spec repository: 'github://sbragagnolo/FastTableExtention/src' ].
		spec
			package: #'ConfigurationOfPharoLauncher'; 
			package: #'PharoLauncher-Env';
			package: #'PharoLauncher-Core' with: [
				spec requires: #('PharoLauncher-Env' 'XMLParser' 'Ston'). ];
			package: #'PharoLauncher-Download' with: [
				spec requires: #(#'PharoLauncher-Core' 'OSProcess' 'ProcessWrapper'). ];
			package: #'PharoLauncher-Spec' with: [ 
				spec requires: #(#'PharoLauncher-Core' ). ];
			package: #'PharoLauncher-IceTray' with: [ spec
				requires: #(#'PharoLauncher-Core' #Icetray #FastTableExtentions) ];

			package: #'PharoLauncher-Tests-Core' with: [
				spec requires: #(#'PharoLauncher-Core' ). ];
			package: #'PharoLauncher-Tests-SpecUI' with: [
				spec requires: #(#'PharoLauncher-Core' 'PharoLauncher-Spec'). ];
			package: #'PharoLauncher-Tests-Download' with: [
				spec requires: #(#'PharoLauncher-Download' ). ];
			package: #'PharoLauncher-Tests-Functional' with: [
				spec requires: #(#'PharoLauncher-Core' ). ].
		spec 
			group: 'Default' with: #(#'PharoLauncher-Tests-Core' #'PharoLauncher-Tests-Download' #'PharoLauncher-Core' #'PharoLauncher-Download' #'PharoLauncher-Spec' 'PharoLauncher-Tests-SpecUI' 'PharoLauncher-Tests-Functional' 'PharoLauncher-IceTray');
			group: 'Download' with: #(#'PharoLauncher-Download' #'PharoLauncher-Tests-Download' ). ].

	spec for: #'pharo6.x' do: [	
		self spec70: spec.
		spec
			package: 'PharoLauncher-Spec' with: [ 
				spec requires: #('Spec70Compatibility') ] ]