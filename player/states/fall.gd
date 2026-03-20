@icon ("res://player/states/state.svg")
class_name PlayerStateFall extends PlayerState

# region /// variables de este estado

@export var fall_gravity_multiplier : float = 1.165
@export var coyote_time : float = 0.125
@export var jump_buffer_time : float = 0.2

var coyote_timer : float = 0.0
var buffer_timer : float = 0.0
#endregion

#¿Qué pasa si se inicia este estado?
func _init() -> void:
	pass


#¿Qué pasa si se entra a este estado?
func enter() -> void:
	#reproducir animacion
	player.gravity_multiplier = fall_gravity_multiplier
	if player.previous_state == jump:
		coyote_timer = 0
	else:
		coyote_timer = coyote_time
	pass


#¿Qué pasa si salimos de este estado?
func exit() -> void:
	player.gravity_multiplier = 1.0
	pass


#¿Qué pasa si se pulsa un input?
func handle_input( _event : InputEvent ) -> PlayerState:
	if _event.is_action_pressed("jump"):
		if coyote_timer > 0.0:
			return jump
		else:
			buffer_timer = jump_buffer_time
	return next_state


#¿Que pasa en cada tick de proceso en este estado?
func process (_delta: float) -> PlayerState:
	coyote_timer -= _delta
	buffer_timer -= _delta
	return next_state


#¿Qué pasa en cada tick de proceso físico en este estado? 
func physics_process (_delta: float) -> PlayerState:
	if player.is_on_floor():
		if player.direction.x == 0:
			player.add_debug_jump_indicator()
			if buffer_timer > 0.0:
				return jump
			return idle
		player.add_debug_jump_indicator( Color.CYAN )
		return run
	player.velocity.x = player.direction.x * player.move_speed

	return next_state
