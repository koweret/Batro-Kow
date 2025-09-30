-- LINES 2-35 ARE FROM YAHIMOD core.lua THX U
G.C.YAHIPURPLE = HEX("00FF00") -- i know i aint yahi and i know it aint purple but im too afraid to change it because shit goes down when you try to do anything with shaders
G.C.YAHIORANGE = HEX("00FFFF") -- dih
G.C.mid_flash = 0
G.C.vort_time = 7
G.C.vort_speed = 0.4

-- from cryptid :}
local oldfunc = Game.main_menu
Game.main_menu = function(change_context)
	local ret = oldfunc(change_context)
	G.SPLASH_BACK:define_draw_steps({
			{
				shader = "splash",
				send = {
					{ name = "time", ref_table = G.TIMERS, ref_value = "REAL_SHADER" },
           			{name = 'vort_speed', val = G.C.vort_speed},
            		{name = 'colour_1', ref_table = G.C, ref_value = 'YAHIPURPLE'},
            		{name = 'colour_2', ref_table = G.C, ref_value = 'YAHIORANGE'},
            		{name = 'mid_flash', ref_table = G.C, ref_value = 'mid_flash'},
				},
			},
		})
	return ret
end

logo = "balatro.png"

SMODS.Atlas {
		key = "balatro",
		path = logo,
		px = 333,
		py = 216,
		prefix_config = { key = false }
	}

-- contains function
function listcontains(list, x)
	for _, v in pairs(list) do
		if v == x then return true end
	end
	return false
end


