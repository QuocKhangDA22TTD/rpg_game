extends Resource
class_name EnemyData

# Stats
@export var max_hp: int = 10
@export var speed: float = 50.0
@export var damage: int = 1
@export var defense: int = 0

# Combat
@export var attack_cooldown: float = 1.0
@export var attack_range: float = 20.0
@export var detection_range: float = 100.0

# Physics
@export var knockback_force: float = 100.0
@export var weight: float = 1.0

# Rewards
@export var exp_reward: int = 5
@export var gold_drop: int = 10

# Type
enum EnemyType { MELEE, RANGED, BOSS }
@export var enemy_type: EnemyType = EnemyType.MELEE

# Flags
@export var can_fly: bool = false
@export var is_boss: bool = false
