unit MyStrategy;

interface

uses
  StrategyControl, TypeControl, ActionTypeControl, BonusControl, BonusTypeControl, BuildingControl, BuildingTypeControl,
  CircularUnitControl, FactionControl, GameControl, LaneTypeControl, LivingUnitControl, MessageControl, MinionControl,
  MinionTypeControl, MoveControl, PlayerContextControl, PlayerControl, ProjectileControl, ProjectileTypeControl,
  SkillTypeControl, StatusControl, StatusTypeControl, TreeControl, UnitControl, WizardControl, WorldControl;

type
  TMyStrategy = class (TStrategy)
  public
    procedure Move(me: TWizard; world: TWorld; game: TGame; move: TMove); override;

  end;

implementation

uses
  Math;
    
procedure TMyStrategy.Move(me: TWizard; world: TWorld; game: TGame; move: TMove);
begin
  move.Speed := game.WizardForwardSpeed;
  move.StrafeSpeed := game.WizardStrafeSpeed;
  move.Turn := game.WizardMaxTurnAngle;
  move.Action := ACTION_MAGIC_MISSILE;
end;

end.