-- atlases
SMODS.Atlas {
	key = 'Jokers',
	path = 'jokers.png',
	px = 71,
	py = 95
}
SMODS.Atlas {
	key = 'tagsatlas',
	path = 'tags.png',
	px = 34,
	py = 34
}
SMODS.Atlas {
	key = 'tarotatlas',
	path = 'tarots.png',
	px = 71,
	py = 95
}
SMODS.Atlas {
	key = 'enhancements',
	path = 'enhancements.png',
	px = 71,
	py = 95
}
-- TSPIN sound
-- Credits:
-- Idea: Me
-- Sound: osk (?)
SMODS.Sound({key = 'tspinsound', path = 'clearspin.ogg',})
-- GREEN sound and shader
-- Credits:
-- Idea: Me
-- Shader: Yahimod
SMODS.Sound({key = 'greensound', path = 'green.ogg',})
SMODS.Shader({ key = 'greenedition', path = 'greenedition.fs' })
-- Oceanic sound and shader
-- Credits:
-- Idea: Me
-- Shader: Yahimod
SMODS.Sound({key = 'oceanicsound', path = 'oceanic.ogg',})
SMODS.Shader({ key = 'oceanicedition', path = 'oceanicedition.fs' })
-- Loss Joker
-- Credits:
-- Idea: Me
-- Art : Me
-- Code: Me
SMODS.Joker {
	key = 'lossjoker',
	loc_txt = {
		name = 'Loss Joker',
		text = {
			'If a 5, 2, and Ace are',
			'played and scored together,',
			'{X:mult,C:white}X2{} Mult'
		}
	},
	unlocked = true,
	discovered = false,
	rarity = 2,
	cost = 4,
	config = { extra = { xmult = 2 } },
	atlas = 'Jokers',
	pos = { x = 0, y = 0 },
	loc_vars = function(self,info_queue,card)
		return { vars = { card.ability.extra.xmult } }
	end,
	credit = {
		art = "Kowa",
		code = "Kowa",
		concept = "Kowa"
	},
	calculate = function(self, card, context)
		if context.cardarea == G.jokers and context.joker_main and context.scoring_hand then
			local has_ace = false
			local has_5 = false
			local has_2 = false
			for i = 1, #context.scoring_hand do
				if context.scoring_hand[i]:get_id() == 14 then
					has_ace = true
				elseif context.scoring_hand[i]:get_id() == 5 then
					has_5 = true
				elseif context.scoring_hand[i]:get_id() == 2 then
					has_2 = true
				end
			end
			if has_ace and has_5 and has_2 then
				return { x_mult = card.ability.extra.xmult }
			end
		end
	end
}
-- Gambling 101
-- Credits:
-- Idea: Me
-- Art : Me
-- Code: Me
SMODS.Joker {
	key = 'gambling101',
	loc_txt = {
		name = 'Gambling 101',
		text = {
			'If a played hand contains',
			'three scored 7s,',
			'{X:mult,C:white}X1.777{} Mult' -- i dont know why but smods rounds this if i use locvars
		}
	},
	unlocked = true,
	discovered = false,
	rarity = 2,
	cost = 4,
	config = { extra = { xmult = 1.777 } },
	atlas = 'Jokers',
	pos = { x = 1, y = 0 },
	loc_vars = function(self,info_queue,card)
		return { vars = { card.ability.extra.xmult } }
	end,
	credit = {
		art = "Kowa",
		code = "Kowa",
		concept = "Kowa"
	},
	calculate = function(self, card, context)
		if context.cardarea == G.jokers and context.joker_main and context.scoring_hand then
			local num_7s = 0
			for i = 1, #context.scoring_hand do
				if context.scoring_hand[i]:get_id() == 7 then
					num_7s = num_7s + 1
				end
			end
			if num_7s == 3 then
				return { x_mult = card.ability.extra.xmult }
			end
		end
	end
}
-- ######
-- Credits:
-- Idea: Me
-- Art : Me
-- Code: Me
SMODS.Joker {
	key = 'robloxtag',
	loc_txt = {
		name = 'Censored on Roblox',
		text = {
			'{C:mult}+[Content Deleted]{} Mult'
		}
	},
	rarity = 1,
	cost = 3,
	config = { extra = { max = 9, min = 1 } },
	atlas = 'Jokers',
	pos = { x = 0, y = 1 },
	loc_vars = function(self,info_queue,card)
		return { vars = { card.ability.extra.xmult } }
	end,
	credit = {
		art = "Kowa",
		code = "Kowa",
		concept = "Kowa"
	},
	calculate = function(self, card, context)
		if context.cardarea == G.jokers and context.joker_main then
			return { mult = pseudorandom('kwjk_robloxtag', card.ability.extra.min, card.ability.extra.max) }
		end
	end
}
-- Inefficient Joker
-- Credits:
-- Idea: Me
-- Art : Me
-- Code: Me
SMODS.Joker {
	key = 'inefficient',
	loc_txt = {
		name = 'Inefficient Joker',
		text = {
			'If played hand is a',
			'{C:attention}High Card{} and contains',
			'5 cards, {X:mult,C:white}X#1#{} Mult'
		}
	},
	rarity = 1,
	cost = 4,
	config = { extra = { xmult = 1.5 } },
	atlas = 'Jokers',
	pos = { x = 1, y = 1 },
	loc_vars = function(self,info_queue,card)
		return { vars = { card.ability.extra.xmult } }
	end,
	credit = {
		art = "Kowa",
		code = "Kowa",
		concept = "Kowa"
	},
	calculate = function(self, card, context)
		if context.cardarea == G.jokers and context.joker_main then
			if context.scoring_name == 'High Card' and #context.full_hand == 5 then
				return { xmult = card.ability.extra.xmult }
			end
		end
	end
}
-- Medkit Phighting
-- Credits:
-- Idea: Me
-- Art : Me & The Phighting Team (i dont actually know who rendered the phighters)
-- Code: Me
SMODS.Joker {
	key = 'medkit',
	loc_txt = {
		name = 'Medkit Phighting',
		text = {
			'If played hand has atleast',
			'3 scored cards that are',
			'{X:clubs,C:white}Clubs{}, {C:chips}+#1#{} Chips per {X:clubs,C:white}Club{}-suit card'
		}
	},
	unlocked = true,
	discovered = true,
	rarity = 2,
	cost = 6,
	config = { extra = { chips = 60, } },
	atlas = 'Jokers',
	pos = { x = 0, y = 2 },
	loc_vars = function(self,info_queue,card)
		return { vars = { card.ability.extra.chips } }
	end,
	credit = {
		art = "Kowa & SodaKettle",
		code = "Kowa",
		concept = "Kowa"
	},
	calculate = function(self, card, context)
		if context.cardarea == G.jokers and context.joker_main and context.scoring_hand then
			local num_clubs = 0
			for i = 1, #context.scoring_hand do
				if context.scoring_hand[i]:is_suit('Clubs') then
					num_clubs = num_clubs + 1
				end
			end
			if num_clubs >= 3 then
				return { chips = (card.ability.extra.chips * num_clubs) }
			end
		end
	end
}
-- Subspace Phighting
-- Credits:
-- Idea: Me
-- Art : Me & The Phighting Team (i dont actually know who rendered the phighters)
-- Code: Me
SMODS.Joker {
	key = 'subspace',
	loc_txt = {
		name = 'Subspace Phighting',
		text = {
			'If played hand has atleast',
			'3 scored cards that are',
			'{X:hearts,C:white}Hearts{}, {C:mult}+#1#{} Mult per {X:hearts,C:white}Heart{}-suit card',
		}
	},
	unlocked = true,
	discovered = true,
	rarity = 2,
	cost = 6,
	config = { extra = { mult = 6 } },
	atlas = 'Jokers',
	pos = { x = 1, y = 2 },
	loc_vars = function(self,info_queue,card)
		return { vars = { card.ability.extra.mult } }
	end,
	credit = {
		art = "Kowa & SodaKettle",
		code = "Kowa",
		concept = "Kowa"
	},
	calculate = function(self, card, context)
		if context.cardarea == G.jokers and context.scoring_main and context.scoring_hand then
			local num_hearts = 0
			for i = 1, #context.scoring_hand do
				if context.full_hand[i]:is_suit('Hearts') then
					num_hearts = num_hearts + 1
				end
			end
			if num_hearts >= 3 then
				return { mult = (card.ability.extra.mult * num_hearts) }
			end
		end
	end
}
-- Banhammer Phighting
-- Credits:
-- Idea: Me
-- Art : Me & The Phighting Team (i dont actually know who rendered the phighters)
-- Code: Me
SMODS.Joker {
	key = 'banhammer',
	loc_txt = {
		name = 'Banhammer Phighting',
		text = {
			'If played hand has atleast',
			'3 scored cards that are',
			'{X:spades,C:white}Spades{}, {C:money}+$#1#{} per {X:spades,C:white}Spade{}-suit card'
		}
	},
	unlocked = true,
	discovered = true,
	rarity = 2,
	cost = 6,
	config = { extra = { dollars = 2, } },
	atlas = 'Jokers',
	pos = { x = 0, y = 2 },
	loc_vars = function(self,info_queue,card)
		return { vars = { card.ability.extra.dollars } }
	end,
	credit = {
		art = "Kowa & SodaKettle",
		code = "Kowa",
		concept = "Kowa"
	},
	calculate = function(self, card, context)
		if context.cardarea == G.jokers and context.joker_main and context.scoring_hand then
			local num_spades = 0
			for i = 1, #context.scoring_hand do
				if context.scoring_hand[i]:is_suit('Clubs') then
					num_spades = num_spades + 1
				end
			end
			if num_spades >= 3 then
				return { dollars = (card.ability.extra.dollars * num_spades) }
			end
		end
	end
}
-- Gay Joker
-- Credits:
-- Idea: Me
-- Art : Me & LocalThunk
-- Code: Me
straight_name = localize('Straight', 'poker_hands')
SMODS.Joker{
    key = 'gayjoker',
    loc_txt = {
        name = 'Gay',
        text = {
			"This joker gains {C:mult}+#1#{} Mult",
			"if hand does not contain a {C:attention}#3#{},",
			"resets when a {C:attention}#3#{} is played", -- balagay technically makes this joker make no sense
			"{C:inactive}(Currently {}{C:mult}+#2#{}{C:inactive} Mult){}"
		},
	},
    atlas = 'Jokers',
    rarity = 1,
    cost = 3,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x=2, y=1},
    config = { extra = {add_mult = 1.5, base_mult = 1.5, hand_type = "Straight"}},
    loc_vars = function(self, info_queue, card)
		return { vars = {card.ability.extra.add_mult, card.ability.extra.base_mult, straight_name}}
	end,
	credit = {
		art = "Kowa & LocalThunk",
		code = "Kowa",
		concept = "Kowa"
	},
    calculate = function(self, card, context)
		if context.before and not context.blueprint then
			if not next(context.poker_hands['Straight']) and not next(context.poker_hands['Straight Flush']) then
				card.ability.extra.base_mult = card.ability.extra.base_mult + card.ability.extra.add_mult
				return {
					message = localize("k_upgrade_ex"),
					colour = G.C.RED
				}
			else
				card.ability.extra.base_mult = 2
				return {
					message = localize("k_reset"),
					colour = G.C.RED
				}
			end
        end
		if context.cardarea == G.jokers and context.joker_main then
			return {
                mult = card.ability.extra.base_mult
            }
		end
    end
}
-- Super TSpin Double
-- Credits:
-- Idea: Me
-- Art : Me & osk (its pronounced like kiosk)
-- Code: Me
pair_name = localize('Pair', 'poker_hands')
SMODS.Joker{
    key = 'stsd',
    loc_txt = {
        name = 'Super TSpin Double',
        text = {
			"If two {C:attention}#2#s{} are played",
			"consecutively, {X:mult,C:white}X#1#{} Mult",
		},
	},
    atlas = 'Jokers',
    rarity = 2,
    cost = 5,
    unlocked = true,
	discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x=3, y=1},
    config = { extra = {x_mult = 2, hand_type = "Pair", activate_bonus = false, has_paired_once = false}},
    loc_vars = function(self, info_queue, card)
		return { vars = {card.ability.extra.x_mult, pair_name}}
	end,
	credit = {
		art = "Kowa & osk",
		code = "Kowa",
		concept = "Kowa"
	},
    calculate = function(self, card, context)
		if context.end_of_round then
			card.ability.extra.activate_bonus = false
			card.ability.extra.has_paired_once = false
		end
		if context.before and not context.blueprint then
			if not next(context.poker_hands['Pair']) and card.ability.extra.has_paired_once then
				card.ability.extra.has_paired_once = false
			end
			if next(context.poker_hands['Pair']) and card.ability.extra.has_paired_once then
				card.ability.extra.activate_bonus = true
			end
			if next(context.poker_hands['Pair']) and not card.ability.extra.has_paired_once then
				card.ability.extra.has_paired_once = true
			end
        end
		if context.cardarea == G.jokers and context.joker_main and card.ability.extra.activate_bonus then
			card.ability.extra.activate_bonus = false
			card.ability.extra.has_paired_once = false
			return {
				x_mult = card.ability.extra.x_mult,
				remove_default_message = true,
				message = "TSPIN DOUBLE",
				colour = G.C.PURPLE,
				sound = "kwjk_tspinsound"
			}
		end
    end
}

