# Rantology's Balance Changes
**SteamWorks Mod ID**: *6902a269*

This mod contains various balance changes based on various ideas of the NS2 balance team.

Join the official ns2 discord server (discord.gg/ns2) to leave feedback!

## All Changes

- Alien
    - Upgrades
        - Camouflage
            - Now de-cloaks completely at max speed
        - Carapace
            - Decreased armor bonus for skulks to 15 from 20
            - Decreased armor bonus for lerks to 20 from 30
    - Gorge
        - Webs don't show up in the kill feed anymore
    - Lerk
        - Changed hp to 190/20 from 150/45 (shifting more hp to health)
        - Spikes
            - Increased spread to 3.6 radians from 3.1
            - Deceased spike diameter to 0.045 from 0.06
        - Umbra
            - Requires now biomass 6 instead of 5
            - Decreased damage reduction to 20% from 25%
            - Decreased umbra cloud life time to 2.5 secs from 4
    - Fade
        - Increased initial blink boost to 15 m/s from 13.5
    - Onos
        - Decreased base health to 700 from 900
        - Increased biomass health bonus to 50 from 30
    - Cyst & Clogs
        - Receive 7x direct damage from welders, flame throwers and cluster grenades
    
- Marine
    - Grenades
        - Cluster
            - Deals now 5x damage vs. flammable structures and 2.5x vs. all other structures but only 50% vs. players
            - Sets targets on fire
            - Burns away umbra, spores and bile bombs
        - Nerve Gas
            - Decreased cloud life time to 4.5 secs from 6
            - Decrease grenade max life time to 7.5 secs from 10
        - Pulse
            - Decreased detonation radius to 1 m from 3
    - Machine Gun
        - Decreased player target damage to 12/13/14/15 from 12/13.2/14.4/15.6
    - Shotgun 
        - Removed damage falloff
        - Change the spread pattern to 13 (1/5/7) pellets total with variable sizes and damage values:
        ![shotgun spread pattern comparision](https://trello-attachments.s3.amazonaws.com/5b4e23748739c1333f6dc499/5cd2cd183bd6e121e8b32aac/5a018569713d8a1f3014a67a516b44f9/327_SG_ranto.png)
    - Mines
        - Deals now normal damage instead of light damage
        - Increased base damage to 150
        - Increased hp to 50 from 30
        - Fixed that not yet deployed mines also detonated on destruction
    - Ammo and Cat Pack
        - Now use the same snap radius as the med pack
    - Nano shield
        - Decreased snap radius to 3 m from 6
        
    - ARC
        - Decrease damage to 530 from 630
        - Changed hp to 2600/400 form 3000/200 (shifting more hp to armor)
        - Fixed that ARCs didn't save and restore their previous armor value properly when changing their deployment state.