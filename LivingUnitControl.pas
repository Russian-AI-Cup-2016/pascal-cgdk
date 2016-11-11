unit LivingUnitControl;

interface

uses
  Math, TypeControl, CircularUnitControl, FactionControl, StatusControl;

type
  TLivingUnit = class (TCircularUnit)
  private
    FLife: LongInt;
    FMaxLife: LongInt;
    FStatuses: TStatusArray;

  protected
    constructor Create(const id: Int64; const x: Double; const y: Double; const speedX: Double; const speedY: Double;
      const angle: Double; const faction: TFaction; const radius: Double; const life: LongInt; const maxLife: LongInt;
      const statuses: TStatusArray);

  public
    function GetLife: LongInt;
    property Life: LongInt read GetLife;
    function GetMaxLife: LongInt;
    property MaxLife: LongInt read GetMaxLife;
    function GetStatuses: TStatusArray;
    property Statuses: TStatusArray read GetStatuses;

    destructor Destroy; override;

  end;

  TLivingUnitArray = array of TLivingUnit;

implementation

constructor TLivingUnit.Create(const id: Int64; const x: Double; const y: Double; const speedX: Double;
  const speedY: Double; const angle: Double; const faction: TFaction; const radius: Double; const life: LongInt;
  const maxLife: LongInt; const statuses: TStatusArray);
begin
  inherited Create(id, x, y, speedX, speedY, angle, faction, radius);

  FLife := life;
  FMaxLife := maxLife;
  if Assigned(statuses) then begin
    FStatuses := Copy(statuses, 0, Length(statuses));
  end else begin
    FStatuses := nil;
  end;
end;

function TLivingUnit.GetLife: LongInt;
begin
  result := FLife;
end;

function TLivingUnit.GetMaxLife: LongInt;
begin
  result := FMaxLife;
end;

function TLivingUnit.GetStatuses: TStatusArray;
begin
  if Assigned(FStatuses) then begin
    result := Copy(FStatuses, 0, Length(FStatuses));
  end else begin
    result := nil;
  end;
end;

destructor TLivingUnit.Destroy;
var
  i: LongInt;

begin
  if Assigned(FStatuses) then begin
    for i := High(FStatuses) downto 0 do begin
      if Assigned(FStatuses[i]) then begin
        FStatuses[i].Free;
      end;
    end;
  end;

  inherited;
end;

end.