-- DT Cannon
-- Credits:
-- Idea: Me
-- Art : Me & osk (its pronounced like kiosk)
-- Code: Me
toak_name = localize('Three of a Kind', 'poker_hands')
SMODS.Joker{
    key = 'dtcannon',
    loc_txt = {
        name = 'DT Cannon',
        text = {
			"If a {C:attention}#2#{} is played",
			"and then a {C:attention}#3#{}",
			"immediately after, {X:mult,C:white}X#1#{} Mult",
		},
	},
    atlas = 'Jokers',
    rarity = 2,
    cost = 6,
    unlocked = true,
	discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x=3, y=2},
    config = { extra = {x_mult = 3, hand_type_a = "Pair", hand_type_b = "Three of a Kind", activate_bonus = false, has_paired_once = false}},
    loc_vars = function(self, info_queue, card)
		return { vars = {card.ability.extra.x_mult, pair_name, toak_name}}
	end,
	credit = {
		art = "Kowa & osk",
		code = "Kowa",
		concept = "Kowa"
	},
    calculate = function(self, card, context)
		if context.end_of_round then
			card.ability.extra.activate_bonus = false
			card.ability.extra.has_paired_once = false
		end
		if context.before and not context.blueprint then
			if not next(context.poker_hands['Three of a Kind']) and card.ability.extra.has_paired_once then
				card.ability.extra.has_paired_once = false
			end
			if next(context.poker_hands['Three of a Kind']) and card.ability.extra.has_paired_once then
				card.ability.extra.activate_bonus = true
			end
			if next(context.poker_hands['Pair']) and not card.ability.extra.has_paired_once then
				card.ability.extra.has_paired_once = true
			end
			
			
        end
		if context.cardarea == G.jokers and context.joker_main and card.ability.extra.activate_bonus then
			card.ability.extra.activate_bonus = false
			card.ability.extra.has_paired_once = false
			return {
				x_mult = card.ability.extra.x_mult,
				remove_default_message = true,
				message = "TSPIN TRIPLE",
				colour = G.C.PURPLE,
				sound = "kwjk_tspinsound"
			}
		end
    end
}

