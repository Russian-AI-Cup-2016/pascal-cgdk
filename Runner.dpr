uses
  SysUtils, RemoteProcessClient, StrategyControl, MyStrategy,
  WizardControl, PlayerContextControl, MoveControl, GameControl;

type
  TRunner = class
  private
    FRemoteProcessClient: TRemoteProcessClient;
    FToken: String;

  public
    constructor Create(arguments: array of String);

    procedure Run;

    destructor Destroy; override;

  end;

constructor TRunner.Create(arguments: array of String);
begin
  if Length(arguments) = 4 then begin
    FRemoteProcessClient := TRemoteProcessClient.Create(arguments[1], StrToInt(arguments[2]));
    FToken := arguments[3];
  end else begin
    FRemoteProcessClient := TRemoteProcessClient.Create('127.0.0.1', 31001);
    FToken := '0000000000000000';
  end;
end;

procedure TRunner.Run;
var
  teamSize: LongInt;
  wizardIndex: LongInt;
  strategyIndex: LongInt;
  strategies: array of TStrategy;
  playerWizard: TWizard;
  playerWizards: TWizardArray;
  playerContext: TPlayerContext;
  move: TMove;
  moves: TMoveArray;
  game: TGame;

begin
  FRemoteProcessClient.WriteTokenMessage(FToken);
  FRemoteProcessClient.WriteProtocolVersionMessage;
  teamSize := FRemoteProcessClient.ReadTeamSizeMessage;
  game := FRemoteProcessClient.ReadGameContextMessage;

  SetLength(strategies, teamSize);

  for strategyIndex := 0 to teamSize - 1 do begin
    strategies[strategyIndex] := TMyStrategy.Create;
  end;

  while true do begin
    playerContext := FRemoteProcessClient.ReadPlayerContextMessage;
    if playerContext = nil then begin
      break;
    end;

    playerWizards := playerContext.Wizards;
    if Length(playerWizards) <> teamSize then begin
      break;
    end;

    SetLength(moves, teamSize);

    for wizardIndex := 0 to teamSize - 1 do begin
      playerWizard := playerWizards[wizardIndex];

      move := TMove.Create;
      moves[wizardIndex] := move;
      strategies[wizardIndex].Move(playerWizard, playerContext.World, game, move);
    end;

    FRemoteProcessClient.WriteMovesMessage(moves);

    for wizardIndex := 0 to teamSize - 1 do begin
      moves[wizardIndex].Free;
    end;

    SetLength(moves, 0);

    playerContext.Free;
  end;

  for strategyIndex := 0 to teamSize - 1 do begin
    strategies[strategyIndex].Free;
  end;

  SetLength(strategies, 0);
end;

destructor TRunner.Destroy;
begin
  FRemoteProcessClient.Free;

  inherited;
end;

var
  i: LongInt;
  runner: TRunner;
  arguments: array of String;

begin
  try
    SetLength(arguments, paramCount + 1);

    for i := 0 to paramCount do begin
      arguments[i] := ParamStr(i);
    end;

    runner := TRunner.Create(arguments);
    runner.Run;
    runner.Free;

    SetLength(arguments, 0);
  except
    on E: Exception do begin
      WriteLn('Exception occured: type=', E.ClassName, ', message="', E.Message, '".');
      HALT(239);
    end;
  end;
end.
