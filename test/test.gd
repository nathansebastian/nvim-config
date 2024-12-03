extends Node
var bullet_sprites: Array[Sprite3D] = []
var empty_bullet_sprites: Array[Sprite3D] = []
#var index: int = 0

func _ready():
	bullet_sprites = $"../Gun".bullet_sprites
	
func _on_gun_behaviour_gun_reload():
	empty_bullet_sprites[0].texture = load("res://textures/bullet_normal.png")
	bullet_sprites.push_front(empty_bullet_sprites[0])
	empty_bullet_sprites.remove_at(0)
	print("Full Bullet Array")
	print(bullet_sprites)
	print("Empty Bullet Array")
	print(empty_bullet_sprites)
	
	


func _on_gun_on_gun_fired():
	if(!bullet_sprites.is_empty()):
		bullet_sprites[0].texture = load("res://textures/bullet_used.png")
		empty_bullet_sprites.push_front(bullet_sprites[0])
		bullet_sprites.remove_at(0)
		print("Full Bullet Array")
		print(bullet_sprites)
		print("Empty Bullet Array")
		print(empty_bullet_sprites)

		

