local cfg = {}

cfg.message = {
	offline = " Player-ul nu este online!",
	invalid_number = " Numarul trebuie sa fie un numar :)!",
	not_enough_gb = " Nu ai destule ~g~cadouri~w~!",
	tr_succes = " ~g~Transactia ~w~a fost facuta cu succes~w~!",
	not_enough_m = " Nu ai destui ~g~BANI~w~!",
	only_has = " Player-ul are doar ~g~",
	only_have = " Ai doar ~g~",
	reset_msg = " Ai resetat ~g~"
}

cfg.giftbox = {
	msg_got = " Ai castigat ~g~",
	msg_got_n = " Nu ai castigat nimic!",
	open_amount = 1
}

cfg.trade = {
	msg_received = " Ai primit ~g~",
	msg_give = " Ai dat ~g~",
}

cfg.cars = {
    car1 = "audirs4",
    car2 = "rs5",
    car3 = "s8d4",
    car4 = "i8",
    car5 = "m516",
    car1_n = "Audi RS4",
    car2_n = "Audi RS5",
    car3_n = "Audi S8",
    car4_n = "BMW i8",
    car5_n = "BMW M5"
}

cfg.market = {
	tr_succes = " ~g~Tranzactia ~w~a fost efectuata cu succes~w~!",
	not_enough_m = " Nu ai destui ~g~Bani~w~!",
	amount = 350000
}

cfg.paycheck = {
	picture = "CHAR_BANK_BOL",
	title = "GiftBox",
	msg = " Ai primit ~g~3 Cadouri~w~!",
	amount = 3
}

cfg.menu = {
	permission = "giftbox.admin",
	name_desc = " Admin Menu",
	take_desc = "Fura cadouri de la playeri",
	give_desc = "Da cadouri la playeri",
	open_desc = "Deschide cadoul si castiga premii",
	reset_desc = "Reseteaza cadoul unui player",
	giftbox_desc = "Sistem Cadouri",
	trade_desc = "Poti da cadouri unui alt player",
	prompt_g = "Cadouri: ",
	prompt_user_id = "ID: ",
	name = "Cadouri",
	give_t = "Trimite",
	take_t = "Ia",
	reset_t = "Reseteaza cadouri",
	open = "Deschide",
	trade = "Vinde",
}

cfg.open_giftbox = 1

cfg.display_css = [[
	
	.div_giftbox {
    position: absolute;
    background-color: rgba(0,0,0,0.4);
    bottom: 5%;
    left: 45.625%;
    text-align:center;
    color: white;
    padding: 5px;
    width: 8.75%;
    border-radius: 20px;
    font-family: 'Lucida Consola';
    font-size: 17.5px;
    font-weight: bold;
    color: #FFFFFF;
    text-shadow: rgb(0, 0, 0) 1px 0px 0px, rgb(0, 0, 0) 0.533333px 0.833333px 0px, rgb(0, 0, 0) -0.416667px 0.916667px 0px, rgb(0, 0, 0) -0.983333px 0.133333px 0px, rgb(0, 0, 0) -0.65px -0.75px 0px, rgb(0, 0, 0) 0.283333px -0.966667px 0px, rgb(0, 0, 0) 0.966667px -0.283333px 0px;
  }

	.div_giftbox .symbol{
		content: url(https://discordapp.com/assets/739c1934cfb00cde067e3d45d49c5a45.svg);
		animation: logomove 2.1s infinite;
		 float: left;
		 margin-left: 5px;
		 width: 20px;
		 height: 20px;
	}
]]

function getConfig()
	return cfg
end
