unit BonusControl;

interface

uses
  Math, TypeControl, BonusTypeControl, CircularUnitControl, FactionControl;

type
  TBonus = class (TCircularUnit)
  private
    FType: TBonusType;

  public
    constructor Create(const id: Int64; const x: Double; const y: Double; const speedX: Double; const speedY: Double;
      const angle: Double; const faction: TFaction; const radius: Double; const bonusType: TBonusType);

    function GetType: TBonusType;
    property BonusType: TBonusType read GetType;

    destructor Destroy; override;

  end;

  TBonusArray = array of TBonus;

implementation

constructor TBonus.Create(const id: Int64; const x: Double; const y: Double; const speedX: Double; const speedY: Double;
  const angle: Double; const faction: TFaction; const radius: Double; const bonusType: TBonusType);
begin
  inherited Create(id, x, y, speedX, speedY, angle, faction, radius);

  FType := bonusType;
end;

function TBonus.GetType: TBonusType;
begin
  result := FType;
end;

destructor TBonus.Destroy;
begin
  inherited;
end;

end.