-- GEMINI (the entropic being who)
-- Credits:
-- Idea: GeminiEntropic
-- Art : Me & GeminiEntropic
-- Code: Me
SMODS.Joker{
    key = 'geminientropic',
    loc_txt = {
        name = '{B:1,V:2}Gem{B:2,V:1}ini{}',
        text = {
			"{X:mult,C:white}X#1#{} Mult if scoring cards",
			"have an equal amount of",
			"{C:hearts}Hearts{}/{C:diamonds}Diamonds{} and {C:spades}Spades{}/{C:clubs}Clubs{}"
		},
	},
    atlas = 'Jokers',
    rarity = 4,
    cost = 25,
    unlocked = true,
	discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = false,
    pos = {x=2, y=2},
	soul_pos = {x=3, y=0},
    config = { extra = {x_mult = 4}},
    loc_vars = function(self, info_queue, card)
		return { vars = {card.ability.extra.x_mult, colours = {HEX('000000'), HEX('FFFFFF'),}}}
	end,
	credit = {
		art = "Kowa & GeminiEntropic",
		code = "Kowa",
		concept = "GeminiEntropic"
	},
    calculate = function(self, card, context)
		if context.cardarea == G.jokers and context.joker_main and context.scoring_hand then
			local num_spubs = 0
			local num_hends = 0
			for i, card in ipairs(context.scoring_hand) do
				if context.full_hand[i]:is_suit('Clubs') or context.full_hand[i]:is_suit('Spades') then
					num_spubs = num_spubs + 1
				end
				if context.full_hand[i]:is_suit('Hearts') or context.full_hand[i]:is_suit('Diamonds') then
					num_hends = num_hends + 1
				end
			end
			if num_spubs == num_hends then
				return { x_mult = (card.ability.extra.x_mult) }
			end
		end
    end
}

