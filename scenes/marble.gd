extends RigidBody3D

var boost := false
var boost_factor := 2.0  # The factor by which the speed is increased
var max_speed_boosted := 1.0  # Maximum speed limit when boosted
var max_speed_normal := 2.0  # Maximum speed limit under normal conditions

func _integrate_forces(state):
	var max_speed = max_speed_boosted if boost else max_speed_normal
	var new_velocity = state.linear_velocity

	if boost:
		# Scale the current velocity to increase speed
		new_velocity *= boost_factor

	# Limit the speed to the max speed
	if new_velocity.length() > max_speed:
		new_velocity = new_velocity.normalized() * max_speed

	state.linear_velocity = new_velocity



		
