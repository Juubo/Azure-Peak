///////////////////////////
// Miracle Related Buffs //
///////////////////////////

//anything the gods give you should go here if its not a specific god. healing buffs should go into miraclehealingbuff.dm

/datum/status_effect/buff/blessed
	id = "blessed"
	alert_type = /atom/movable/screen/alert/status_effect/buff/blessed
	effectedstats = list("fortune" = 1)
	duration = 20 MINUTES

/atom/movable/screen/alert/status_effect/buff/blessed
	name = "Blessed"
	desc = ""
	icon_state = "buff"

/atom/movable/screen/alert/status_effect/buff/fortify
	name = "Fortifying Miracle"
	desc = "Divine intervention bolsters me and aids my recovery."
	icon_state = "buff"

/datum/status_effect/buff/fortify //Increases all healing while it lasts.
	id = "fortify"
	alert_type = /atom/movable/screen/alert/status_effect/buff/fortify
	duration = 1 MINUTES

/atom/movable/screen/alert/status_effect/buff/convergence
	name = "Convergence Miracle"
	desc = "My body converges to whence it found strength and health."
	icon_state = "buff"

/datum/status_effect/buff/convergence //Increases all healing while it lasts.
	id = "convergence"
	alert_type = /atom/movable/screen/alert/status_effect/buff/convergence
	duration = 1 MINUTES

/atom/movable/screen/alert/status_effect/buff/stasis
	name = "Stasis Miracle"
	desc = "A part of me has been put in stasis."
	icon_state = "buff"

/datum/status_effect/buff/stasis //Increases all healing while it lasts.
	id = "stasis"
	alert_type = /atom/movable/screen/alert/status_effect/buff/stasis
	duration = 10 SECONDS

/atom/movable/screen/alert/status_effect/buff/censerbuff
	name = "Inspired by SYON."
	desc = "The shard of the great comet had inspired me to ENDURE."
	icon_state = "censerbuff"

/datum/status_effect/buff/censerbuff
	id = "censer"
	alert_type = /atom/movable/screen/alert/status_effect/buff/censerbuff
	duration = 15 MINUTES
	effectedstats = list("endurance" = 1, "constitution" = 1)

/datum/status_effect/buff/sermon
	id = "sermon"
	alert_type = /atom/movable/screen/alert/status_effect/buff/sermon
	effectedstats = list("fortune" = 1, "constitution" = 1, "endurance" = 1, "intelligence" = 2)
	duration = 20 MINUTES

/atom/movable/screen/alert/status_effect/buff/sermon
	name = "sermon"
	desc = "I feel inspired by the sermon!"
	icon_state = "buff"

















