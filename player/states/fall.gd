@icon ("res://player/states/state.svg")
class_name PlayerStateFall extends PlayerState


#¿Qué pasa si se inicia este estado?
func _init() -> void:
	pass


#¿Qué pasa si se entra a este estado?
func enter() -> void:
	#reproducir animacion
	pass


#¿Qué pasa si salimos de este estado?
func exit() -> void:
	pass


#¿Qué pasa si se pulsa un input?
func handle_input( _event : InputEvent ) -> PlayerState:
	return next_state


#¿Que pasa en cada tick de proceso en este estado?
func process (_delta: float) -> PlayerState:
	if player.is_on_floor():
		if player.direction.x == 0:
			return idle
		return run
	return next_state


#¿Qué pasa en cada tick de proceso físico en este estado? 
func physics_process (_delta: float) -> PlayerState:
	if player.is_on_floor():
		return idle
	player.velocity.x = player.direction.x * player.move_speed

	return next_state
