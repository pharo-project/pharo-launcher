private
groups
	^ Groups
		ifNil: [ 
			Groups := Dictionary new.
			Groups at: PhLJenkinsServer inriaRmod put: false.
			Groups at: PhLJenkinsServer inriaPharoContribution put: true.
			Groups at: PhLJenkinsServer inriaMoose put: false.
			Groups at: PhLHTTPListingTemplateGroup pharo20 put: true.
			Groups at: PhLHTTPListingTemplateGroup pharo30 put: true.
			Groups at: PhLFixedURLsTemplateGroup forCommonTools put: true.
			Groups at: PhLLocalTemplateGroup default put: true.
			^ Groups ]