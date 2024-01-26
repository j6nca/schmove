extends CharacterBody2D


const BASE_SPEED = 100.0
const BASE_JUMP_VELOCITY = -200.0
const BASE_SLIME_CHARGES = BASE_MAX_CHARGES
const BASE_OUTLINE = Vector4(0.2, 0.2, 0.2, 1.0)
const BASE_MAX_CHARGES = 102
const BASE_LIVE_CHARGES = 1
const BASE_THROW_VELOCITY = Vector2(10,0)

@onready var animation_tree : AnimationTree = $AnimationTree
@onready var sprite : Sprite2D = $Sprite2D
@onready var shader = preload("res://assets/shaders/entity.gdshader")
@onready var character : CharacterBody2D = $Player
@onready var Satchel = preload("res://scenes/satchel.tscn")
@onready var explosion_timer : Timer = $Explosion_Timer
@onready var recharge_timer : Timer = $Recharge_Timer
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var last_direction = 1
var speed = BASE_SPEED
var jump_velocity = BASE_JUMP_VELOCITY
var slime_charges = BASE_SLIME_CHARGES
var max_charges = BASE_MAX_CHARGES
var base_live_charges = BASE_LIVE_CHARGES
var available_charges = BASE_MAX_CHARGES
var explosion = Vector2.ZERO

func set_explosion(force: Vector2):
	explosion = force
	explosion_timer.wait_time = 0.1
	explosion_timer.start()

func _ready():
	add_to_group("player")
	# Set collision data
	set_collision_layer_value(2, true)
	set_collision_mask_value(1, true)

	# Set shaders
	sprite.material = ShaderMaterial.new()
	sprite.material.shader = shader
	sprite.material.set_shader_parameter("color", BASE_OUTLINE)
	# Start recharge timer
	recharge_timer.wait_time = 2
	recharge_timer.start()
	
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
		
func _physics_process(delta):
	if Input.is_action_just_pressed("throw"):
		satchel()
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y += jump_velocity

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input = Input.get_axis("move_left", "move_right")
	var direction = sign((get_global_mouse_position() - global_position).x)
	last_direction = direction
	velocity.x = input * speed
	velocity += explosion
	
	move_and_slide()

func satchel():
	# Check if satchel exists, if so, then follow up action is to detonate, else throw satchel
	# TODO: have an area of effect for satchel vector
	# TODO: only move player if satchel can see player (ray cast?)
	var satchels = get_tree().get_nodes_in_group("satchels")
	if satchels.size() + 1 > base_live_charges:
		print("satchel exists")
		for satchel in satchels:
			satchel.detonate()
	elif available_charges > 0:
		print("throwing slime...")
		var satchel = Satchel.instantiate()
		get_parent().add_child(satchel)
		var throw_direction = (get_global_mouse_position() - global_position).normalized()
		print(throw_direction)
		satchel.position = Vector2(position.x, position.y)
		satchel.velocity = satchel.BASE_THROW_SPEED * throw_direction + BASE_THROW_VELOCITY
		available_charges -= 1
	
func _on_explosion_timer_timeout():
	explosion = Vector2.ZERO

func _on_recharge_timer_timeout():
	if available_charges < max_charges:
		print("Charge refilled")
		available_charges += 1
	else:
		print("Charge full")
	recharge_timer.start() # Replace with function body.
