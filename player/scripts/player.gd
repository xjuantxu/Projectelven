class_name Player extends CharacterBody2D

const DEBUG_JUMP_INDICATOR = preload("res://player/debug_jump_indicator.tscn")

#region /// variables onready var 
@onready var sprite : Sprite2D = $Sprite2D
@onready var collision_stand : CollisionShape2D = $CollisionStand
@onready var collision_crouch : CollisionShape2D = $CollisionCrouch
#endregion

#region /// variables exportadas
@export var move_speed : float = 100
@export var jump_velocity : float = -300
#endregion

#region /// variables de la máquina de estados
var states : Array[ PlayerState ] = []
var current_state : PlayerState
var previous_state : PlayerState
#endregion

#region /// variables estándar
var direction : Vector2 = Vector2.ZERO
var gravity : float = 980
var rotation_speed : float = 10.0
var gravity_multiplier : float = 1.0
#endregion



func _ready() -> void:
	initialize_states()	
	pass



func _input(event: InputEvent) -> void:
	if current_state == null:
		return
	change_state( current_state.handle_input( event ) )
	pass





func _process( _delta: float) -> void:
	update_direction()
	if current_state == null:
		return
	change_state( current_state.process( _delta ) )
	pass


func _physics_process( _delta: float) -> void:
	velocity.y += gravity * _delta * gravity_multiplier
	if current_state == null:
		move_and_slide()
		update_ground_rotation( _delta )
		return
	change_state( current_state.physics_process( _delta ) )
	move_and_slide()
	update_ground_rotation( _delta )
	pass


func initialize_states() -> void:
	states = []
	#recoger cada estado
	for c in $States.get_children():
		if c is PlayerState:
			states.append( c )
			c.player = self
		pass

	if states.size() == 0:
		return 

	#configurar el estado inicial
	current_state = states[0]
	current_state.enter()
	$Label.text = current_state.name
	pass


func change_state( new_state : PlayerState ) -> void:
	if new_state == null:
		return
	elif new_state == current_state:
		return
	
	if current_state:
		current_state.exit()

	previous_state = current_state
	current_state = new_state
	current_state.enter()
	$Label.text = current_state.name
	pass



func update_direction() -> void:
	#var prev_direction : Vector2 = direction
	var x_axis = Input.get_axis("left", "right")
	var y_axis = Input.get_axis("jump", "crouch")
	direction = Vector2( x_axis, y_axis )
	#más cosas que hacer
	pass


func update_ground_rotation( delta : float ) -> void:
	if current_state is PlayerStateCrouch:
		return

	if is_on_floor():
		var floor_normal := get_floor_normal()
		var target_rotation := floor_normal.angle() + deg_to_rad( 90 )
		rotation = lerp_angle( rotation, target_rotation, rotation_speed * delta )
		return

	rotation = lerp_angle( rotation, 0.0, rotation_speed * delta )

func add_debug_jump_indicator( color : Color = Color.RED) -> void:
	var d : Node2D = DEBUG_JUMP_INDICATOR.instantiate()
	get_tree().root.add_child( d )
	d.global_position = global_position
	d.modulate = color
	await get_tree().create_timer( 3.0 ).timeout
	d.queue_free()
	pass
