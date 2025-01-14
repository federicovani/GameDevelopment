class_name KeybindResource extends Resource

const MOVE_LEFT : String = "move_left"
const MOVE_RIGHT : String = "move_right"
const JUMP : String = "jump"
const CROUCH : String = "crouch"
const DASH : String = "dash"
const ATTACK : String = "attack"

@export var DEFAULT_MOVE_LEFT_KEY = InputEventKey.new()
@export var DEFAULT_MOVE_RIGHT_KEY = InputEventKey.new()
@export var DEFAULT_JUMP_KEY = InputEventKey.new()
@export var DEFAULT_CROUCH_KEY = InputEventKey.new()
@export var DEFAULT_DASH_KEY = InputEventKey.new()
@export var DEFAULT_ATTACK_KEY = InputEventKey.new()

var move_left_key = InputEventKey.new()
var move_right_key = InputEventKey.new()
var jump_key = InputEventKey.new()
var crouch_key = InputEventKey.new()
var dash_key = InputEventKey.new()
var attack_key = InputEventKey.new()
