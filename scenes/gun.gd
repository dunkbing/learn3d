class_name Gun extends Node3D

@onready var animation: AnimationPlayer = $AnimationPlayer


func shoot() -> void:
    animation.stop()
    animation.play("shoot")
