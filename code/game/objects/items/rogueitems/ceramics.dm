/* Tools for using with Pottery */

/* Items made from Pottery */

// Uncooked items -- Still need to be brought to a kiln
// Those are all children of natural/clay so that they can inherit the Glaze method.

//Bottle - subtype of glass bottle
/obj/item/natural/clay/claybottle
	name = "unglazed clay bottle"
	icon = 'icons/roguetown/items/cooking.dmi'
	icon_state = "claybottleraw"
	desc = "A bottle fashioned from clay. Still needs to be baked to be useful."
	cooked_type = /obj/item/reagent_containers/glass/bottle/claybottle

/obj/item/reagent_containers/glass/bottle/claybottle
	name = "clay vessel"
	desc = "A ceramic bottle." //The sprite was anything but small
	icon = 'icons/roguetown/items/cooking.dmi'
	icon_state = "claybottlecook"
	volume = 75 // Larger than glass bottle
	sellprice = 6
	reagent_flags = OPENCONTAINER	//So it doesn't appear through
	glazeable = TRUE

//Vase - bigger bottle
/obj/item/natural/clay/clayvase
	name = "unglazed clay vase"
	icon = 'icons/roguetown/items/cooking.dmi'
	icon_state = "clayvaseraw"
	desc = "A vase fashioned from clay. Still needs to be baked to be useful."
	cooked_type = /obj/item/reagent_containers/glass/bottle/claybottle/vase

/obj/item/reagent_containers/glass/bottle/claybottle/vase
	name = "ceramic vase"
	desc = "A large sized ceramic vase."
	icon = 'icons/roguetown/items/cooking.dmi'
	icon_state = "clayvasecook"
	volume = 65 // Larger than glass bottle
	sellprice = 9
	reagent_flags = OPENCONTAINER	//So it doesn't appear through

//Fancy vase - bigger bottle + fancy
/obj/item/natural/clay/clayfancyvase
	name = "unglazed fancy clay vase"
	icon = 'icons/roguetown/items/cooking.dmi'
	icon_state = "clayfancyvaseraw"
	desc = "A fancy vase fashioned from clay. Still needs to be baked to be useful."
	cooked_type = /obj/item/reagent_containers/glass/bottle/claybottle/vase/fancy

/obj/item/reagent_containers/glass/bottle/claybottle/vase/fancy
	name = "fancy ceramic vase"
	desc = "A large sized fancy ceramic vase."
	icon_state = "clayfancyvasecook"
	sellprice = 14

//Flask (was a cup) - subtype of regular cup but can shatter.
/obj/item/natural/clay/claycup
	name = "unglazed clay flask"
	icon = 'icons/roguetown/items/cooking.dmi'
	icon_state = "claycupraw"
	desc = "A small flask fashioned from clay. Still needs to be baked to be useful."
	cooked_type = /obj/item/reagent_containers/glass/cup/claycup

/obj/item/reagent_containers/glass/cup/claycup
	name = "clay flask"
	desc = "A small ceramic flask."
	icon = 'icons/roguetown/items/cooking.dmi'
	icon_state = "claycupcook"
	sellprice = 3
	reagent_flags = OPENCONTAINER	//So it doesn't appear through
	glazeable = TRUE

// Raw teapot
/obj/item/natural/clay/rawteapot
	name = "raw teapot"
	icon = 'icons/roguetown/items/cooking.dmi'
	icon_state = "teapot_raw"
	desc = "A teapot fashioned from clay. Still needs to be baked to be useful."
	cooked_type = /obj/item/reagent_containers/glass/bucket/pot/teapot

// Raw teacup
/obj/item/natural/clay/rawteacup
	name = "raw teacup"
	icon = 'icons/roguetown/items/cooking.dmi'
	icon_state = "teacup_raw"
	desc = "A teacup fashioned from clay. Still needs to be baked to be useful."
	cooked_type = /obj/item/reagent_containers/glass/cup/ceramic

//Bricks - Makes bricks which are used for building. (Need brick-wall sprites for this.. augh..)
/obj/item/natural/clay/claybrick
	name = "uncooked clay brick"
	desc = "An uncooked clay brick. It still needs to be cooked in a kiln."
	icon = 'icons/roguetown/items/cooking.dmi'
	icon_state = "claybrickraw"
	cooked_type = /obj/item/natural/brick

//Statues - Basically cheapest version of the metal-made statues, but way easier to make given no rare material usage. Just skill. Plus, dyeable.
/obj/item/natural/clay/claystatue
	name = "uncooked clay statue"
	desc = "An uncooked clay statue. It still needs to be cooked in a kiln."
	icon = 'icons/roguetown/items/cooking.dmi'
	icon_state = "claystatueraw"
	cooked_type = /obj/item/roguestatue/clay

