extends CanvasLayer

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
onready var block =  get_node("Block")
onready var attack = get_node("Attack")
onready var fly = get_node("Fly")

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _process(delta):
	if GameManager.game_over:
		block.visible = false
		attack.visible = false
		fly.visible = false

func _on_Boss_game_state_changed():
	block.playStateUpdateAnim()
	attack.playStateUpdateAnim()
	fly.playStateUpdateAnim()
	pass # replace with function body
