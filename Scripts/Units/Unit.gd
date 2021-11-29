extends Spatial

signal ap_updated(new_ap)
signal aura_updated(new_aura)
signal charges_updated(new_charges)
signal health_updated(new_health)
var aura_pool:		float = 4300
var aura_max:		float = 4300
var health:			int = 1
var max_health:		int = 500

var action_points:	int = 0
var action_charges:	int = 0
var max_actions:	int = 2

# Called when the node enters the scene tree for the first time.
func _ready():
	emit_signal("ap_updated", action_points)
	emit_signal("aura_updated", aura_pool)
	emit_signal("charges_updated", action_charges)
	emit_signal("health_updated", health)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (action_charges >= max_actions && health >= max_health) || aura_pool < 100:
		aura_pool+=25*delta
		if aura_pool > aura_max:
			aura_pool = aura_max
	elif health < max_health:
		health += 1
		aura_pool -= 3
		emit_signal("health_updated", health)
	elif action_charges < max_actions:
		if action_points >= 100:
			action_points = 0
			action_charges += 1
			emit_signal("charges_updated", action_charges)
		else:
			action_points+=1
			aura_pool -= 2
		emit_signal("ap_updated", action_points)
	emit_signal("aura_updated", aura_pool)
