unit LaneTypeControl;

interface

uses
  TypeControl;

const
  _LANE_UNKNOWN_: LongInt = -1;
  LANE_TOP      : LongInt = 0;
  LANE_MIDDLE   : LongInt = 1;
  LANE_BOTTOM   : LongInt = 2;
  _LANE_COUNT_  : LongInt = 3;

type
  TLaneType = LongInt;
  TLaneTypeArray = TLongIntArray;
  TLaneTypeArray2D = TLongIntArray2D;
  TLaneTypeArray3D = TLongIntArray3D;
  TLaneTypeArray4D = TLongIntArray4D;
  TLaneTypeArray5D = TLongIntArray5D;

implementation

end.
