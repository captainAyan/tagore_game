extends CharacterBody2D


const SPEED = 800.0
const JUMP_VELOCITY = -1000.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var last_character_face_direction = 1 # 1 is right and -1 is left

func _process(delta):
	if velocity.x != 0:
		$AnimationPlayer.play("walk_anim", -1, 5, false);
	else:
		$AnimationPlayer.play("idle_anim");

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	# change character sprite direction
	if direction != 0 && last_character_face_direction != direction:
		last_character_face_direction = direction
		$FullBody.scale.x = -$FullBody.scale.x # the flip

	move_and_slide()
