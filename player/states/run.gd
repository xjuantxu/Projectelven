@icon ("res://player/states/state.svg")
class_name PlayerStateRun extends PlayerState


#¿Qué pasa si se inicia este estado?
func _init() -> void:
	pass


#¿Qué pasa si se entra a este estado?
func enter() -> void:
	player.animation_player.play("run")
	pass


#¿Qué pasa si salimos de este estado?
func exit() -> void:
	pass


#¿Qué pasa si se pulsa un input?
func handle_input( _event : InputEvent ) -> PlayerState:
	if _event.is_action_pressed("jump"):
		return jump
	return next_state


#¿Que pasa en cada tick de proceso en este estado?
func process (_delta: float) -> PlayerState:
	if player.direction.x == 0:
		return idle
	elif player.direction.y > 0.5:
		return crouch
	return next_state


#¿Qué pasa en cada tick de proceso físico en este estado? 
func physics_process (_delta: float) -> PlayerState:
	player.velocity.x = player.direction.x * player.move_speed
	if player.is_on_floor() == false:
		return fall
	return next_state
