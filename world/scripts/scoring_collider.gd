@tool
extends Area3D

func _on_body_entered(body):
	if body != self:
		if body.name == "Marble":
			self.monitorable = false
			self.monitoring = false
			GameManager.passed_through_tracks = GameManager.passed_through_tracks + 1
