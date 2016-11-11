unit MessageControl;

interface

uses
  Math, TypeControl, LaneTypeControl, SkillTypeControl;

type
  TMessage = class
  private
    FLane: TLaneType;
    FSkillToLearn: TSkillType;
    FRawMessage: TbyteArray;

  public
    constructor Create(const lane: TLaneType; const skillToLearn: TSkillType; const rawMessage: TbyteArray);

    function GetLane: TLaneType;
    property Lane: TLaneType read GetLane;
    function GetSkillToLearn: TSkillType;
    property SkillToLearn: TSkillType read GetSkillToLearn;
    function GetRawMessage: TbyteArray;
    property RawMessage: TbyteArray read GetRawMessage;

    destructor Destroy; override;

  end;

  TMessageArray = array of TMessage;

implementation

constructor TMessage.Create(const lane: TLaneType; const skillToLearn: TSkillType; const rawMessage: TbyteArray);
begin
  FLane := lane;
  FSkillToLearn := skillToLearn;
  if Assigned(rawMessage) then begin
    FRawMessage := Copy(rawMessage, 0, Length(rawMessage));
  end else begin
    FRawMessage := nil;
  end;
end;

function TMessage.GetLane: TLaneType;
begin
  result := FLane;
end;

function TMessage.GetSkillToLearn: TSkillType;
begin
  result := FSkillToLearn;
end;

function TMessage.GetRawMessage: TbyteArray;
begin
  if Assigned(FRawMessage) then begin
    result := Copy(FRawMessage, 0, Length(FRawMessage));
  end else begin
    result := nil;
  end;
end;

destructor TMessage.Destroy;
begin
  inherited;
end;

end.
