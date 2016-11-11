unit WizardControl;

interface

uses
  Math, TypeControl, FactionControl, LivingUnitControl, MessageControl, SkillTypeControl, StatusControl;

type
  TWizard = class (TLivingUnit)
  private
    FOwnerPlayerId: Int64;
    FMe: Boolean;
    FMana: LongInt;
    FMaxMana: LongInt;
    FVisionRange: Double;
    FCastRange: Double;
    FXp: LongInt;
    FLevel: LongInt;
    FSkills: TSkillTypeArray;
    FRemainingActionCooldownTicks: LongInt;
    FRemainingCooldownTicksByAction: TLongIntArray;
    FMaster: Boolean;
    FMessages: TMessageArray;

  public
    constructor Create(const id: Int64; const x: Double; const y: Double; const speedX: Double; const speedY: Double;
      const angle: Double; const faction: TFaction; const radius: Double; const life: LongInt; const maxLife: LongInt;
      const statuses: TStatusArray; const ownerPlayerId: Int64; const me: Boolean; const mana: LongInt;
      const maxMana: LongInt; const visionRange: Double; const castRange: Double; const xp: LongInt;
      const level: LongInt; const skills: TSkillTypeArray; const remainingActionCooldownTicks: LongInt;
      const remainingCooldownTicksByAction: TLongIntArray; const master: Boolean; const messages: TMessageArray);

    function GetOwnerPlayerId: Int64;
    property OwnerPlayerId: Int64 read GetOwnerPlayerId;
    function GetMe: Boolean;
    property IsMe: Boolean read GetMe;
    function GetMana: LongInt;
    property Mana: LongInt read GetMana;
    function GetMaxMana: LongInt;
    property MaxMana: LongInt read GetMaxMana;
    function GetVisionRange: Double;
    property VisionRange: Double read GetVisionRange;
    function GetCastRange: Double;
    property CastRange: Double read GetCastRange;
    function GetXp: LongInt;
    property Xp: LongInt read GetXp;
    function GetLevel: LongInt;
    property Level: LongInt read GetLevel;
    function GetSkills: TSkillTypeArray;
    property Skills: TSkillTypeArray read GetSkills;
    function GetRemainingActionCooldownTicks: LongInt;
    property RemainingActionCooldownTicks: LongInt read GetRemainingActionCooldownTicks;
    function GetRemainingCooldownTicksByAction: TLongIntArray;
    property RemainingCooldownTicksByAction: TLongIntArray read GetRemainingCooldownTicksByAction;
    function GetMaster: Boolean;
    property IsMaster: Boolean read GetMaster;
    function GetMessages: TMessageArray;
    property Messages: TMessageArray read GetMessages;

    destructor Destroy; override;

  end;

  TWizardArray = array of TWizard;

implementation

constructor TWizard.Create(const id: Int64; const x: Double; const y: Double; const speedX: Double;
  const speedY: Double; const angle: Double; const faction: TFaction; const radius: Double; const life: LongInt;
  const maxLife: LongInt; const statuses: TStatusArray; const ownerPlayerId: Int64; const me: Boolean;
  const mana: LongInt; const maxMana: LongInt; const visionRange: Double; const castRange: Double; const xp: LongInt;
  const level: LongInt; const skills: TSkillTypeArray; const remainingActionCooldownTicks: LongInt;
  const remainingCooldownTicksByAction: TLongIntArray; const master: Boolean; const messages: TMessageArray);
begin
  inherited Create(id, x, y, speedX, speedY, angle, faction, radius, life, maxLife, statuses);

  FOwnerPlayerId := ownerPlayerId;
  FMe := me;
  FMana := mana;
  FMaxMana := maxMana;
  FVisionRange := visionRange;
  FCastRange := castRange;
  FXp := xp;
  FLevel := level;
  if Assigned(skills) then begin
    FSkills := Copy(skills, 0, Length(skills));
  end else begin
    FSkills := nil;
  end;
  FRemainingActionCooldownTicks := remainingActionCooldownTicks;
  if Assigned(remainingCooldownTicksByAction) then begin
    FRemainingCooldownTicksByAction := Copy(remainingCooldownTicksByAction, 0, Length(remainingCooldownTicksByAction));
  end else begin
    FRemainingCooldownTicksByAction := nil;
  end;
  FMaster := master;
  if Assigned(messages) then begin
    FMessages := Copy(messages, 0, Length(messages));
  end else begin
    FMessages := nil;
  end;
end;

function TWizard.GetOwnerPlayerId: Int64;
begin
  result := FOwnerPlayerId;
end;

function TWizard.GetMe: Boolean;
begin
  result := FMe;
end;

function TWizard.GetMana: LongInt;
begin
  result := FMana;
end;

function TWizard.GetMaxMana: LongInt;
begin
  result := FMaxMana;
end;

function TWizard.GetVisionRange: Double;
begin
  result := FVisionRange;
end;

function TWizard.GetCastRange: Double;
begin
  result := FCastRange;
end;

function TWizard.GetXp: LongInt;
begin
  result := FXp;
end;

function TWizard.GetLevel: LongInt;
begin
  result := FLevel;
end;

function TWizard.GetSkills: TSkillTypeArray;
begin
  if Assigned(FSkills) then begin
    result := Copy(FSkills, 0, Length(FSkills));
  end else begin
    result := nil;
  end;
end;

function TWizard.GetRemainingActionCooldownTicks: LongInt;
begin
  result := FRemainingActionCooldownTicks;
end;

function TWizard.GetRemainingCooldownTicksByAction: TLongIntArray;
begin
  if Assigned(FRemainingCooldownTicksByAction) then begin
    result := Copy(FRemainingCooldownTicksByAction, 0, Length(FRemainingCooldownTicksByAction));
  end else begin
    result := nil;
  end;
end;

function TWizard.GetMaster: Boolean;
begin
  result := FMaster;
end;

function TWizard.GetMessages: TMessageArray;
begin
  if Assigned(FMessages) then begin
    result := Copy(FMessages, 0, Length(FMessages));
  end else begin
    result := nil;
  end;
end;

destructor TWizard.Destroy;
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
