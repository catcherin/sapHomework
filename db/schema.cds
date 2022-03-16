namespace sap.ui.riskmanagement;
using { managed } from '@sap/cds/common';
//date;description;result
  entity Reports : managed {
    key ID      : UUID  @(Core.Computed : true);
    date        : String(100);
    description : String;
    result      : Integer;
    criticality : Integer;
    risk        : Association to Risks;
    miti        : Association to Mitigations;
  }

  entity Risks : managed {
    key ID      : UUID  @(Core.Computed : true);
    title       : String(100);
    prio        : String(5);
    descr       : String;
    miti        : Association to Mitigations;
    impact      : Integer;
    criticality : Integer;
    reports     : Association to many Reports on reports.risk = $self;
  }

  entity Mitigations : managed {
    key ID       : UUID  @(Core.Computed : true);
    description  : String;
    owner        : String;
    timeline     : String;
    risks        : Association to many Risks on risks.miti = $self;
    reports      : Association to many Reports on reports.miti = $self;
  }
