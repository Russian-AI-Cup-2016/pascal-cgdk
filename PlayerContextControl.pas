unit PlayerContextControl;

interface

uses
  Math, TypeControl, WizardControl, WorldControl;

type
  TPlayerContext = class
  private
    FWizards: TWizardArray;
    FWorld: TWorld;

  public
    constructor Create(const wizards: TWizardArray; const world: TWorld);

    function GetWizards: TWizardArray;
    property Wizards: TWizardArray read GetWizards;
    function GetWorld: TWorld;
    property World: TWorld read GetWorld;

    destructor Destroy; override;

  end;

  TPlayerContextArray = array of TPlayerContext;

implementation

constructor TPlayerContext.Create(const wizards: TWizardArray; const world: TWorld);
begin
  if Assigned(wizards) then begin
    FWizards := Copy(wizards, 0, Length(wizards));
  end else begin
    FWizards := nil;
  end;
  FWorld := world;
end;

function TPlayerContext.GetWizards: TWizardArray;
begin
  if Assigned(FWizards) then begin
    result := Copy(FWizards, 0, Length(FWizards));
  end else begin
    result := nil;
  end;
end;

function TPlayerContext.GetWorld: TWorld;
begin
  result := FWorld;
end;

destructor TPlayerContext.Destroy;
var
  i: LongInt;

begin
  if Assigned(FWizards) then begin
    for i := High(FWizards) downto 0 do begin
      if Assigned(FWizards[i]) then begin
        FWizards[i].Free;
      end;
    end;
  end;

  if Assigned(FWorld) then begin
    FWorld.Free;
  end;

  inherited;
end;

end.
