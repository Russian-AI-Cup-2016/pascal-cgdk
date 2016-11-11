unit StrategyControl;

interface

uses
  WizardControl, WorldControl, GameControl, MoveControl;

type
  TStrategy = class
  public
    constructor Create; virtual;
    procedure Move(me: TWizard; world: TWorld; game: TGame; move: TMove); virtual; abstract;

  end;

implementation

constructor TStrategy.Create;
begin
  inherited Create;
end;

end.
