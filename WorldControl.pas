unit WorldControl;

interface

uses
  Math, TypeControl, BonusControl, BuildingControl, MinionControl, PlayerControl, ProjectileControl, TreeControl, WizardControl;

type
  TWorld = class
  private
    FTickIndex: LongInt;
    FTickCount: LongInt;
    FWidth: Double;
    FHeight: Double;
    FPlayers: TPlayerArray;
    FWizards: TWizardArray;
    FMinions: TMinionArray;
    FProjectiles: TProjectileArray;
    FBonuses: TBonusArray;
    FBuildings: TBuildingArray;
    FTrees: TTreeArray;

  public
    constructor Create(const tickIndex: LongInt; const tickCount: LongInt; const width: Double; const height: Double;
      const players: TPlayerArray; const wizards: TWizardArray; const minions: TMinionArray;
      const projectiles: TProjectileArray; const bonuses: TBonusArray; const buildings: TBuildingArray;
      const trees: TTreeArray);

    function GetTickIndex: LongInt;
    property TickIndex: LongInt read GetTickIndex;
    function GetTickCount: LongInt;
    property TickCount: LongInt read GetTickCount;
    function GetWidth: Double;
    property Width: Double read GetWidth;
    function GetHeight: Double;
    property Height: Double read GetHeight;
    function GetPlayers: TPlayerArray;
    property Players: TPlayerArray read GetPlayers;
    function GetWizards: TWizardArray;
    property Wizards: TWizardArray read GetWizards;
    function GetMinions: TMinionArray;
    property Minions: TMinionArray read GetMinions;
    function GetProjectiles: TProjectileArray;
    property Projectiles: TProjectileArray read GetProjectiles;
    function GetBonuses: TBonusArray;
    property Bonuses: TBonusArray read GetBonuses;
    function GetBuildings: TBuildingArray;
    property Buildings: TBuildingArray read GetBuildings;
    function GetTrees: TTreeArray;
    property Trees: TTreeArray read GetTrees;

    function GetMyPlayer: TPlayer;

    destructor Destroy; override;

  end;

  TWorldArray = array of TWorld;

implementation

constructor TWorld.Create(const tickIndex: LongInt; const tickCount: LongInt; const width: Double; const height: Double;
  const players: TPlayerArray; const wizards: TWizardArray; const minions: TMinionArray;
  const projectiles: TProjectileArray; const bonuses: TBonusArray; const buildings: TBuildingArray;
  const trees: TTreeArray);
begin
  FTickIndex := tickIndex;
  FTickCount := tickCount;
  FWidth := width;
  FHeight := height;
  if Assigned(players) then begin
    FPlayers := Copy(players, 0, Length(players));
  end else begin
    FPlayers := nil;
  end;
  if Assigned(wizards) then begin
    FWizards := Copy(wizards, 0, Length(wizards));
  end else begin
    FWizards := nil;
  end;
  if Assigned(minions) then begin
    FMinions := Copy(minions, 0, Length(minions));
  end else begin
    FMinions := nil;
  end;
  if Assigned(projectiles) then begin
    FProjectiles := Copy(projectiles, 0, Length(projectiles));
  end else begin
    FProjectiles := nil;
  end;
  if Assigned(bonuses) then begin
    FBonuses := Copy(bonuses, 0, Length(bonuses));
  end else begin
    FBonuses := nil;
  end;
  if Assigned(buildings) then begin
    FBuildings := Copy(buildings, 0, Length(buildings));
  end else begin
    FBuildings := nil;
  end;
  if Assigned(trees) then begin
    FTrees := Copy(trees, 0, Length(trees));
  end else begin
    FTrees := nil;
  end;
end;

function TWorld.GetTickIndex: LongInt;
begin
  result := FTickIndex;
end;

function TWorld.GetTickCount: LongInt;
begin
  result := FTickCount;
end;

function TWorld.GetWidth: Double;
begin
  result := FWidth;
end;

function TWorld.GetHeight: Double;
begin
  result := FHeight;
end;

function TWorld.GetPlayers: TPlayerArray;
begin
  if Assigned(FPlayers) then begin
    result := Copy(FPlayers, 0, Length(FPlayers));
  end else begin
    result := nil;
  end;
end;

function TWorld.GetWizards: TWizardArray;
begin
  if Assigned(FWizards) then begin
    result := Copy(FWizards, 0, Length(FWizards));
  end else begin
    result := nil;
  end;
end;

function TWorld.GetMinions: TMinionArray;
begin
  if Assigned(FMinions) then begin
    result := Copy(FMinions, 0, Length(FMinions));
  end else begin
    result := nil;
  end;
end;

function TWorld.GetProjectiles: TProjectileArray;
begin
  if Assigned(FProjectiles) then begin
    result := Copy(FProjectiles, 0, Length(FProjectiles));
  end else begin
    result := nil;
  end;
end;

function TWorld.GetBonuses: TBonusArray;
begin
  if Assigned(FBonuses) then begin
    result := Copy(FBonuses, 0, Length(FBonuses));
  end else begin
    result := nil;
  end;
end;

function TWorld.GetBuildings: TBuildingArray;
begin
  if Assigned(FBuildings) then begin
    result := Copy(FBuildings, 0, Length(FBuildings));
  end else begin
    result := nil;
  end;
end;

function TWorld.GetTrees: TTreeArray;
begin
  if Assigned(FTrees) then begin
    result := Copy(FTrees, 0, Length(FTrees));
  end else begin
    result := nil;
  end;
end;

function TWorld.GetMyPlayer: TPlayer;
var
  playerIndex: LongInt;

begin
  for playerIndex := High(FPlayers) downto 0 do begin
    if FPlayers[playerIndex].GetMe then begin
      result := FPlayers[playerIndex];
      exit;
    end;
  end;

  result := nil;
end;

destructor TWorld.Destroy;
var
  i: LongInt;

begin
  if Assigned(FPlayers) then begin
    for i := High(FPlayers) downto 0 do begin
      if Assigned(FPlayers[i]) then begin
        FPlayers[i].Free;
      end;
    end;
  end;

  if Assigned(FWizards) then begin
    for i := High(FWizards) downto 0 do begin
      if Assigned(FWizards[i]) then begin
        FWizards[i].Free;
      end;
    end;
  end;

  if Assigned(FMinions) then begin
    for i := High(FMinions) downto 0 do begin
      if Assigned(FMinions[i]) then begin
        FMinions[i].Free;
      end;
    end;
  end;

  if Assigned(FProjectiles) then begin
    for i := High(FProjectiles) downto 0 do begin
      if Assigned(FProjectiles[i]) then begin
        FProjectiles[i].Free;
      end;
    end;
  end;

  if Assigned(FBonuses) then begin
    for i := High(FBonuses) downto 0 do begin
      if Assigned(FBonuses[i]) then begin
        FBonuses[i].Free;
      end;
    end;
  end;

  if Assigned(FBuildings) then begin
    for i := High(FBuildings) downto 0 do begin
      if Assigned(FBuildings[i]) then begin
        FBuildings[i].Free;
      end;
    end;
  end;

  inherited;
end;

end.