-- the green
-- Credits:
-- Idea: Me
-- Art : Me
-- Code: Me & Yahiamice
SMODS.Rarity{
	key = 'greenrarity',
	loc_txt = { name = 'GREEN' },
	badge_colour = HEX('00FF00')
}
SMODS.Joker{
    key = 'greenjoker',
    loc_txt = {
        name = 'GREEN',
        text = { "{C:green}>be me",
        "{C:green}>playing Balatro",
        "{C:green}>reroll shop",
        "{C:green}>green edition",
        "{C:green}>????",
        "{C:green}>plays hand",
        "{C:green}>GREEN joker appears???",
        "{C:green}>huh.mp3",
        "{C:green}>the joker magically talks:",
        "{C:red}''You won't be able to delete me",
        "{C:red}until (#1#/#2#) rounds later.''",
        "{C:green}>what the fuck"},},
    atlas = 'Jokers',
    rarity = "kwjk_greenrarity",
    cost = 0,
    unlocked = true,
	discovered = false,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = false,
    hidden = true,
    pos = {x=2, y= 0},
    config = { extra = {round = 0, maxround = 2}},
    loc_vars = function(self, info_queue, card)
		return { vars = {card.ability.extra.round, card.ability.extra.maxround}}
	end,
	credit = {
		art = "Kowa",
		code = "Kowa & Yahiamice",
		concept = "Kowa"
	},
	add_to_deck = function(self, card, from_debuff)
		SMODS.calculate_effect({ message = 'GREEN', colour = HEX('00FF00'), sound = 'kwjk_greensound', }, card)
	end,
    calculate = function(self, card, context)
        if context.setting_blind and not context.blueprint then
            local _msg = "GREEN"
			if card.ability.extra.round < card.ability.extra.maxround then
				card.ability.extra.round = card.ability.extra.round + 1
            end
            if card.ability.extra.round >= card.ability.extra.maxround then 
                _msg = "GREEN?" 
                card.ability.eternal = nil 
            end
            return {
                message = _msg,
                sound = "kwjk_greensound",
            }
        end
        if context.selling_self then
            play_sound("kwjk_greensound")
        end
    end,
}
-- GREEN edition
-- Credits:
-- Idea: Me
-- Shader: Yahimod
-- Code: Yahiamice & Me
-- NOTICE:
-- this code was stolen from yahimod
-- i have no bloody idea how to do this
-- thx u :)
SMODS.Edition{
	key = "green",
	order = 10,
    loc_txt = {
        name = "GREEN",
        label = "GREEN",
        text = {
            "does..... something?",
        }
    },
	credit = {
		art = "Yahimod",
		code = "Yahiamice & Kowa",
		concept = "Kowa"
	},
	weight = 10,
	shader = "greenedition",
	in_shop = true,
	extra_cost = 1,
	config = { trigger = nil },
	sound = {
		sound = "kwjk_greensound",
		per = 1,
		vol = 0.3,
	},
	badge_colour = HEX('00FF00'),
	get_weight = function(self)
		return G.GAME.edition_rate * self.weight
	end,
	calculate = function(self, card, context)
		if
			(
				context.edition -- for when on jonklers
				and context.cardarea == G.jokers -- checks if should trigger
				and card.config.trigger -- fixes double trigger
			) or (
				context.main_scoring -- for when on playing cards
				and context.cardarea == G.play
			)
		then
			return {}
		end
		if context.end_of_round and context.cardarea == G.jokers then
			addGreen()
			card.config.trigger = nil
			card:start_dissolve({G.C.RED})
			card = nil
		end
		if context.selling_self then
            play_sound("kwjk_greensound")
        end
	end,
}
-- shamelessly copied from cryptid. i have no idea what i'm doing
-- i (kowa) shamelessly copied from yahimod. i do not wanna learn f#

-- Credits:
-- Code: Yahimod & Me
function addGreen()
	local card = create_card('Joker', G.jokers, nil, nil, nil, nil, 'j_kwjk_greenjoker')
	card.ability.eternal = true
	card.sell_cost = 0
	card:add_to_deck()
	G.jokers:emplace(card)
