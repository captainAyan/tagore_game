extends CharacterBody2D

@export var movable:bool = true

#const SPEED = 800.0
const SPEED:float = 2000.0 # DEV MODE
const JUMP_VELOCITY:float = -1000.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity:float = ProjectSettings.get_setting("physics/2d/default_gravity")

var last_character_face_direction:int = 1 # 1 is right and -1 is left

func _process(delta):
	if velocity.x != 0:
		$AnimationPlayer.play("walk_anim", -1, 5, false);
	else:
		$AnimationPlayer.play("idle_anim");

	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor() and movable:
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction:float = Input.get_axis("ui_left", "ui_right")
	if direction and movable:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	if direction > 0.5 and movable:
		last_character_face_direction = 1
		$FullBody.scale.x = 1
	elif direction < -0.5 and movable:
		last_character_face_direction = -1
		$FullBody.scale.x = -1
	else:
		$FullBody.scale.x = last_character_face_direction

	move_and_slide()
