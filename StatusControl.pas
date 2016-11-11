unit StatusControl;

interface

uses
  Math, TypeControl, StatusTypeControl;

type
  TStatus = class
  private
    FId: Int64;
    FType: TStatusType;
    FWizardId: Int64;
    FPlayerId: Int64;
    FRemainingDurationTicks: LongInt;

  public
    constructor Create(const id: Int64; const statusType: TStatusType; const wizardId: Int64; const playerId: Int64;
      const remainingDurationTicks: LongInt);

    function GetId: Int64;
    property Id: Int64 read GetId;
    function GetType: TStatusType;
    property StatusType: TStatusType read GetType;
    function GetWizardId: Int64;
    property WizardId: Int64 read GetWizardId;
    function GetPlayerId: Int64;
    property PlayerId: Int64 read GetPlayerId;
    function GetRemainingDurationTicks: LongInt;
    property RemainingDurationTicks: LongInt read GetRemainingDurationTicks;

    destructor Destroy; override;

  end;

  TStatusArray = array of TStatus;

implementation

constructor TStatus.Create(const id: Int64; const statusType: TStatusType; const wizardId: Int64; const playerId: Int64;
  const remainingDurationTicks: LongInt);
begin
  FId := id;
  FType := statusType;
  FWizardId := wizardId;
  FPlayerId := playerId;
  FRemainingDurationTicks := remainingDurationTicks;
end;

function TStatus.GetId: Int64;
begin
  result := FId;
end;

function TStatus.GetType: TStatusType;
begin
  result := FType;
end;

function TStatus.GetWizardId: Int64;
begin
  result := FWizardId;
end;

function TStatus.GetPlayerId: Int64;
begin
  result := FPlayerId;
end;

function TStatus.GetRemainingDurationTicks: LongInt;
begin
  result := FRemainingDurationTicks;
end;

destructor TStatus.Destroy;
begin
  inherited;
end;

end.
