private
groups
	^ Groups
		ifNil: [ 
			Groups := OrderedDictionary new.
			Groups at: PhLJenkins2Server inriaRmod put: true.
			Groups at: PhLJenkins2Server inriaPharoContribution put: true.
			Groups at: PhLJenkins2Server inriaPharo put: true.
			Groups at: PhLJenkins2Server inriaMoose put: true.
			Groups at: PhLHTTPListingTemplateGroup pharo20 put: true.
			Groups at: PhLHTTPListingTemplateGroup pharo30 put: true.
			Groups at: PhLHTTPListingTemplateGroup pharo40 put: true.
			Groups at: PhLHTTPListingTemplateGroup pharo50 put: true.
			Groups at: PhLHTTPListingTemplateGroup pharo60 put: true.
			Groups at: PhLHTTPListingTemplateGroup pharo70 put: true.
			Groups at: PhLFixedURLsTemplateGroup forCommonTools put: true.
			Groups at: PhLLocalTemplateGroup default put: true.
			^ Groups ]