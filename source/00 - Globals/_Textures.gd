extends Node
class_name SpriteTextures
#------------------------------------------------------------------------------#
#Global Dictionaries
#Zone Textures
var ZONE: Dictionary = { 
	"ZONE_16x16": preload("uid://6fm6smrfqfpm"),
	"ZONE_16x32": preload("uid://y8tywml45maf"),
	"ZONE_16x48": preload("uid://cwldcsie3747"),
	"ZONE_16x64": preload("uid://b8sls58u8n84o"),
	"ZONE_32x16": preload("uid://c4slsr4npd63p"),
	"ZONE_32x32": preload("uid://bnc0f2rsiepi2"),
	"ZONE_32x48": preload("uid://ctamn2fiiul6h"),
	"ZONE_32x64": preload("uid://cs1p0rfiomx6d"),
	"ZONE_48x16": preload("uid://byewdxjqkb0h2"),
	"ZONE_48x32": preload("uid://bqv2kwoof65lc"),
	"ZONE_48x48": preload("uid://bd6ixtpfnoivj"),
	"ZONE_48x64": preload("uid://ledob31kvdsf"),
	"ZONE_64x16": preload("uid://b5kwas27ymr6c"),
	"ZONE_64x32": preload("uid://dsmwhkmp7inw8"),
	"ZONE_64x48": preload("uid://bbda422ajnuqv"),
	"ZONE_64x64": preload("uid://co8k7300w7nrq")
}
#------------------------------------------------------------------------------#
# Body Textures
# S/A/T: Short/Average/Tall
# S/C: Skinny/Chub
# NW/WC: No Wheels/Wheelchair
# Example: S_C_WC = Short/Chub/Wheelchair
var TORSO: Dictionary = {
	# No Wheels
	"S_S_NW": preload("uid://dcge35nolthxw"),
	"S_C_NW": preload("uid://nsa71gahertx"),
	"A_S_NW": preload("uid://7mfo6e67k68q"),
	"A_C_NW": preload("uid://dq52p5rsvhokn"),
	"T_S_NW": preload("uid://ct8qt8cgqgrw6"),
	"T_C_NW": preload("uid://bvji36e44qksd"),
	# Wheels
	"S_S_WC": preload("uid://b02io5jhyrcx5"),
	"S_C_WC": preload("uid://d01x83fh746af"),
	"A_S_WC": preload("uid://dqpwd6s3v21n3"),
	"A_C_WC": preload("uid://cndcmxutsewn8"),
	"T_S_WC": preload("uid://3yl8ov2uj6uy"),
	"T_C_WC": preload("uid://cbxgi1q06o0tk")
}
var ARM_L: Dictionary = {
	# No Wheels
	"S_S_NW": preload("uid://bgb7oqktsb45a"),
	"S_C_NW": preload("uid://qrvfe7il0q5t"),
	"A_S_NW": preload("uid://dsdcq3rn83ofh"),
	"A_C_NW": preload("uid://vlb05s5gg0s0"),
	"T_S_NW": preload("uid://b2d3yewrd3jb4"),
	"T_C_NW": preload("uid://c1p33tekveo7p"),
	# Wheels
	"S_S_WC": preload("uid://b81gguyt6b0n4"),
	"S_C_WC": preload("uid://cdnksf3cyju2e"),
	"A_S_WC": preload("uid://didwxm51ci13"),
	"A_C_WC": preload("uid://spcau3n0h4tv"),
	"T_S_WC": preload("uid://ccoknvbds6tfk"),
	"T_C_WC": preload("uid://0n8p2pos3o05")
}
var ARM_R: Dictionary = {
	# No Wheels
	"S_S_NW": preload("uid://c3cjy6dp6uhbe"),
	"S_C_NW": preload("uid://6gumpsrkll3u"),
	"A_S_NW": preload("uid://duntx2cv2hcg5"),
	"A_C_NW": preload("uid://b867wycyshuds"),
	"T_S_NW": preload("uid://1msy3p1vsf3u"),
	"T_C_NW": preload("uid://c33rjkxahm88k"),
	# Wheels
	"S_S_WC": preload("uid://dpel7nm7jeun5"),
	"S_C_WC": preload("uid://dav56e51wj87p"),
	"A_S_WC": preload("uid://cy8r6oupl7nk4"),
	"A_C_WC": preload("uid://c7ocefnpwof30"),
	"T_S_WC": preload("uid://cmmx6qk0d00bi"),
	"T_C_WC": preload("uid://c7c8es7gqjck5")
}
var LEG_L: Dictionary = {
	# No Wheels
	"S_S_NW": preload("uid://bcifoimpu5586"),
	"S_C_NW": preload("uid://bs7yqelglor88"),
	"A_S_NW": preload("uid://chux27wvcwncv"),
	"A_C_NW": preload("uid://ck3ou7egm1b3a"),
	"T_S_NW": preload("uid://csq5k670jjy0x"),
	"T_C_NW": preload("uid://d01v0xtgk2c2i"),
	# Wheels
	"S_S_WC": preload("uid://ltv6h3ejxjr"),
	"S_C_WC": preload("uid://dakyeh0cytnfm"),
	"A_S_WC": preload("uid://dcabxidlrhd0c"),
	"A_C_WC": preload("uid://ccrmccvlvp8qr"),
	"T_S_WC": preload("uid://csstofbv0h63n"),
	"T_C_WC": preload("uid://bvn5k4eypo5pk")
}
var LEG_R: Dictionary = {
	# No Wheels
	"S_S_NW": preload("uid://ctni6ayudkc50"),
	"S_C_NW": preload("uid://db7bg3ivn6atj"),
	"A_S_NW": preload("uid://duq2a6ueymj4x"),
	"A_C_NW": preload("uid://d0wiysp4bnn5p"),
	"T_S_NW": preload("uid://c1ru0iumk56s2"),
	"T_C_NW": preload("uid://c0djubi4aj813"),
	# Wheels
	"S_S_WC": preload("uid://dny82kcyl2ehq"),
	"S_C_WC": preload("uid://dlquj3e5vx7wr"),
	"A_S_WC": preload("uid://bj3nkv1hj6ukq"),
	"A_C_WC": preload("uid://k1jqj23ixf4e"),
	"T_S_WC": preload("uid://dec1tmwo6pejc"),
	"T_C_WC": preload("uid://bcvv0a6u8yyq0")
}
