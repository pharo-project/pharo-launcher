specs
specLayout
	<spec: #default>
	^ SpecLayout composed
			newRow: 
			[ 	:r | r 
				newColumn:
				[	:c3 | c3
					add: #templatesModel;
					add: #quitOnLaunchCheckBoxModel height: 25 "2013-10-13-BTC How do you left justfiy checkbox?"
				] left: 0.60;
				addSplitter;
				newColumn: 
				[ 	:c2 | c2
					add: #imagesModel ;
					add: #statusbarModel height: 25						
				] right: 0.40
			];
			yourself.