extends Node

@onready var money_lable: Label = %money_lable

var max_left = 2
var max_right = 2

var house_cost = 100
var house_cost_sell = 100 

var farm_cost = 200
var farm_cost_sell = 200

var mine_cost = 300
var mine_cost_sell = 300

var money = 100

func _ready() -> void:
	pass

func update_lables():
	money_lable.update_text()
