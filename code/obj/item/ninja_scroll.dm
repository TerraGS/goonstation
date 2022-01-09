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
		boutput(user, "<span class='notice'>As you open the scroll, knowledge of the ninja arts awakens within you.</span>")
		// equip items, grant abilities
			qdel(src)
