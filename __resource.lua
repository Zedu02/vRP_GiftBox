------------------------CREDITS------------------------
-------- Script made by Vlad, DevStudios Owner --------
--         Script made for Diamond Romania RP        --
--          Site: https://devstudios.store           --
--        Forum: http://forum.devstudios.store       --
--   Copyright 2019 ©DevStudios. All rights served   --
-------------------------------------------------------
description "vrp_giftbox"
dependency "vrp"

ui_page 'html/ui.html'

client_scripts {
	"lib/Proxy.lua",
	"lib/Tunnel.lua",
	"client.lua",
	"market.lua"
}

server_scripts {
    "@vrp/lib/utils.lua",
	"server.lua",
	"cfg/cfg.lua"
}

files{
	"html/debounce.min.js",
	"html/scripts.js",
	"html/styles.css",
	"html/gift.png",
	"html/ui.html"
}