end
-- Oceanic Gradient
SMODS.Gradient{
	key = "oceanicgradient",
	colours = {
		HEX('003869'),
		HEX('539CDB')
	}
}
-- Oceanic Edition
-- Credits:
-- Idea: Me
-- Shader: Yahimod
-- Code: Yahiamice & Me
SMODS.Edition{
	key = "oceanic",
	order = 9,
    loc_txt = {
        name = "Oceanic",
        label = "Oceanic",
        text = {
            "{X:chips,C:white}X#1#{} Chips",
        }
    },
	weight = 14,
	shader = "oceanicedition",
	in_shop = true,
	extra_cost = 3,
	config = { x_chips = 2, trigger = nil },
	sound = {
		sound = "kwjk_oceanicsound",
		per = 1,
		vol = 0.7,
	},
	badge_colour = HEX('539CDB'),
	get_weight = function(self)
		return G.GAME.edition_rate * self.weight
	end,
	loc_vars = function(self, info_queue)
		return { vars = { self.config.x_chips } }
	end,
	credit = {
		art = "Yahimod",
		code = "Yaiamice & Kowa",
		concept = "Kowa"
	},
	calculate = function(self, card, context)
		if
			(
				context.edition -- for when on jonklers
				and context.cardarea == G.jokers -- checks if should trigger
				and card.config.trigger -- fixes double trigger
			) or (
				context.main_scoring -- for when on playing cards
				and context.cardarea == G.play
			)
		then
			return { x_chips = self.config.x_chips } -- updated value
		end
		if context.joker_main then
			card.config.trigger = true -- context.edition triggers twice, this makes it only trigger once (only for jonklers)
		end

		if context.after then
			card.config.trigger = nil
		end
	end,
}

-- Oceanic Tag
-- Idea: Me
-- Art: Me & LocalThunk
-- Code: Me & VanillaRemade
SMODS.Tag {
    key = "oceanictag",
	loc_txt = {
		name = "Oceanic Tag",
		text = {
			"Next base edition shop",
			"Joker is free and",
			"becomes {C:kwjk_oceanicgradient}Oceanic{}"
		},
	},
    min_ante = 1,
	atlas = "tagsatlas",
    pos = { x = 0, y = 0 },
    loc_vars = function(self, info_queue, tag)
        info_queue[#info_queue + 1] = G.P_CENTERS.e_kwjk_oceanic
    end,
	credit = {
		art = "Kowa",
		code = "Kowa",
		concept = "Kowa"
	},
    apply = function(self, tag, context)
        if context.type == 'store_joker_modify' then
            if not context.card.edition and not context.card.temp_edition and context.card.ability.set == 'Joker' then
                local lock = tag.ID
                G.CONTROLLER.locks[lock] = true
                context.card.temp_edition = true
                tag:yep('+', G.C.DARK_EDITION, function()
                    context.card.temp_edition = nil
                    context.card:set_edition("e_kwjk_oceanic", true)
                    context.card.ability.couponed = true
                    context.card:set_cost()
                    G.CONTROLLER.locks[lock] = nil
                    return true
                end)
                tag.triggered = true
                return true
            end
        end
    end
}

SMODS.Consumable:take_ownership('wheel_of_fortune',
    {
	loc_txt = {
		name = "The Wheel of Fortune",
		text = {
            "{C:green}#1# in #2#{} chance to add",
            "{C:dark_edition}Foil{}, {C:dark_edition}Holographic{},",
            "{C:dark_edition}Polychrome{}, or {C:dark_edition}Oceanic{}", -- add oceanic edition
			"edition to a random {C:attention}Joker{}",
        }
	},
	config = { extra = { odds = 4 } },
	loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds,
            'kwjk_wheel_of_fortune')
        return { vars = { numerator, denominator } }
    end,
	use = function(self, card, area, copier)
        if SMODS.pseudorandom_probability(card, 'kwjk_wheel_of_fortune', 1, card.ability.extra.odds) then
            local editionless_jokers = SMODS.Edition:get_edition_cards(G.jokers, true)

            local eligible_card = pseudorandom_element(editionless_jokers, 'kwjk_wheel_of_fortune')
            local edition = poll_edition('kwjk_wheel_of_fortune', nil, true, true,
                { 'e_polychrome', 'e_holo', 'e_foil', 'e_kwjk_oceanic' }) -- add oceanic edition
            eligible_card:set_edition(edition, true)
            check_for_unlock({ type = 'have_edition' })
        else
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    attention_text({
                        text = localize('k_nope_ex'),
                        scale = 1.3,
                        hold = 1.4,
                        major = card,
                        backdrop_colour = G.C.SECONDARY_SET.Tarot,
                        align = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK or G.STATE == G.STATES.SMODS_BOOSTER_OPENED) and
                            'tm' or 'cm',
                        offset = { x = 0, y = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK or G.STATE == G.STATES.SMODS_BOOSTER_OPENED) and -0.2 or 0 },
                        silent = true
                    })
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.06 * G.SETTINGS.GAMESPEED,
                        blockable = false,
                        blocking = false,
                        func = function()
                            play_sound('tarot2', 0.76, 0.4)
                            return true
                        end
                    }))
                    play_sound('tarot2', 1, 0.4)
                    card:juice_up(0.3, 0.5)
                    return true
                end
            }))
        end
    end,
    },
    true
)

