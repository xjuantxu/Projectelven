@icon ("res://player/states/state.svg")
class_name PlayerStateIdle extends PlayerState



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
	if _event.is_action_pressed("jump"):
		return jump
	if player.direction.x != 0:
		return run
	return null


#¿Que pasa en cada tick de proceso en este estado?
func process (_delta: float) -> PlayerState:
	if player.direction.x != 0:
		return run
	return null


#¿Qué pasa en cada tick de proceso físico en este estado? 
func physics_process (_delta: float) -> PlayerState:
	player.velocity.x = 0
	if player.is_on_floor() == false:
		return fall
	return next_state
