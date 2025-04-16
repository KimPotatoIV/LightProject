extends Node2D

##################################################
const FLICKER_TIME: float = 0.1
var point_light_node: PointLight2D
var flicker_timer: Timer

##################################################
func _ready() -> void:
	point_light_node = $PointLight2D
	flicker_timer = $FlickerTimer
	
	flicker_timer.wait_time = FLICKER_TIME
	flicker_timer.one_shot = true
	flicker_timer.connect("timeout", Callable(self, "_on_flicker_timer_timeout"))
	flicker_timer.start()

##################################################
func _on_flicker_timer_timeout() -> void:
	var base_energy = 1.0
	var flicker = randf_range(-0.2, 0.2)
	point_light_node.energy = base_energy + flicker
	flicker_timer.start()
