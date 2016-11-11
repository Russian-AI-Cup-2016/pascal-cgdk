unit ProjectileTypeControl;

interface

uses
  TypeControl;

const
  _PROJECTILE_UNKNOWN_    : LongInt = -1;
  PROJECTILE_MAGIC_MISSILE: LongInt = 0;
  PROJECTILE_FROST_BOLT   : LongInt = 1;
  PROJECTILE_FIREBALL     : LongInt = 2;
  PROJECTILE_DART         : LongInt = 3;
  _PROJECTILE_COUNT_      : LongInt = 4;

type
  TProjectileType = LongInt;
  TProjectileTypeArray = TLongIntArray;
  TProjectileTypeArray2D = TLongIntArray2D;
  TProjectileTypeArray3D = TLongIntArray3D;
  TProjectileTypeArray4D = TLongIntArray4D;
  TProjectileTypeArray5D = TLongIntArray5D;

implementation

end.
