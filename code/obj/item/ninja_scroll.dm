//Scroll that makes you ninja (Nuke Op Ninja class)
/obj/item/ninja_scroll
	icon = 'icons/obj/dojo.dmi'
	name = "ninja scroll"
	icon_state = "scroll"
	desc = "A device that delivers equipment directly onto the user."

	attack_self(mob/user as mob)
		if(!ishuman(user))
			boutput(user, "<span class='alert'>The scroll won't open!</span>")
			return
		var/mob/living/carbon/human/H = user
		boutput(user, "<span class='notice'>As you open the scroll, knowledge of the ninja arts awakens within you.</span>")
		// equip items, grant abilities
		H.drop_from_slot(H.wear_suit)
		H.drop_from_slot(H.shoes)
		H.drop_from_slot(H.head)
		H.equip_new_if_possible(/obj/item/clothing/suit/space/syndicate/specialist/ninja, H.slot_wear_suit)
		H.equip_new_if_possible(/obj/item/clothing/shoes/ninja, H.slot_shoes)
		H.equip_new_if_possible(/obj/item/clothing/head/helmet/space/syndicate/specialist/ninja, H.slot_head)
		APPLY_MOVEMENT_MODIFIER(H, /datum/movement_modifier/ninja, src.type)
		APPLY_MOB_PROPERTY(H, PROP_JUMP_TABLES, src)
		qdel(src)
