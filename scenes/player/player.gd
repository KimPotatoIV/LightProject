extends CharacterBody2D

##################################################
enum STATE {
	IDLE,
	WALK }

enum DIRECTION {
	LEFT,
	RIGHT }

const MOVING_SPEED = 200.0

var state: STATE = STATE.IDLE
var direction: DIRECTION = DIRECTION.RIGHT

var anim_sprite_node: AnimatedSprite2D

##################################################
func _ready() -> void:
	anim_sprite_node = $AnimatedSprite2D

##################################################
func _physics_process(delta: float) -> void:
	var direction_x: float = Input.get_axis("ui_left", "ui_right")
	if direction_x:
		velocity.x = direction_x * MOVING_SPEED
		state = STATE.WALK
		if direction_x > 0:
			direction = DIRECTION.LEFT
		else:
			direction = DIRECTION.RIGHT
	else:
		velocity.x = move_toward(velocity.x, 0, MOVING_SPEED)

	var direction_y: float = Input.get_axis("ui_up", "ui_down")
	if direction_y:
		velocity.y = direction_y * MOVING_SPEED
		state = STATE.WALK
	else:
		velocity.y = move_toward(velocity.y, 0, MOVING_SPEED)
	
	if direction_x == 0 and direction_y == 0:
		state = STATE.IDLE

	set_state(state)
	move_and_slide()

##################################################
func set_state(state_value: STATE) -> void:
	match state_value:
		STATE.IDLE:
			anim_sprite_node.play("idle")
		STATE.WALK:
			anim_sprite_node.play("walk")
	
	if direction == DIRECTION.LEFT:
		anim_sprite_node.flip_h = false
	else:
		anim_sprite_node.flip_h = true
