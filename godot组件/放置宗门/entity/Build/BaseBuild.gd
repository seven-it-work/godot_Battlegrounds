extends Node
class_name BaseBuild

@export var name_str:String=""
@export var lv:int=1

@export var can_build:bool=false
@export var build_materials:Dictionary[Enums.Materials,int]={}

@export var can_update:bool=false
@export var update_materials:Dictionary[Enums.Materials,int]={}
@export var 所在地人员:Array=[]
