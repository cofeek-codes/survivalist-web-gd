extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var animation_player: AnimatedSprite2D = get_node("AnimationPlayer")
var is_moving = false
var is_attacking = false

func _physics_process(delta):
	if velocity.y < 0: # falling
		animation_player.play('fall')		
	if !is_moving && !is_attacking && is_on_floor():
		animation_player.play('idle')
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	# Handle Attack.
	if Input.is_action_just_pressed('attack'):
		print('attack pressed')
		is_attacking = true
#		TODO: attack animation frames
	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		print('jump pressed')
		animation_player.play("jump")
		print(animation_player.is_playing())
		
		print(animation_player.get_animation())		
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		is_moving = true
		velocity.x = direction * SPEED
		animation_player.play("move")
		if velocity.x < 0:
			animation_player.flip_h = true
		else:
			animation_player.flip_h = false
		
	
	else:
		is_moving = false 
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
			

	move_and_slide()
