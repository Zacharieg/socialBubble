extends Capacity
class_name MoreShield

var add_shield_count := 1
var last_added : int

func apply_effect(charac : Character):
	charac.shield.shield_count += add_shield_count
	last_added = add_shield_count

func end_effect(charac : Character):
	charac.shield.shield_count -= last_added
