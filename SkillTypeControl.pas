unit SkillTypeControl;

interface

uses
  TypeControl;

const
  _SKILL_UNKNOWN_                          : LongInt = -1;
  SKILL_RANGE_BONUS_PASSIVE_1              : LongInt = 0;
  SKILL_RANGE_BONUS_AURA_1                 : LongInt = 1;
  SKILL_RANGE_BONUS_PASSIVE_2              : LongInt = 2;
  SKILL_RANGE_BONUS_AURA_2                 : LongInt = 3;
  SKILL_ADVANCED_MAGIC_MISSILE             : LongInt = 4;
  SKILL_MAGICAL_DAMAGE_BONUS_PASSIVE_1     : LongInt = 5;
  SKILL_MAGICAL_DAMAGE_BONUS_AURA_1        : LongInt = 6;
  SKILL_MAGICAL_DAMAGE_BONUS_PASSIVE_2     : LongInt = 7;
  SKILL_MAGICAL_DAMAGE_BONUS_AURA_2        : LongInt = 8;
  SKILL_FROST_BOLT                         : LongInt = 9;
  SKILL_STAFF_DAMAGE_BONUS_PASSIVE_1       : LongInt = 10;
  SKILL_STAFF_DAMAGE_BONUS_AURA_1          : LongInt = 11;
  SKILL_STAFF_DAMAGE_BONUS_PASSIVE_2       : LongInt = 12;
  SKILL_STAFF_DAMAGE_BONUS_AURA_2          : LongInt = 13;
  SKILL_FIREBALL                           : LongInt = 14;
  SKILL_MOVEMENT_BONUS_FACTOR_PASSIVE_1    : LongInt = 15;
  SKILL_MOVEMENT_BONUS_FACTOR_AURA_1       : LongInt = 16;
  SKILL_MOVEMENT_BONUS_FACTOR_PASSIVE_2    : LongInt = 17;
  SKILL_MOVEMENT_BONUS_FACTOR_AURA_2       : LongInt = 18;
  SKILL_HASTE                              : LongInt = 19;
  SKILL_MAGICAL_DAMAGE_ABSORPTION_PASSIVE_1: LongInt = 20;
  SKILL_MAGICAL_DAMAGE_ABSORPTION_AURA_1   : LongInt = 21;
  SKILL_MAGICAL_DAMAGE_ABSORPTION_PASSIVE_2: LongInt = 22;
  SKILL_MAGICAL_DAMAGE_ABSORPTION_AURA_2   : LongInt = 23;
  SKILL_SHIELD                             : LongInt = 24;
  _SKILL_COUNT_                            : LongInt = 25;

type
  TSkillType = LongInt;
  TSkillTypeArray = TLongIntArray;
  TSkillTypeArray2D = TLongIntArray2D;
  TSkillTypeArray3D = TLongIntArray3D;
  TSkillTypeArray4D = TLongIntArray4D;
  TSkillTypeArray5D = TLongIntArray5D;

implementation

end.
