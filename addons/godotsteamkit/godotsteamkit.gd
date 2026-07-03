@tool
extends EditorPlugin

const DOCK_COMPONENT = preload("uid://mvsuwhd4mg2y")
const STEAMWORKS_PANEL = preload("uid://c08edo2nkhf2l")

var link_changelog: String = "[url=https://godotsteam.com/changelog/godotsteamkit/]changelog[/url]"
var link_website: String = "[url=https://godotsteam.com]website[/url]"
var steamworks_dock: Control


func _enable_plugin() -> void:
	print("GodotSteamKit updater enabled")


func _disable_plugin() -> void:
	print("GodotSteamKit updater disabled")


func _enter_tree() -> void:
	print_rich("GodotSteamKit v%s | %s | %s" % [get_plugin_version(), link_website, link_changelog])
	add_project_settings()
	add_steamworks_dock()


func _exit_tree() -> void:
	remove_steamworks_dock()


func _make_visible(visible) -> void:
	if steamworks_dock:
		steamworks_dock.set_visible(visible)


#region Add and remove things
func add_project_settings() -> void:
	# Whether to automatically check for updates
	if not ProjectSettings.has_setting("steam/updates/godotsteamkit/check_for_updates"):
		ProjectSettings.set_setting("steam/updates/godotsteamkit/check_for_updates", true)
	ProjectSettings.add_property_info({
		"name": "steam/updates/godotsteamkit/check_for_updates",
		"type": TYPE_BOOL
	})
	ProjectSettings.set_initial_value("steam/updates/godotsteamkit/check_for_updates", true)
	ProjectSettings.set_as_basic("steam/updates/godotsteamkit/check_for_updates", true)
	# Which channel of updates to pull from
	if not ProjectSettings.has_setting("steam/updates/godotsteamkit/update_channel"):
		ProjectSettings.set_setting("steam/updates/godotsteamkit/update_channel", 0)
	ProjectSettings.add_property_info({
		"name": "steam/updates/godotsteamkit/update_channel",
		"type": TYPE_INT,
		"hint": PROPERTY_HINT_ENUM,
		"hint_string": "Community, Sponsors"
	})
	ProjectSettings.set_initial_value("steam/updates/godotsteamkit/update_channel", 0)
	ProjectSettings.set_as_basic("steam/updates/godotsteamkit/update_channel", true)
	# Used for the Updater looking for redist files and SteamCMD
	if not ProjectSettings.has_setting("steam/settings/steamworks_sdk_location"):
		ProjectSettings.set_setting("steam/settings/steamworks_sdk_location", "")
	ProjectSettings.add_property_info({
		"name": "steam/settings/steamworks_sdk_location",
		"type": TYPE_STRING,
		"hint": PROPERTY_HINT_GLOBAL_DIR
	})
	ProjectSettings.set_initial_value("steam/settings/steamworks_sdk_location", "")
	ProjectSettings.set_as_basic("steam/settings/steamworks_sdk_location", true)
	# Whether to show various Steam debug messages
	if not ProjectSettings.has_setting("steam/settings/show_debug"):
		ProjectSettings.set_setting("steam/settings/show_debug", true)
	ProjectSettings.add_property_info({
		"name": "steam/settings/show_debug",
		"type": TYPE_BOOL
	})
	ProjectSettings.set_initial_value("steam/settings/show_debug", true)
	ProjectSettings.set_as_basic("steam/settings/show_debug", true)


func add_steamworks_dock() -> void:
	if EditorInterface.is_plugin_enabled("godotsteam"):
		print("GodotSteam GDExtension present, adding GodotSteamKit to its dock")
		var dock_content = DOCK_COMPONENT.instantiate()
		dock_content.kit_version = get_plugin_version()
		GodotSteamPlugin.get_dock_frame().add_companion_dock(dock_content)
	else:
		steamworks_dock = STEAMWORKS_PANEL.instantiate()
		steamworks_dock.kit_plugin = self
		steamworks_dock.kit_version = get_plugin_version()
		add_control_to_bottom_panel(steamworks_dock, "Steamworks")


func remove_steamworks_dock() -> void:
	remove_control_from_bottom_panel(steamworks_dock)
	steamworks_dock.queue_free()
	steamworks_dock = null
#endregion
