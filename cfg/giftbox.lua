--[[
	SCRIPTER: DGVaniX [ DGVaniX#0096 ] 
	WEBSITE: http://vanix.market
--]]

local cfg = {}

cfg.open_giftbox = 0

cfg.display_css = [[
.div_giftbox{
	position: absolute;
	top: 145px;
	right: 10px;
	background-color: rgba(0,0,0,0.40);
	padding: 4px;
	max-width: 170px;
	border-radius: 20px;
	font-size: 20px;
	font-family: Pricedown;
	color: #FF0000;
	text-shadow: rgb(0, 0, 0) 1px 0px 0px, rgb(0, 0, 0) 0.533333px 0.833333px 0px, rgb(0, 0, 0) -0.416667px 0.916667px 0px, rgb(0, 0, 0) -0.983333px 0.133333px 0px, rgb(0, 0, 0) -0.65px -0.75px 0px, rgb(0, 0, 0) 0.283333px -0.966667px 0px, rgb(0, 0, 0) 0.966667px -0.283333px 0px;
}

.div_giftbox .symbol{
	content: url('https://i.imgur.com/wdzr8s5.png'); 
	display: inline-flex;
	width: 23px;
	height: 23px;
}
]]

function getGiftConfig()
	return cfg
end
