/datum/species/mush //mush mush codecuck
	name = "\improper Mushroomperson"
	id = "mush"
	mutant_bodyparts = list("caps")
	default_features = list("caps" = "Round", "body_size" = "Normal")
	changesource_flags = MIRROR_BADMIN | WABBAJACK | ERT_SPAWN

	fixed_mut_color = "DBBF92"
	hair_color = "FF4B19" //cap color, spot color uses eye color
	nojumpsuit = TRUE

	say_mod = "poofs" //what does a mushroom sound like
	species_traits = list(MUTCOLORS, NOEYESPRITES,NOFLASH, NO_UNDERWEAR)
	inherent_traits = list(TRAIT_NOBREATH)
	inherent_factions = list("mushroom")
	speedmod = 1.5 //faster than golems but not by much

	punchdamage = 12

	no_equip = list(ITEM_SLOT_MASK, ITEM_SLOT_OCLOTHING, ITEM_SLOT_GLOVES, ITEM_SLOT_FEET, ITEM_SLOT_ICLOTHING)

	burnmod = 1.25
	heatmod = 1.5

	mutanteyes = /obj/item/organ/eyes/night_vision/mushroom
	use_skintones = FALSE
	var/datum/martial_art/mushpunch/mush
	species_language_holder = /datum/language_holder/mushroom

	species_chest = /obj/item/bodypart/chest/mushroom
	species_head = /obj/item/bodypart/head/mushroom
	species_l_arm = /obj/item/bodypart/l_arm/mushroom
	species_r_arm = /obj/item/bodypart/r_arm/mushroom
	species_l_leg = /obj/item/bodypart/l_leg/mushroom
	species_r_leg = /obj/item/bodypart/r_leg/mushroom

/datum/species/mush/check_roundstart_eligible()
	return FALSE //hard locked out of roundstart on the order of design lead kor, this can be removed in the future when planetstation is here OR SOMETHING but right now we have a problem with races.

/datum/species/mush/on_species_gain(mob/living/carbon/C, datum/species/old_species)
	. = ..()
	if(ishuman(C))
		var/mob/living/carbon/human/H = C
		if(!H.dna.features["caps"])
			H.dna.features["caps"] = "Round"
			handle_mutant_bodyparts(H)
		mush = new(null)
		mush.teach(H)

/datum/species/mush/on_species_loss(mob/living/carbon/C)
	. = ..()
	mush.remove(C)
	QDEL_NULL(mush)

/datum/species/mush/handle_chemicals(datum/reagent/chem, mob/living/carbon/human/H)
	if(chem.type == /datum/reagent/toxin/plantbgone/weedkiller)
		H.adjustToxLoss(3)
		H.reagents.remove_reagent(chem.type, REAGENTS_METABOLISM)
		return TRUE
	return ..()

/datum/species/mush/handle_mutant_bodyparts(mob/living/carbon/human/H, forced_colour)
	forced_colour = FALSE
	..()
