@icon ("res://player/states/state.svg")
class_name PlayerStateCrouch extends PlayerState

@export var deceleration_rate : float = 10

#¿Qué pasa si se inicia este estado?
func _init() -> void:
	pass


#¿Qué pasa si se entra a este estado?
func enter() -> void:
	player.animation_player.play("crouch")
	player.collision_stand.disabled = true
	player.collision_crouch.disabled = false
	pass


#¿Qué pasa si salimos de este estado?
func exit() -> void:
	player.collision_stand.disabled = false
	player.collision_crouch.disabled = true
	pass


#¿Qué pasa si se pulsa un input?
func handle_input( _event : InputEvent ) -> PlayerState:
	if _event.is_action_pressed("jump"):
		player.one_way_platform_shapecast.force_shapecast_update()
		if player.one_way_platform_shapecast.is_colliding() == true:
			player.position.y += 4
			return fall
		return jump
	return null


#¿Que pasa en cada tick de proceso en este estado?
func process (_delta: float) -> PlayerState:
	if player.direction.y <= 0.5:
		return idle
	return null


#¿Qué pasa en cada tick de proceso físico en este estado? 
func physics_process (_delta: float) -> PlayerState:
	player.velocity.x -= player.velocity.x * deceleration_rate * _delta
	if player.is_on_floor() == false:
		return fall
	return next_state
