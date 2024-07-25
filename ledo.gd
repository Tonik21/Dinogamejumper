
func _on_body_entered(body):
	if body.has_method("set_ice_friction"):
		body.set_ice_friction()

