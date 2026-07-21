extends CharacterBody3D


@export var speed := 5.0
@export var jump_velocity := 3
@export var mouse_sensitivity := 0.003

# Grab the camera pivot so we can rotate it for mouse-look.
@onready var camera_pivot: Node3D = $CameraPivot
@onready var gun: Gun = $Gun

func _ready() -> void:
    # Lock the mouse to the window and hide it (FPS/3rd-person style).
    Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _unhandled_input(event: InputEvent) -> void:
    if event is InputEventMouseMotion:
        # Yaw: rotate the WHOLE player left/right.
        rotate_y(-event.relative.x * mouse_sensitivity)
        # Pitch: tilt only the camera pivot up/down.
        camera_pivot.rotate_x(-event.relative.y * mouse_sensitivity)
        # Clamp pitch so you can't flip over backwards.
        camera_pivot.rotation.x = clampf(camera_pivot.rotation.x, -1.2, 0.4)

    # Press Escape to free the mouse (handy while testing).
    if event.is_action_pressed("ui_cancel"):
        Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

    if event.is_action_pressed("shoot"):
        gun.shoot()


func _physics_process(delta: float) -> void:
    # Apply gravity when in the air.
    if not is_on_floor():
            velocity += get_gravity() * delta

    # Jump.
    if Input.is_action_just_pressed("jump") and is_on_floor():
            velocity.y = jump_velocity

    # Get movement input as a 2D vector (custom WASD/arrow actions from project.godot).
    var input_dir := Input.get_vector("left", "right", "forward", "backward")
    # Convert it into a direction relative to where the player is facing.
    var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()

    if direction:
            velocity.x = direction.x * speed
            velocity.z = direction.z * speed
    else:
            # Decelerate to a stop when no input.
            velocity.x = move_toward(velocity.x, 0, speed)
            velocity.z = move_toward(velocity.z, 0, speed)

    move_and_slide()
