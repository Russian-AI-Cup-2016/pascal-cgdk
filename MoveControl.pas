unit MoveControl;

interface

uses
  Math, TypeControl, ActionTypeControl, MessageControl, SkillTypeControl;

type
  TMove = class
  private
    FSpeed: Double;
    FStrafeSpeed: Double;
    FTurn: Double;
    FAction: TActionType;
    FCastAngle: Double;
    FMinCastDistance: Double;
    FMaxCastDistance: Double;
    FStatusTargetId: Int64;
    FSkillToLearn: TSkillType;
    FMessages: TMessageArray;

  public
    constructor Create;

    function GetSpeed: Double;
    procedure SetSpeed(speed: Double);
    property Speed: Double read GetSpeed write SetSpeed;
    function GetStrafeSpeed: Double;
    procedure SetStrafeSpeed(strafeSpeed: Double);
    property StrafeSpeed: Double read GetStrafeSpeed write SetStrafeSpeed;
    function GetTurn: Double;
    procedure SetTurn(turn: Double);
    property Turn: Double read GetTurn write SetTurn;
    function GetAction: TActionType;
    procedure SetAction(action: TActionType);
    property Action: TActionType read GetAction write SetAction;
    function GetCastAngle: Double;
    procedure SetCastAngle(castAngle: Double);
    property CastAngle: Double read GetCastAngle write SetCastAngle;
    function GetMinCastDistance: Double;
    procedure SetMinCastDistance(minCastDistance: Double);
    property MinCastDistance: Double read GetMinCastDistance write SetMinCastDistance;
    function GetMaxCastDistance: Double;
    procedure SetMaxCastDistance(maxCastDistance: Double);
    property MaxCastDistance: Double read GetMaxCastDistance write SetMaxCastDistance;
    function GetStatusTargetId: Int64;
    procedure SetStatusTargetId(statusTargetId: Int64);
    property StatusTargetId: Int64 read GetStatusTargetId write SetStatusTargetId;
    function GetSkillToLearn: TSkillType;
    procedure SetSkillToLearn(skillToLearn: TSkillType);
    property SkillToLearn: TSkillType read GetSkillToLearn write SetSkillToLearn;
    function GetMessages: TMessageArray;
    procedure SetMessages(messages: TMessageArray);
    property Messages: TMessageArray read GetMessages write SetMessages;

    destructor Destroy; override;

  end;

  TMoveArray = array of TMove;

implementation

constructor TMove.Create;
begin
  FSpeed := 0.0;
  FStrafeSpeed := 0.0;
  FTurn := 0.0;
  FAction := _ACTION_UNKNOWN_;
  FCastAngle := 0.0;
  FMinCastDistance := 0.0;
  FMaxCastDistance := 10000.0;
  FStatusTargetId := -1;
  FSkillToLearn := _SKILL_UNKNOWN_;
  FMessages := nil;
end;

function TMove.GetSpeed: Double;
begin
  result := FSpeed;
end;

procedure TMove.SetSpeed(speed: Double);
begin
  FSpeed := speed;
end;

function TMove.GetStrafeSpeed: Double;
begin
  result := FStrafeSpeed;
end;

procedure TMove.SetStrafeSpeed(strafeSpeed: Double);
begin
  FStrafeSpeed := strafeSpeed;
end;

function TMove.GetTurn: Double;
begin
  result := FTurn;
end;

procedure TMove.SetTurn(turn: Double);
begin
  FTurn := turn;
end;

function TMove.GetAction: TActionType;
begin
  result := FAction;
end;

procedure TMove.SetAction(action: TActionType);
begin
  FAction := action;
end;

function TMove.GetCastAngle: Double;
begin
  result := FCastAngle;
end;

procedure TMove.SetCastAngle(castAngle: Double);
begin
  FCastAngle := castAngle;
end;

function TMove.GetMinCastDistance: Double;
begin
  result := FMinCastDistance;
end;

procedure TMove.SetMinCastDistance(minCastDistance: Double);
begin
  FMinCastDistance := minCastDistance;
end;

function TMove.GetMaxCastDistance: Double;
begin
  result := FMaxCastDistance;
end;

procedure TMove.SetMaxCastDistance(maxCastDistance: Double);
begin
  FMaxCastDistance := maxCastDistance;
end;

function TMove.GetStatusTargetId: Int64;
begin
  result := FStatusTargetId;
end;

procedure TMove.SetStatusTargetId(statusTargetId: Int64);
begin
  FStatusTargetId := statusTargetId;
end;

function TMove.GetSkillToLearn: TSkillType;
begin
  result := FSkillToLearn;
end;

procedure TMove.SetSkillToLearn(skillToLearn: TSkillType);
begin
  FSkillToLearn := skillToLearn;
end;

function TMove.GetMessages: TMessageArray;
begin
  if Assigned(FMessages) then begin
    result := Copy(FMessages, 0, Length(FMessages));
  end else begin
    result := nil;
  end;
end;

procedure TMove.SetMessages(messages: TMessageArray);
begin
  if Assigned(messages) then begin
    FMessages := Copy(messages, 0, Length(messages));
  end else begin
    FMessages := nil;
  end;
end;

destructor TMove.Destroy;
var
  i: LongInt;

begin
  if Assigned(FMessages) then begin
    for i := High(FMessages) downto 0 do begin
      if Assigned(FMessages[i]) then begin
        FMessages[i].Free;
      end;
    end;
  end;

  inherited;
end;

end.
