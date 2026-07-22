class_name Gun extends Node3D

@onready var animation: AnimationPlayer = $AnimationPlayer
const BULLET_SCENE := preload("res://scenes/bullet.tscn")
@onready var muzzle: Marker3D = $Muzzle


func shoot() -> void:
    animation.stop()
    animation.play("shoot")
    
    var bullet := BULLET_SCENE.instantiate() as Node3D
    get_tree().current_scene.add_child(bullet)
    bullet.global_transform = muzzle.global_transform
