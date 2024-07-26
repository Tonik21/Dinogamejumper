# EndingScreen.gd
extends Control

var result_label: Label
var restart_button: Button

signal restart_game

func _ready():
	result_label = get_node("VBoxContainer/ResultLabel") as Label
	restart_button = get_node("VBoxContainer/RestartButton") as Button
	
	if result_label == null:
		push_error("ResultLabel node not found")
	if restart_button == null:
		push_error("RestartButton node not found")
		
func show_result(win: bool):
	if result_label:
		if win:
			result_label.text = "Vítězství!\nDinosaur snědl celý asteroid!"
		else:
			result_label.text = "Konec hry!\nAsteroid dopadl na Zemi."
	show()

func _on_RestartButton_pressed():
	emit_signal("restart_game")
	hide()

# Scene structure (EndingScreen.tscn):
# 
# Control (root node)
# |
# +-- VBoxContainer
#     |
#     +-- ResultLabel (Label)
#     |
#     +-- RestartButton (Button)

# Node setup:
# Control (root):
# - Attach this script
# - Layout -> Anchors Preset: Full Rect
# - Control -> Mouse -> Filter: Stop
#
# VBoxContainer:
# - Layout -> Anchors Preset: Center
# - Container -> Alignment: Center
#
# ResultLabel:
# - Text: [leave empty, will be set by script]
# - Align: Center
# - Valign: Center
#
# RestartButton:
# - Text: "Hrát znovu"
