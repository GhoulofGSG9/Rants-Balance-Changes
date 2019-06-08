# Rantology's Balance Changes
**SteamWorks Mod ID**: *6902a269*

This mod contains various balance changes based on various ideas of the NS2 balance team.

Join the official ns2 discord server (discord.gg/ns2) to leave feedback!

## Latest Changes 

### 8/6/2019

- Fixed that the Flame damage type (Cyst & Clog) changes weren't loaded
- Shotgun
    - Reduced damage of center pellet to 15 from 25
    - Increased damage of inner ring's pellets to 17 from 15
    - Increased center offset for inner and outer ring's pellets by 0.1
- ARC
    - Changed ARC's radial damage falloff to use XZ distance (ignore Y (height) axis). So ARCs total damage is consistent and doesn't depend on the height of the main target's model origin.

## All Changes

- Alien
    - Upgrades
        - Camouflage
            - Now de-cloaks completely at max speed
        - Carapace
            - Decreased armor bonus for skulks to 15 (from 20)
            - Decreased armor bonus for lerks to 20 (from 30)
    - Gorge
        - Webs no longer appear in the kill feed
    - Lerk
        - Changed hp to 190/20 from 150/45 (shifting more hp to health)
        - Spikes
            - Increased spread to 3.6 radius (from 3.1)
            - Deceased spike diameter to 0.045 (from 0.06)
        - Umbra
            - Now requires biomass 6 (up from 5)
            - Decreased damage reduction to 20% (from 25%)
            - Decreased umbra cloud life time to 2.5 seconds (from 4)
    - Fade
        - Increased initial blink boost to 15 m/s (from 13.5)
    - Onos
        - Decreased base health to 700 (from 900)
        - Increased biomass health bonus to 50 (from 30)
        - Increase Boneshield Movement Speed to 4.5 (up from 3.3)
        - Boneshield is now available on Biomass 5 (down from Bio 6)
    - Cyst & Clogs
        - Receive 7x direct damage from welders, flame throwers and cluster grenades (up from 2.5x)
    
- Marine
    - Grenades
        - Cluster
            - Now deals 5x damage vs. flammable structures, 2.5x vs. all other structures. Deals 50% damage to players.
            - Now sets targets on fire
            - Burns away umbra, spores and bile bombs
        - Nerve Gas
            - Decreased cloud life time to 4.5 seconds (from 6)
            - Decrease grenade max life time to 7.5 seconds (from 10)
        - Pulse
            - Decreased detonation radius decreased to 1 meter (down from 3)
            - Damage increased to 140 (from 110)
    - Machine Gun
        - Decreased player target damage to 12/13/14/15 from 12/13.2/14.4/15.6
    - Shotgun 
        - Removed damage falloff
        - Change the spread pattern to 13 (1/5/7) pellets total with variable calibers and damage values:
            - 1 pellet in the very center causing 15 dmg and a caliber of 16 mm
            - 5 pellets with a center offset of 0.6 (inner ring) dealing 17 dmg and and a caliber of 16 mm
            - 7 pellets with a center offset of 1.6 (outer ring) dealing 17 dmg and and a caliber of 150 mm
        ![shotgun spread pattern comparision](https://trello-attachments.s3.amazonaws.com/5b4e23748739c1333f6dc499/5cd2cd183bd6e121e8b32aac/5a018569713d8a1f3014a67a516b44f9/327_SG_ranto.png)
    - Mines
        - Damage type changed to Normal (from Light)
        - Damage increased to 150 (from 125)
        - HP increased to 50 (from 30)
        - Mines should no longer detonate when killed while deploying
    - Ammo and Cat Pack
        - Now use the same snap radius as the med pack
    - Nano shield
        - Decreased snap radius to 3 m from 6
        
    - ARC
        - Damage reduced to 530 (from 630)
        - Changed hp to 2600/400 fromm 3000/200 (shifting more hp to armor)
        - Fixed that ARCs didn't save and restore their previous armor value properly when changing their deployment state.
        - Changed ARC's radial damage falloff to use XZ distance (ignore Y (height) axis). So ARCs total damage is consistent and doesn't depend on the height of the main target's model origin.