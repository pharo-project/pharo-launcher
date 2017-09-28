baselines
baseline10: spec
	<version: '1-baseline'>

	spec for: #'common' do: [
		spec blessing: #'baseline'.
		spec repository: 'http://smalltalkhub.com/mc/Pharo/PharoLauncher/main/'.
		spec 
			project: 'XMLParser' with: [
				spec
					className: #ConfigurationOfXMLParser;
					versionString: #'stable';
					loads: #('Core' );
					repository: 'http://smalltalkhub.com/mc/PharoExtras/XMLParser/main/' ];
			project: 'OSProcess' with: [
				spec
					className: #ConfigurationOfOSProcess;
					versionString: #'stable';
					loads: #('Core with Output' );
					repository: 'http://www.squeaksource.com/MetacelloRepository' ];
			project: 'ProcessWrapper' with: [
				spec
					className: #ConfigurationOfProcessWrapper;
					versionString: #'stable';
					loads: #('Core' );
					repository: 'http://smalltalkhub.com/mc/hernan/ProcessWrapper/main/' ];
			project: 'JSON' with: [
				spec
					className: #ConfigurationOfJSON;
					versionString: #'stable';
					repository: 'http://smalltalkhub.com/mc/PharoExtras/JSON/main/' ];
			project: 'Ston' with: [
				spec
					className: #ConfigurationOfSton;
					versionString: #'stable';
					repository: 'http://ss3.gemstone.com/ss/STON' ].
		spec 
			package: #'PharoLauncher-Core' with: [
				spec requires: #('XMLParser' 'OSProcess' 'Ston' 'JSON' ). ];
			package: #'PharoLauncher-Spec' with: [
				spec requires: #(#'PharoLauncher-Core' ). ];
			package: #'PharoLauncher-Tests-Core' with: [
				spec requires: #(#'PharoLauncher-Core' ). ]. ].
