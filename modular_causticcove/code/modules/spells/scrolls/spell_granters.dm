/obj/item/book/granter/spell/blackstone/sizespell // Enlarge/Reduce Size Spell
	name = "Scroll of Reduce/Enlarge"
	spell = /obj/effect/proc_holder/spell/targeted/touch/sizespell
	spellname = "Reduce/Enlarge"
	icon_state ="scrolldarkred"
	oneuse = TRUE

/obj/item/book/granter/spell/blackstone/mirror_transform // Mirror Transform Spell
    name = "Scroll of Mirror Transform"
    spell = /datum/action/cooldown/spell/mirror_transform
    spellname = "Mirror Transform"
    icon_state ="scrolldarkred"
    oneuse = TRUE

/obj/item/book/granter/spell/blackstone/sizespell/loadout // Loadout specific ones!
	needLit = FALSE

/obj/item/book/granter/spell/blackstone/mirror_transform/loadout // Mirror Transform Spell
    needLit = FALSE