-- Unis Reversis
-- Credits:
-- Idea: Me
-- Art : Me
-- Code: Me
SMODS.Joker{
    key = 'unisreversis',
    loc_txt = {
        name = 'Unis Reversis',
        text = {
			"Swaps {C:chips}Chips{} and {C:mult}Mult{} score",
			"{C:inactive}(Placement matters){}"
		},
	},
    atlas = 'Jokers',
    rarity = 3,
    cost = 9,
    unlocked = true,
	discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x=0, y=3},
    config = {},
    loc_vars = function(self, info_queue, card)
		return {}
	end,
	credit = {
		art = "Kowa",
		code = "Kowa",
		concept = "Kowa"
	},
    calculate = function(self, card, context)
		if context.cardarea == G.jokers and context.joker_main then
			local current_mult = mult
            mult = mod_mult(hand_chips)
            hand_chips = mod_chips(current_mult)

            return {
                message = "Reverse!",
				colour = HEX('C429FE'),
				sound = "gong"
            }
		end
    end
}
-- President
-- Credits:
-- Idea: Me
-- Art : Me
-- Code: Me
SMODS.Joker{
    key = 'president',
    loc_txt = {
        name = 'President',
        text = {
			"{B:1,C:white}^#1# Mult{} and {B:2,C:white}^#2# Chips{} for each",
			"{C:attention}Jack{} held in hand"
		},
	},
    atlas = 'Jokers',
    rarity = 3,
    cost = 11,
    unlocked = true,
	discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x=1, y=3},
    config = { extra = { emult = 1.05, echips = 1.05}},
    loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.emult, card.ability.extra.echips, colours = {HEX('AD433B'), HEX('306B90')} } }
	end,
	credit = {
		art = "Kowa",
		code = "Kowa",
		concept = "Kowa"
	},
    calculate = function(self, card, context)
		if context.individual and context.cardarea == G.hand and not context.end_of_round and context.other_card:get_id() == 11 then
            if context.other_card.debuff then
                return {
                    message = localize('k_debuffed'),
                    colour = G.C.RED
                }
            else
                return {
                    e_mult = card.ability.extra.emult,
					extra = {
						e_chips = card.ability.extra.echips
					}
                }
            end
        end
    end
}

-- KOWA
-- Credits:
-- Idea: Me
-- Art : Me & LocalThunk
-- Code: Me
SMODS.Joker{
    key = 'kowa',
    loc_txt = {
        name = 'Kowa',
        text = {
			"{B:1,C:white}^^#1# Mult{} for each",
			"{C:hearts}Heart{} held in hand"
		},
	},
    atlas = 'Jokers',
    rarity = 4,
    cost = 40,
    unlocked = true,
	discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = false,
    pos = {x=2, y=3},
	soul_pos = {x=3, y=3},
    config = { extra = { hyper_arrows = 2, hyper_mult = 1.01}},
    loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.hyper_mult, colours = {HEX('834742')} } }
	end,
	credit = {
		art = "Kowa, LocalThunk",
		code = "Kowa",
		concept = "Kowa"
	},
    calculate = function(self, card, context)
		if context.individual and context.cardarea == G.hand and not context.end_of_round and context.other_card:is_suit('Hearts') then
            if context.other_card.debuff then
                return {
                    message = localize('k_debuffed'),
                    colour = G.C.RED
                }
            else
                return {
                    hypermult = {
						card.ability.extra.hyper_arrows,
						card.ability.extra.hyper_mult
					}
				}
            end
        end
    end
}

-- Oops! All Oops! All Oops! All
-- Credits:
-- Idea: Me
-- Art : LocalThunk
-- Code: Me
SMODS.Joker {
    key = "oopsalloopsall",
	loc_txt = {
        name = 'Oops! All Oops! All Oops! All',
        text = {
			"All {C:green}probabilities{} are",
			"{C:attention}guaranteed{} to hit"
		},
	},
	credit = {
		art = "LocalThunk, Kowa",
		code = "Kowa",
		concept = "Kowa"
	},
	atlas = "Jokers",
    unlocked = true,
	discovered = true,
    blueprint_compat = false,
    rarity = 3,
    cost = 7,
    pos = {x=4, y=0},
    calculate = function(self, card, context)
        if context.mod_probability and not context.blueprint then
            return {
                numerator = context.denominator
            }
        end
    end,
}

