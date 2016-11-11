unit UnitControl;

interface

uses
  Math, TypeControl, FactionControl;

type
  TUnit = class
  private
    FId: Int64;
    FX: Double;
    FY: Double;
    FSpeedX: Double;
    FSpeedY: Double;
    FAngle: Double;
    FFaction: TFaction;

  protected
    constructor Create(const id: Int64; const x: Double; const y: Double; const speedX: Double; const speedY: Double;
      const angle: Double; const faction: TFaction);

  public
    function GetId: Int64;
    property Id: Int64 read GetId;
    function GetX: Double;
    property X: Double read GetX;
    function GetY: Double;
    property Y: Double read GetY;
    function GetSpeedX: Double;
    property SpeedX: Double read GetSpeedX;
    function GetSpeedY: Double;
    property SpeedY: Double read GetSpeedY;
    function GetAngle: Double;
    property Angle: Double read GetAngle;
    function GetFaction: TFaction;
    property Faction: TFaction read GetFaction;

    function GetAngleTo(x: Double; y: Double): Double; overload;
    function GetAngleTo(otherUnit: TUnit): Double; overload;
    function GetDistanceTo(x: Double; y: Double): Double; overload;
    function GetDistanceTo(otherUnit: TUnit): Double; overload;

    destructor Destroy; override;

  end;

  TUnitArray = array of TUnit;

implementation

constructor TUnit.Create(const id: Int64; const x: Double; const y: Double; const speedX: Double; const speedY: Double;
  const angle: Double; const faction: TFaction);
begin
  FId := id;
  FX := x;
  FY := y;
  FSpeedX := speedX;
  FSpeedY := speedY;
  FAngle := angle;
  FFaction := faction;
end;

function TUnit.GetId: Int64;
begin
  result := FId;
end;

function TUnit.GetX: Double;
begin
  result := FX;
end;

function TUnit.GetY: Double;
begin
  result := FY;
end;

function TUnit.GetSpeedX: Double;
begin
  result := FSpeedX;
end;

function TUnit.GetSpeedY: Double;
begin
  result := FSpeedY;
end;

function TUnit.GetAngle: Double;
begin
  result := FAngle;
end;

function TUnit.GetFaction: TFaction;
begin
  result := FFaction;
end;

function TUnit.GetAngleTo(x: Double; y: Double): Double;
var
  absoluteAngleTo, relativeAngleTo: Double;

begin
  absoluteAngleTo := ArcTan2(y - FY, x - FX);
  relativeAngleTo := absoluteAngleTo - FAngle;

  while relativeAngleTo > PI do begin
    relativeAngleTo := relativeAngleTo - 2 * PI;
  end;

  while relativeAngleTo < -PI do begin
    relativeAngleTo := relativeAngleTo + 2 * PI;
  end;

  result := relativeAngleTo;
end;

function TUnit.getAngleTo(otherUnit: TUnit): Double;
begin
  result := GetAngleTo(otherUnit.FX, otherUnit.FY);
end;

function TUnit.getDistanceTo(x: Double; y: Double): Double;
begin
  result := Sqrt(Sqr(FX - x) + Sqr(FY - y));
end;

function TUnit.getDistanceTo(otherUnit: TUnit): Double;
begin
  result := GetDistanceTo(otherUnit.FX, otherUnit.FY);
end;

destructor TUnit.Destroy;
begin
  inherited;
end;

end.
