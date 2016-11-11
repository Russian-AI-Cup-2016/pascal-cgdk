unit TreeControl;

interface

uses
  Math, TypeControl, FactionControl, LivingUnitControl, StatusControl;

type
  TTree = class (TLivingUnit)
  private

  public
    constructor Create(const id: Int64; const x: Double; const y: Double; const speedX: Double; const speedY: Double;
      const angle: Double; const faction: TFaction; const radius: Double; const life: LongInt; const maxLife: LongInt;
      const statuses: TStatusArray);

    destructor Destroy; override;

  end;

  TTreeArray = array of TTree;

implementation

constructor TTree.Create(const id: Int64; const x: Double; const y: Double; const speedX: Double; const speedY: Double;
  const angle: Double; const faction: TFaction; const radius: Double; const life: LongInt; const maxLife: LongInt;
  const statuses: TStatusArray);
begin
  inherited Create(id, x, y, speedX, speedY, angle, faction, radius, life, maxLife, statuses);
end;

destructor TTree.Destroy;
begin
  inherited;
end;

end.
