extends CharacterBody2D

const SPEED := 400.0

@onready var pickup_area: Area2D = $PickupArea
@onready var held_berry: Sprite2D = $HeldBerry
@onready var berry_count_display: Label = $CanvasLayer/BerryCountDisplay

var berry_count := 0


func _ready() -> void:
	_update_berry_display()


func _physics_process(_delta: float) -> void:
	var input_direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = input_direction * SPEED
	move_and_slide()
	_deliver_if_in_basket()


func _on_pickup_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("Basket"):
		_deliver_berry()
		return

	_pick_up_berry(area)


func _deliver_if_in_basket() -> void:
	if not held_berry.visible:
		return

	for area in pickup_area.get_overlapping_areas():
		if area.is_in_group("Basket"):
			_deliver_berry()
			return


func _pick_up_berry(area: Area2D) -> void:
	if held_berry.visible or not area.is_in_group("Berry"):
		return

	area.queue_free()
	held_berry.visible = true


func _deliver_berry() -> void:
	if not held_berry.visible:
		return

	held_berry.visible = false
	berry_count += 1
	_update_berry_display()


func _update_berry_display() -> void:
	berry_count_display.text = "Berry: %d" % berry_count