-- Prideful
-- Idea: Me
-- Art: Me
-- Code: Me
SMODS.Enhancement {
    key = 'prideful',
	loc_txt = {
        name = 'Prideful',
        text = {
			"For each extra {C:attention}suit{}",
			"played, {X:mult,C:white}X1.5{} Mult",
		},
	},
	atlas = "enhancements",
    pos = { x = 0, y = 0 },
    config = { extra = { xmult = 1.5 } },
    loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.xmult } }
    end,
	credit = {
		art = "Kowa",
		code = "Kowa",
		concept = "Kowa"
	},
    calculate = function(self, card, context)
		if context.main_scoring and context.cardarea == G.play then
			
			card.ability.extra.xmult = 1 -- to do: check if this actually works
			local clubs_played = false
			local heart_played = false
			local spade_played = false
			local diamo_played = false
			for _,playing_card in ipairs(context.scoring_hand) do
                if playing_card:is_suit('Clubs', nil, true) and not card:is_suit('Clubs', nil, true) and not clubs_played then
					card.ability.extra.xmult = card.ability.extra.xmult * 1.5
					clubs_played = true
				end
				if playing_card:is_suit('Spades', nil, true) and not card:is_suit('Spades', nil, true) and not spade_played then
					card.ability.extra.xmult = card.ability.extra.xmult * 1.5
					spade_played = true
				end
				if playing_card:is_suit('Hearts', nil, true) and not card:is_suit('Hearts', nil, true) and not heart_played then
					card.ability.extra.xmult = card.ability.extra.xmult * 1.5
					heart_played = true
				end
				if playing_card:is_suit('Diamonds', nil, true) and not card:is_suit('Diamonds', nil, true) and not diamo_played then
					card.ability.extra.xmult = card.ability.extra.xmult * 1.5
					diamo_played = true
                end
            end
			return { xmult = (card.ability.extra.xmult) }
        end
	end
}
-- Pride
-- Idea: Me
-- Art: Me
-- Code: Me
SMODS.Consumable{
    key = "pride",
	loc_txt = {
		name = 'Pride',
        text = {
			"Enhances {C:attention}2{} selected",
			"cards into {C:attention}Pride Cards{}"
		},
	},
    set = "Tarot",
	atlas = "tarotatlas",
    pos = { x = 0, y = 0 },
    config = { max_highlighted = 2, mod_conv = "m_kwjk_prideful" },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.mod_conv]
        return { vars = { card.ability.max_highlighted, localize { type = "name_text", set = "Enhanced", key = card.ability.mod_conv } } }
    end,
	credit = {
		art = "Kowa",
		code = "Kowa",
		concept = "Kowa"
	}
}
-- Burnt the Water
-- Idea: Me
-- Art: Me
-- Code: Jevonn (Part of Cryptid Mod Team) (and very slightly me)
SMODS.Joker{
	key = "burntwater",
	loc_txt = {
		name = 'Burnt the Water',
        text = {
			"Other {C:kwjk_oceanicgradient}Oceanic{} cards each give {X:mult,C:white}X#1#{} Mult",
		},
	},
	atlas = "Jokers",
	pos = { x = 4, y = 1 },
	config = { extra = { xmult = 1.75 } },
	loc_vars = function(self, info_queue, center)
		if not center.edition or (center.edition and not center.edition.kwjk_oceanic) then
			info_queue[#info_queue + 1] = G.P_CENTERS.e_kwjk_oceanic
		end
		return { vars = { center.ability.extra.xmult } }
	end,
	credit = {
		art = "Kowa",
		code = "Jevonn, Kowa",
		concept = "Kowa"
	},
	set_ability = function(self, card, initial, delay_sprites)
		card:set_edition("e_kwjk_oceanic", true, true) -- makes sure it's always oceanic
	end,
	rarity = 1,
	cost = 1,
	blueprint_compat = true,
	demicoloncompat = true,
	calculate = function(self, card, context) -- tbh i have no damn idea how to code this myself (thank you gpl3.0 license)
		if
			context.other_joker
			and context.other_joker.edition
			and context.other_joker.edition.kwjk_oceanic == true
			and card ~= context.other_joker
		then
			if not Talisman.config_file.disable_anims then
				G.E_MANAGER:add_event(Event({
					func = function()
						context.other_joker:juice_up(0.5, 0.5)
						return true
					end,
				}))
			end
			return {
				message = localize({
					type = "variable",
					key = "a_xmult",
					vars = { number_format(card.ability.extra.xmult) },
				}),
				xmult = lenient_bignum(card.ability.extra.xmult),
			}
		end
		if context.individual and context.cardarea == G.play then
			if context.other_card.edition and context.other_card.edition.kwjk_oceanic == true then
				return {
					xmult = lenient_bignum(card.ability.extra.xmult),
					colour = G.C.MULT,
					card = card,
				}
			end
		end
		if
			context.individual
			and context.cardarea == G.hand
			and context.other_card.edition
			and context.other_card.edition.kwjk_oceanic == true
			and not context.end_of_round
		then
			if context.other_card.debuff then
				return {
					message = localize("k_debuffed"),
					colour = G.C.RED,
					card = card,
				}
			else
				return {
					h_x_mult = lenient_bignum(card.ability.extra.xmult),
					card = card,
				}
			end
		end
		if context.forcetrigger then
			return {
				xmult = lenient_bignum(card.ability.extra.xmult),
				colour = G.C.MULT,
				card = card,
			}
		end
	end
}