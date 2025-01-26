extends HBoxContainer
class_name Upgrades

signal upgrade(modifier)

@onready var available_modifiers = [
	ShieldSizeModifier.new(1.25),
	ShieldSizeModifier.new(1.1),
	ShieldSpeedModifier.new(1.1),
	ShieldSpeedModifier.new(1.25),
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
		market_upgrades.append(modifier)
		button.text = modifier.name()
	print(market_upgrades)

func choose_upgrade(nb_upgrade):
	print("choose upgrade")
	emit_signal("upgrade", market_upgrades[nb_upgrade])

class Modifier:
	func name() : return "Modifier"
	
	func modify(character : Character):
		pass

class ShieldSizeModifier extends Modifier:
	var multiplier = 1
	
	func _init(_multiplier) -> void:
		multiplier = _multiplier
	
	func name() : return "Taille du bouclier x " + str(multiplier)
	
	func modify(character : Character):
		character.shield.shield_size *= multiplier
		character.shield.queue_redraw()

class ShieldSpeedModifier extends Modifier:
	var multiplier = 1
	
	func _init(_multiplier) -> void:
		multiplier = _multiplier
	
	func name() : return "Vitesse du bouclier x " + str(multiplier)
	
	func modify(character : Character):
		character.shield.shield_speed *= multiplier
