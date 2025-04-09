extends Node

@onready var playerScene = preload("res://scenes/player.tscn")

const PORT: int = 30303
const MAX_CLIENTS: int = 10
const SERVER_URL = "15.156.94.27"

var _spawn_root

func _ready() -> void:
	var args = Array(OS.get_cmdline_args())
	if args.has("-s"):
		_start_server()

func _start_server():
	print("Starting server...")
	
	_spawn_root = get_node("SpawnRoot")
	
	multiplayer.peer_connected.connect(self._on_client_connected)
	multiplayer.peer_disconnected.connect(self._on_client_disconnected)
	
	var server = ENetMultiplayerPeer.new()
	server.create_server(PORT, MAX_CLIENTS)
	multiplayer.multiplayer_peer = server

func join():
	print("Creating client...")
	
	multiplayer.connected_to_server.connect(self._connected_to_server)
	multiplayer.server_disconnected.connect(self._disconnected_from_server)
	multiplayer.connection_failed.connect(self._connection_failed)
	
	var client = ENetMultiplayerPeer.new()
	client.create_client(SERVER_URL, PORT)
	multiplayer.multiplayer_peer = client
	
func _connection_failed():
	print("Connection to server failed.")	
	
func _connected_to_server():
	print("Connected to server.")

func _disconnected_from_server():
	print("Disconnected from server.")

func _on_client_connected(clientId: int):
	_create_player(clientId)
	print("Client connected: " + str(clientId))

func _on_client_disconnected(clientId: int):
	print("Client disconnected: " + str(clientId))
	
	if not _spawn_root.has_node(str(clientId)):
		return
	_spawn_root.get_node(str(clientId)).queue_free()
	
func _create_player(id: int):
	var p = playerScene.instantiate()
	p.player_id = id
	p.name = str(id)
	_spawn_root.add_child(p, true)


func _on_button_pressed() -> void:
	join()
	$Button.hide()
