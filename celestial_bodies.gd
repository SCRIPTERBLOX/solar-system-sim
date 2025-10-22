extends Node


func add_planet(size: Vector3, pos: Vector3, mass: float, color: Color):
	var new_planet = MeshInstance3D.new()
	new_planet.mesh = SphereMesh.new()
	
	new_planet.scale = size
	new_planet.position = pos
	new_planet.set_meta("Mass", mass)
	
	var mat = StandardMaterial3D.new()
	mat.albedo_color = color
	new_planet.set_surface_override_material(0, mat)
	
	add_child(new_planet)


func _process(delta: float) -> void:
	# Apply velocities to all planets
	pass

func _ready() -> void:
	# Initial planets
	add_planet(Vector3(1, 1, 1), Vector3(0, 0, 0), 50, Color(0, 0, 255))
