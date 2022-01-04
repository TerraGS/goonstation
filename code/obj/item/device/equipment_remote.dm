//Prototype device for quickly equipping sets of items and organs.
//Currently coded for Nuke Op Ninja class.
/obj/item/device/equipment_remote
	name = "equipment delivery remote"
	icon_state = "uplink"
	item_state = "signaler"
	desc = "A device that delivers equipment directly onto the user."

	var/single_use = TRUE

	var/list/list_organs = list("heart" = "/obj/item/organ/heart/cyber",
								"left_lung" = "/obj/item/organ/lung/cyber",
								"right_lung" = "/obj/item/organ/lung/cyber",
								"left_kidney" = "/obj/item/organ/kidney/cyber",
								"right_kidney" = "/obj/item/organ/kidney/cyber",
								"liver" = "/obj/item/organ/liver/cyber",
								"spleen" = "/obj/item/organ/spleen/cyber",
								"pancreas" = "/obj/item/organ/pancreas/cyber",
								"stomach" = "/obj/item/organ/stomach/cyber",
								"intestines" = "/obj/item/organ/intestines/cyber",
								"appendix" = "/obj/item/organ/appendix/cyber",
								"r_leg" = "/obj/item/parts/robot_parts/leg/right/standard",
								"l_leg" = "/obj/item/parts/robot_parts/leg/left/standard",
								"r_arm" = "/obj/item/parts/robot_parts/arm/right/standard",
								"l_arm" = "/obj/item/parts/robot_parts/arm/left/standard",
								"butt" = "/obj/item/clothing/head/butt/cyberbutt")

	var/list/list_items = list("suit" = "/obj/item/clothing/suit/space/syndicate/specialist/ninja",
								"shoes" = "/obj/item/clothing/shoes/ninja",
								"head" = "/obj/item/clothing/head/helmet/space/syndicate/specialist/ninja",
								"belt" = "/obj/item/katana_sheath")

	attack_self(mob/user as mob)
		if(!ishuman(user))
			boutput(user, "<span class='alert'>Invalid user species!</span>")
			return
		boutput(user, "<span class='notice'>You activate the [src].</span>")
		equip_organs(list_organs, user)
		equip_items(list_items, user)
		if(single_use)
			qdel(src)

	proc/equip_organs(var/list/replace_organs = null, var/mob/living/carbon/human/H)
		if(isnull(replace_organs) || !H.organHolder)
			return

		var/datum/organHolder/O = H.organHolder

		for(var/to_replace in replace_organs)
			var/obj/item/new_organ = null
			//var/target_organ = null
			var/organ_path = text2path(replace_organs[to_replace])

			if(to_replace in list("heart","left_lung","right_lung","left_kidney","right_kidney","liver","spleen","pancreas","stomach","intestines","appendix","butt"))
				new_organ = new organ_path
				//target_organ = O.get_organ(to_replace)
				O.drop_organ(to_replace)
				O.receive_organ(new_organ, to_replace)
			else if(to_replace in list("r_leg","l_leg","r_arm","l_arm"))
				H?.sever_limb(to_replace)
				H?.limbs.replace_with(to_replace, organ_path, null, 0)

	proc/equip_items(var/list/delivery_slots = null, var/mob/living/carbon/human/H)
		if(isnull(delivery_slots))
			return

		for(var/deliver_item in delivery_slots)
			var/item_path = text2path(delivery_slots[deliver_item])

			if(deliver_item in list("under","suit","shoes","belt","back","gloves","glasses","ears","mask","head","id","r_store","l_store","r_hand","l_hand"))
				switch(deliver_item)
					if("under")
						H.drop_from_slot(H.w_uniform)
						H.equip_new_if_possible(item_path, H.slot_w_uniform)
					if("suit")
						H.drop_from_slot(H.wear_suit)
						H.equip_new_if_possible(item_path, H.slot_wear_suit)
					if("shoes")
						H.drop_from_slot(H.shoes)
						H.equip_new_if_possible(item_path, H.slot_shoes)
					if("belt")
						H.drop_from_slot(H.belt)
						H.equip_new_if_possible(item_path, H.slot_belt)
					if("back")
						H.drop_from_slot(H.back)
						H.equip_new_if_possible(item_path, H.slot_back)
					if("gloves")
						H.drop_from_slot(H.gloves)
						H.equip_new_if_possible(item_path, H.slot_gloves)
					if("glasses")
						H.drop_from_slot(H.glasses)
						H.equip_new_if_possible(item_path, H.slot_glasses)
					if("ears")
						H.drop_from_slot(H.ears)
						H.equip_new_if_possible(item_path, H.ears)
					if("mask")
						H.drop_from_slot(H.wear_mask)
						H.equip_new_if_possible(item_path, H.slot_wear_mask)
					if("head")
						H.drop_from_slot(H.head)
						H.equip_new_if_possible(item_path, H.slot_head)
					if("id")
						H.drop_from_slot(H.wear_id)
						H.equip_new_if_possible(item_path, H.slot_wear_id)
					if("r_store")
						H.drop_from_slot(H.r_store)
						H.equip_new_if_possible(item_path, H.slot_r_store)
					if("l_store")
						H.drop_from_slot(H.l_store)
						H.equip_new_if_possible(item_path, H.slot_l_store)
					if("r_hand")
						H.drop_from_slot(H.r_hand)
						H.equip_new_if_possible(item_path, H.slot_r_hand)
					if("l_hand")
						H.drop_from_slot(H.l_hand)
						H.equip_new_if_possible(item_path, H.slot_l_hand)
