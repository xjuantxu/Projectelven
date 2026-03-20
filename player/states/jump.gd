@icon ("res://player/states/state.svg")
class_name PlayerStateJump extends PlayerState

@export var jump_velocity : float = 450.0
var started_falling : bool = false


#¿Qué pasa si se inicia este estado?
func _init() -> void:
	pass


#¿Qué pasa si se entra a este estado?
func enter() -> void:
	player.animation_player.play("jump")
	player.animation_player.pause()
	#player.add_debug_jump_indicator( Color.LIME_GREEN )
	started_falling = false
	player.velocity.y = -jump_velocity

	#Comprobar si este es un salto de buffer
	#Si lo es, controla el salto de forma retroactiva
	if player.previous_state == fall and not Input.is_action_pressed("jump"):
		await get_tree().process_frame
		player.position.y *=0.5
		player.change_state(fall)
		pass
		
	pass


#¿Qué pasa si salimos de este estado?
func exit() -> void:
	#player.add_debug_jump_indicator( Color.YELLOW )
	pass


#¿Qué pasa si se pulsa un input?
func handle_input( _event : InputEvent ) -> PlayerState :
	if _event.is_action_released("jump") :
		player.velocity.y *= 0.5
		return fall
	return next_state


#¿Que pasa en cada tick de proceso en este estado?
func process (_delta: float) -> PlayerState:
	set_jump_frame()
	return next_state


#¿Qué pasa en cada tick de proceso físico en este estado? 
func physics_process (_delta: float) -> PlayerState:
	player.velocity.x = player.direction.x * player.move_speed

	if player.velocity.y >= 0:
		started_falling = true

	if started_falling:
		return fall

	return null



func set_jump_frame() -> void:
	var frame : float = remap(player.velocity.y, -jump_velocity, 0.0, 0.0, 0.5 )
	player.animation_player.seek(frame, true)
	pass