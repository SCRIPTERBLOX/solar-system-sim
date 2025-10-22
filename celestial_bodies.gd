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


func planet_attraction(mass1: float, pos1: Vector3, mass2: float, pos2: Vector3) -> Vector3:
	var dist = pos1 - pos2
	var mass_diff = mass1 - mass2 + 1
	print(mass_diff)
	
	return ((dist * mass_diff) / 100) * -1


func handle_planets():
	for i in get_child_count():
		var planet = get_child(i)
		
		var vel = Vector3(0, 0, 0)
		
		# Calculate velocities
		for ii in get_child_count():
			if not i == ii:
				var planet2 = get_child(ii)
				
				# Calculate velocity
				vel += planet_attraction(
					planet.get_meta("Mass"), planet.position,
					planet2.get_meta("Mass"), planet2.position
				)
		
		# Apply velocity
		planet.position += vel


func _process(delta: float) -> void:
	# Apply velocities to all planets
	handle_planets()

func _ready() -> void:
	# Initial planets
	add_planet(Vector3(1, 1, 1), Vector3(0, 0, 0), 50, Color(0, 0, 255))
	add_planet(Vector3(1, 1, 1), Vector3(0, 2, 0), 50, Color(255, 0, 0))
