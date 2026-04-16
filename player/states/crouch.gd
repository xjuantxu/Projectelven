@icon ("res://player/states/state.svg")
class_name PlayerStateCrouch extends PlayerState

@export var deceleration_rate : float = 10
var forced_crouch_timer : float = 0.0
var exit_state : PlayerState = null
var playing_exit_animation : bool = false

#¿Qué pasa si se inicia este estado?
func _init() -> void:
	pass


#¿Qué pasa si se entra a este estado?
func enter() -> void:
	player.animation_player.play("crouch")
	player.collision_stand.disabled = true
	player.collision_crouch.disabled = false
	exit_state = null
	playing_exit_animation = false
	pass


#¿Qué pasa si salimos de este estado?
func exit() -> void:
	player.collision_stand.disabled = false
	player.collision_crouch.disabled = true
	exit_state = null
	playing_exit_animation = false
	pass


#¿Qué pasa si se pulsa un input?
func handle_input( _event : InputEvent ) -> PlayerState:
	if playing_exit_animation:
		return next_state

	if _event.is_action_pressed("jump"):
		player.one_way_platform_shapecast.force_shapecast_update()
		if player.one_way_platform_shapecast.is_colliding() == true:
			player.position.y += 4
			return fall
		return jump
	return null


#¿Que pasa en cada tick de proceso en este estado?
func process (_delta: float) -> PlayerState:
	if playing_exit_animation:
		if player.animation_player.current_animation != "crouch":
			return finish_exit_animation()
		if player.animation_player.current_animation_position <= 0.0:
			return finish_exit_animation()
		return next_state

	if forced_crouch_timer > 0.0:
		forced_crouch_timer -= _delta
		if forced_crouch_timer > 0.0:
			return next_state
		if player.direction.x != 0:
			return start_exit_animation(run)
		return start_exit_animation(idle)

	if player.direction.y <= 0.5:
		if player.direction.x != 0:
			return start_exit_animation(run)
		return start_exit_animation(idle)
	return null


#¿Qué pasa en cada tick de proceso físico en este estado? 
func physics_process (_delta: float) -> PlayerState:
	player.velocity.x -= player.velocity.x * deceleration_rate * _delta
	if player.is_on_floor() == false:
		playing_exit_animation = false
		exit_state = null
		return fall
	return next_state


func start_forced_crouch(duration : float) -> void:
	forced_crouch_timer = max(duration, 0.0)


func start_exit_animation(target_state : PlayerState) -> PlayerState:
	exit_state = target_state
	playing_exit_animation = true
	player.animation_player.play_backwards("crouch")
	return next_state


func finish_exit_animation() -> PlayerState:
	playing_exit_animation = false
	var target_state := exit_state
	exit_state = null
	return target_state