/obj/item/roguestatue/clay
	name = "ceramic statue"
	desc = "A ceramic statue, shining in its elegance!"
	icon = 'icons/roguetown/items/cooking.dmi'
	icon_state = "claystatuecooked1"
	smeltresult = null	//No resource return
	sellprice = 15		//Iron is worth 20, so these gotta be a little cheaper

/obj/item/roguestatue/clay/Initialize()
	. = ..()
	icon_state = "claystatuecooked[pick(1,2)]"

/obj/item/roguestatue/glass
	name = "glass statue"
	desc = "A statue made of fine glass. An incredible amount of skill must have went into this fragile masterpiece!"
	icon = 'icons/roguetown/items/cooking.dmi'
	icon_state = "statueglass1"
	smeltresult = null	//No resource return
	sellprice = 70		//Silver is roughly 90 mammon, steel is 40. This sits roughly between. It's high skill to make and a bit of a grind so - worth it since resources to make aren't rare..

/obj/item/roguestatue/glass/Initialize()
	. = ..()
	icon_state = "statueglass[pick(1,2)]"


// Caustic Edit start

// Clay pot
/obj/item/natural/clay/claypot
	name = "raw pot"
	icon = 'modular/Neu_Food/icons/cookware/pot.dmi'
	icon_state = "pote_clay_raw"
	desc = "A large pot fashioned from clay. Still needs to be baked to be useful."
	cooked_type = /obj/item/reagent_containers/glass/bucket/pot/clay


/obj/item/reagent_containers/glass/bucket/pot/clay
	name = "clay pot"
	desc = "A pot made out of clay. It can hold a lot of liquid, and makes a satisfying noise when tapped."
	icon_state = "pote_clay"
	volume = 180 // Between stone and iron pots. In terms of soup, it fits 6 ingredients compared to stone's 4, or iron's 8
	glazeable = TRUE

// Clay mug
/obj/item/natural/clay/claymug
	name = "unglazed clay mug"
	icon = 'modular/Neu_Food/icons/cookware/cup.dmi'
	icon_state = "claymugraw"
	desc = "A mug fashioned from clay. Still needs to be baked to be useful."
	cooked_type = /obj/item/reagent_containers/glass/cup/claymug

/obj/item/reagent_containers/glass/cup/claymug
	name = "clay mug"
	desc = "A ceramic mug."
	icon_state = "claymugcook"
	sellprice = 3
	reagent_flags = OPENCONTAINER	//So it doesn't appear through
	glazeable = TRUE

// Clay platter

/obj/item/natural/clay/clayplatter
	name = "raw clay platter"
	icon = 'modular/Neu_Food/icons/cookware/platter.dmi'
	icon_state = "platter_clay_raw"
	desc = "A disc of soft clay. Still needs to be baked to be useful."
	cooked_type = /obj/item/cooking/platter/clay

/obj/item/cooking/platter/clay
	name = "clay platter"
	desc = "A ceramic platter."
	icon_state = "platter_clay_cook"
	sellprice = 2
	glazeable = TRUE

// Clay bowl

/obj/item/natural/clay/claybowl
	name = "raw clay bowl"
	icon = 'modular/Neu_Food/icons/cookware/bowl.dmi'
	icon_state = "bowl_clay_raw"
	desc = "A bowl fashioned from clay. Still needs to be baked to be useful."
	cooked_type = /obj/item/reagent_containers/glass/bowl/clay

/obj/item/reagent_containers/glass/bowl/clay
	name = "clay bowl"
	icon_state = "bowl_clay_cook"
	sellprice = 10
	glazeable = TRUE

// New clay teapot

/obj/item/natural/clay/clayteapot
	name = "raw clay teapot"
	icon = 'modular/Neu_Food/icons/cookware/pot.dmi'
	icon_state = "teapot_clay_raw"
	desc = "A teapot fashioned from clay. Still needs to be baked to be useful."
	cooked_type = /obj/item/reagent_containers/glass/bucket/pot/clayteapot

/obj/item/reagent_containers/glass/bucket/pot/clayteapot
	name = "clay teapot"
	desc = "It's a little teapot, short and stout. Here is its handle, here is its spout."
	dropshrink = 0.9
	icon_state = "teapot_clay_cook"
	fill_icon_thresholds = null
	volume = 90 // 3 ingredients. You could make soup in it, if you're a maniac
	sellprice = 12
	glazeable = TRUE

// New clay teacup
/obj/item/natural/clay/clayteacup
	name = "raw clay teacup"
	icon = 'modular/Neu_Food/icons/cookware/cup.dmi'
	icon_state = "claycupraw"
	desc = "A teacup fashioned from clay. Still needs to be baked to be useful."
	cooked_type = /obj/item/reagent_containers/glass/cup/clayteacup

/obj/item/reagent_containers/glass/cup/clayteacup
	name = "clay teacup"
	desc = "A small cup made of ceramic."
	icon_state = "claycupcook"
	dropshrink = 0.9
	volume = 15
	glazeable = TRUE


// Caustic Edit end
