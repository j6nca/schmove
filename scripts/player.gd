extends CharacterBody2D


const SPEED = 80.0
const JUMP_VELOCITY = -250.0

@onready var animation_tree : AnimationTree = $AnimationTree
@onready var sprite : Sprite2D = $Sprite2D
@onready var Slime = preload("res://scenes/slime.tscn")
@onready var world = get_node("/root/World")
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var last_direction = 1

func update_animation_parameters():
	if(velocity == Vector2.ZERO):
		animation_tree["parameters/conditions/idle"] = true
		animation_tree["parameters/conditions/walk"] = false
	else:
		animation_tree["parameters/conditions/idle"] = false
		animation_tree["parameters/conditions/walk"] = true	

func _process(delta):
	update_animation_parameters()
	sprite.scale.x = last_direction
	if Input.is_action_just_pressed("throw"):
		throw()
		

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input = Input.get_axis("move_left", "move_right")
	var direction = sign((get_global_mouse_position() - global_position).x)
	if direction:
		last_direction = direction
		velocity.x = input * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func throw():
	print("throwing slime...")
	var slime = Slime.instantiate()
	world.add_child(slime)
	var throw_direction = (get_global_mouse_position() - global_position).normalized()
	print(throw_direction)
	slime.position = Vector2(position.x + last_direction * 10, position.y)
	slime.velocity = slime.BASE_THROW_SPEED * throw_direction
	
