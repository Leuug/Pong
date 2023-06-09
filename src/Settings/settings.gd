extends Control

signal return_pressed
signal main_menu_pressed

@export var title_name: String = "SETTINGS"
@export var return_name: String = "BACK"
@export var enable_main_menu: bool = false


func _ready() -> void:
	%SfxVolume.value = Game.sfx_volume
	%MusicVolume.value = Game.music_volume
	AudioServer.set_bus_volume_db(Game.sfx_bus, linear_to_db(%SfxVolume.value))
	AudioServer.set_bus_volume_db(
		Game.music_bus, linear_to_db(%MusicVolume.value)
	)

	%MainMenu.visible = enable_main_menu

	if get_window().mode == Window.MODE_WINDOWED:
		%CheckBox.button_pressed = false
	else:
		%CheckBox.button_pressed = true

	%Title.text = "[center][wave amp=40]" + title_name + "[/wave][/center]"
	%Return.text = return_name


func _on_sfx_volume_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(Game.sfx_bus, linear_to_db(%SfxVolume.value))
	Game.sfx_volume = %SfxVolume.value


func _on_music_volume_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(
		Game.music_bus, linear_to_db(%MusicVolume.value)
	)
	Game.music_volume = %MusicVolume.value


func _on_check_box_pressed() -> void:
	if get_window().mode == Window.MODE_WINDOWED:
		if OS.get_name() == "Windows":
			get_window().mode = (Window.MODE_EXCLUSIVE_FULLSCREEN)
		else:
			get_window().mode = (Window.MODE_FULLSCREEN)
	else:
		get_window().mode = (Window.MODE_WINDOWED)


func _on_main_menu_pressed() -> void:
	main_menu_pressed.emit()


func _on_return_pressed() -> void:
	return_pressed.emit()
