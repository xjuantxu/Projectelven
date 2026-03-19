class_name Player extends CharacterBody2D


#region /// variables de la máquina de estados
var states : Array[ PlayerState ]
var current_state : PlayerState : 
	get : return states.front()
var previous_state : PlayerState :
	get : return states[ 1 ]
#endregion

#region /// variables estándar
var direction : Vector2 = Vector2 (0,0)
var gravity : float = 9.8
#endregion



func _ready() -> void:
	initialize_states()	
	pass



func _unhandled_input(event: InputEvent) -> void:
	change_state( current_state.handle_input( event ) )
	pass





func _process( _delta: float) -> void:
	update_direction()
	change_state( current_state.process( _delta ) )
	pass


func _physics_process( _delta: float) -> void:
	velocity.y += gravity * _delta
	change_state( current_state.physics_process( _delta ) )
	move_and_slide()
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

	#iniciar cada estado
	for state in states:
		state._init()

	#configurar el estado inicial
	change_state ( current_state )
	current_state.enter()
	pass


func change_state( new_state : PlayerState ) -> void:
	if new_state == null:
		return
	elif new_state == current_state:
		return
	
	if current_state:
		current_state.exit()

	states.push_front( new_state )
	current_state.enter()
	states.resize( 3 )
	pass



func update_direction() -> void:

	#var prev_direction : Vector2 = direction
	direction = Input.get_vector( "ui_left", "ui_right", "ui_up", "ui_down" )

	#más cosas que hacer
	pass
