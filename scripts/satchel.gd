extends RigidBody2D

@onready var detonate_timer : Timer = $Self_Detonate_Timer
@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var sprite : Sprite2D = $Sprite2D
@onready var shader = preload("res://assets/shaders/entity.gdshader")
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity") * 0.5
var velocity = Vector2.ZERO
var explosion_strength = BASE_EXPLOSION_STRENGTH

const BASE_THROW_SPEED = 150
const BASE_TIME_TO_DETONATE = 3
const BASE_OUTLINE = Vector4(0.2, 0.2, 0.2, 1.0)
const BASE_EXPLOSION_STRENGTH = 50.0

func _ready():
	# Add satchel instances to a group - there should only be one at a time
	add_to_group("satchels")
	# Set base constants
	velocity = BASE_THROW_SPEED * velocity
	# Set collision data
	set_collision_layer_value(1, true)
	set_collision_mask_value(1, true)
	# Set animation
	animation_player.play("idle")
	# Set timer
	detonate_timer.wait_time = BASE_TIME_TO_DETONATE
	detonate_timer.start()
	# Set shaders
	sprite.material = ShaderMaterial.new()
	sprite.material.shader = shader
	sprite.material.set_shader_parameter("color", BASE_OUTLINE)

func _physics_process(delta):
	velocity.y += gravity * delta
	move_and_collide(velocity * delta)
	
func detonate():
	#detonate logic here
	remove_from_group("satchels")
	var player_pos = get_parent().get_node("Player").global_position
	var explosion_vector = (player_pos - global_position).normalized()
	explosion_vector = Vector2(explosion_vector.x * 10, explosion_vector.y)
	# print("satchel: ", global_position)
	# print("player: ", player_pos)
	#print("resulting", explosion_vector)
	get_parent().get_node("Player").set_explosion(explosion_vector * explosion_strength)
	animation_player.play("explosion")
	await animation_player.animation_finished
	queue_free()

func _on_self_detonate_timer_timeout():
	detonate()
