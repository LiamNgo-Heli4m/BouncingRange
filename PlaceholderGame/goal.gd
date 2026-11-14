extends Node2D


@onready var player = $"../Player"
@onready var camera = $"../Camera2D"

@onready var victoryScreenBg = $"../VictoryMenu/ColorRect"
@onready var victoryScreenButtons = $"../VictoryMenu/Buttons"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	victoryScreenBg.position.y = -1000
	victoryScreenButtons.position.y = -1000


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player.speed = 0
		camera.apply_shake()
		
		var tween = create_tween()
		tween.tween_property(player, "position", self.position, 1)
		
		await tween.finished
		tweenVictoryScreen()
		
func tweenVictoryScreen() -> void:
	var buttontween = create_tween()
	buttontween.set_trans(Tween.TRANS_SINE)
	buttontween.set_ease(Tween.EASE_OUT)
	buttontween.tween_property(victoryScreenButtons, "position:y", 0, 1.25)
	
	var bgtween = create_tween()
	bgtween.set_trans(Tween.TRANS_SINE)
	bgtween.set_ease(Tween.EASE_OUT)
	bgtween.tween_property(victoryScreenBg, "position:y", 0, 0.75)
