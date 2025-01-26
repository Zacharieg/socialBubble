extends HBoxContainer
class_name Upgrades

signal upgrade(modifier)

@onready var available_modifiers = [
	ShieldSizeModifier.new(1.25),
	ShieldSizeModifier.new(1.1),
	ShieldSpeedModifier.new(1.1),
	ShieldSpeedModifier.new(1.25),
	HealModifier.new(),
	CapacityCooldownModifier.new(.9),
	CapacityCooldownModifier.new(.8),
	CapacityDurationModifier.new(1.1),
	CapacityDurationModifier.new(1.25),
	ShieldAddedModifier.new(1),
]

var market_upgrades : Array[Modifier] = []

@onready var buttons : Array[Button] = [$upgrade_1, $upgrade_2]

func _ready() -> void:
	for i in range(len(buttons)):
		buttons[i].connect("button_down", func(): choose_upgrade(i))

func setup_upgrades():
	market_upgrades = []
	for button in buttons:
		var modifier : Modifier = available_modifiers[randi()%len(available_modifiers)]
		while market_upgrades.has(modifier):
			modifier = available_modifiers[randi()%len(available_modifiers)]
		market_upgrades.append(modifier)
		button.text = modifier.name()
	buttons[0].grab_focus()
	print(market_upgrades)

func choose_upgrade(nb_upgrade):
	print("choose upgrade")
	emit_signal("upgrade", market_upgrades[nb_upgrade])

class Modifier:
	func name() : return "Modifier"
	
	func modify(_character : Character):
		pass

class ShieldSizeModifier extends Modifier:
	var multiplier = 1
	
	func _init(_multiplier) -> void:
		multiplier = _multiplier
	
	func name() : return "Shield size x " + str(multiplier)
	
	func modify(character : Character):
		character.shield.shield_size *= multiplier
		character.shield.queue_redraw()

class ShieldSpeedModifier extends Modifier:
	var multiplier = 1
	
	func _init(_multiplier) -> void:
		multiplier = _multiplier
	
	func name() : return "Shield speed x " + str(multiplier)
	
	func modify(character : Character):
		character.shield.shield_speed *= multiplier

class HealModifier extends Modifier:
	func name() : return "Heal 1"
	
	func modify(charac : Character):
		charac.life += 1
		charac.emit_signal("healed")

class CapacityCooldownModifier extends Modifier:
	var multiplier = 1
	
	func _init(_mult) -> void:
		multiplier = _mult
	
	func name() : return "Coolddown x " + str(multiplier)
	
	func modify(charac : Character):
		charac.capacity.capacity_base_cooldown *= multiplier

class CapacityDurationModifier extends Modifier:
	var multiplier = 1
	
	func _init(_mult) -> void:
		multiplier = _mult
	
	func name() : return "Capacity duration x " + str(multiplier)
	
	func modify(charac : Character):
		charac.capacity.capacity_base_duration *= multiplier

class ShieldAddedModifier extends Modifier:
	var added = 1
	
	func _init(_add) -> void:
		added = _add
		
	func name() : return "Add " + str(added) + " more shields"
	
	func modify(charac : Character):
		if charac.capacity is MoreShield:
			charac.capacity.add_shield_count += added
