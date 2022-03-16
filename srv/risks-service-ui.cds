using RiskService from './risk-service';

annotate RiskService.Reports with {
	date        @title: 'Date';
	description @title: 'Description';
	result      @title: 'Result';
	risk        @title: 'Risk';
	miti        @title: 'Mitigation';
}

annotate RiskService.Reports with @(
	UI: {
		HeaderInfo: {
			TypeName: 'Reports',
			TypeNamePlural: 'Reports',
			Title          : {
                $Type : 'UI.DataField',
                Value : description
            },
			// Description : {
			// 	$Type: 'UI.DataField',
			// 	Value: description
			// }
		},
		SelectionFields: [result],
		LineItem: [
			{Value: date},
			{Value: risk_ID},
			{Value: miti_ID},
			{
				Value: result,
				Criticality: criticality
			}
		],
		Facets: [
			{$Type: 'UI.ReferenceFacet', Label: 'Main', Target: '@UI.FieldGroup#Main'}
		],
		FieldGroup#Main: {
			Data: [
				{Value: date},
				{Value: risk_ID},
				{Value: miti_ID},
				{
					Value: result,
					Criticality: criticality
				}
			]
		}
	},
) {

};

annotate RiskService.Reports with {
	risk @(
		Common: {
			//show text, not id for mitigation in the context of risks
			Text: risk.descr, TextArrangement: #TextOnly,
			ValueList: {
				Label: 'Risks',
				CollectionPath: 'Risks',
				Parameters: [
					{ $Type: 'Common.ValueListParameterInOut',
						LocalDataProperty: risk_ID,
						ValueListProperty: 'ID'
					},
					{ $Type: 'Common.ValueListParameterDisplayOnly',
						ValueListProperty: 'descr'
					}
				]
			}
		}
	);

	miti @(
		Common: {
			//show text, not id for mitigation in the context of risks
			Text: miti.description  , TextArrangement: #TextOnly,
			ValueList: {
				Label: 'Mitigations',
				CollectionPath: 'Mitigations',
				Parameters: [
					{ $Type: 'Common.ValueListParameterInOut',
						LocalDataProperty: miti_ID,
						ValueListProperty: 'ID'
					},
					{ $Type: 'Common.ValueListParameterDisplayOnly',
						ValueListProperty: 'description'
					}
				]
			}
		}
	);
}

annotate RiskService.Risks with {
	title       @title: 'Title';
	prio        @title: 'Priority';
	descr       @title: 'Description';
	miti        @title: 'Mitigation';
	impact      @title: 'Impact';
}

annotate RiskService.Mitigations with {
	ID @(
		UI.Hidden,
		Common: {
		Text: description
		}
	);
	description  @title: 'Description';
	owner        @title: 'Owner';
	timeline     @title: 'Timeline';
	risks        @title: 'Risks';
}

annotate RiskService.Risks with @(
	UI: {
		HeaderInfo: {
			TypeName: 'Risk',
			TypeNamePlural: 'Risks',
			Title          : {
                $Type : 'UI.DataField',
                Value : title
            },
			Description : {
				$Type: 'UI.DataField',
				Value: descr
			}
		},
		SelectionFields: [prio],
		LineItem: [
			{Value: title},
			{Value: miti_ID},
			{
				Value: prio,
				Criticality: criticality
			},
			{
				Value: impact,
				Criticality: criticality
			}
		],
		Facets: [
			{$Type: 'UI.ReferenceFacet', Label: 'Main', Target: '@UI.FieldGroup#Main'}
		],
		FieldGroup#Main: {
			Data: [
				{Value: miti_ID},
				{
					Value: prio,
					Criticality: criticality
				},
				{
					Value: impact,
					Criticality: criticality
				}
			]
		}
	},
) {

};

annotate RiskService.Risks with {
	miti @(
		Common: {
			//show text, not id for mitigation in the context of risks
			Text: miti.description  , TextArrangement: #TextOnly,
			ValueList: {
				Label: 'Mitigations',
				CollectionPath: 'Mitigations',
				Parameters: [
					{ $Type: 'Common.ValueListParameterInOut',
						LocalDataProperty: miti_ID,
						ValueListProperty: 'ID'
					},
					{ $Type: 'Common.ValueListParameterDisplayOnly',
						ValueListProperty: 'description'
					}
				]
			}
		}
	);
}
