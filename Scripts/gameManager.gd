extends Node

@onready var money_lable: Label = %money_lable

var max_left = 2
var max_right = 2

#base cost for first grass on each side
var grass_cut_cost = 500

var house_cost = 100
var farm_cost = 200
var mine_cost = 300
var tower_cost = 300

var money = 1000000

var roundState = CEnums.ERoundState.Invasion

func update_lables():
	money_lable.update_text()
