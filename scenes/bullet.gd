extends Area3D

@export var speed := 30.0

func _physics_process(delta: float) -> void:
    position += -transform.basis.z * speed * delta
    get_tree().create_timer(3.0).timeout.connect(queue_free)


func _on_body_entered(_body: Node3D) -> void:
    # Hit something solid (wall, enemy body) — do damage here later.
    queue_free()
