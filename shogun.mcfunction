#Проверка ударов
execute as @a[scores={DamageDealt=1..}] run function wx:shogun/katana/check_katana_hit
execute as @a[scores={KatanaHits=3..},nbt={SelectedItem:{components:{"minecraft:custom_data":{RoninKatana: 1b}}}}] run effect give @s speed 2 0 true
execute as @a[scores={KatanaHits=1..}] run scoreboard players add @s KatanaHitRemove 1
execute as @a[scores={KatanaHits=1..}] unless items entity @s weapon.mainhand minecraft:diamond_sword[minecraft:custom_data~{Katana: 1b}] run scoreboard players add @s KatanaHitRemove 4
execute as @a[scores={KatanaHitRemove=100..}] run function wx:shogun/katana/hitremove
execute as @a[scores={KatanaHits=6..}] unless items entity @s weapon.mainhand minecraft:diamond_sword[minecraft:custom_data~{ShogunKatana: 1b}] run scoreboard players add @s KatanaHitRemove 20

#Бонусный урон
execute as @a if items entity @s weapon.mainhand minecraft:diamond_sword[minecraft:custom_data~{Katana: 1b}] unless items entity @s weapon.mainhand minecraft:diamond_sword[minecraft:custom_data~{BrokenKatana: 1b}] store result score @s KatanaDamageBonus run scoreboard players get @s KatanaHits
execute as @a if items entity @s weapon.mainhand minecraft:diamond_sword[minecraft:custom_data~{Katana: 1b}] unless items entity @s weapon.mainhand minecraft:diamond_sword[minecraft:custom_data~{BrokenKatana: 1b}] run scoreboard players add @s KatanaDamageBonus 3
execute as @a if items entity @s weapon.mainhand minecraft:diamond_sword[minecraft:custom_data~{RoninKatana: 1b}] unless items entity @s weapon.mainhand minecraft:diamond_sword[minecraft:custom_data~{BrokenKatana: 1b}] run scoreboard players add @s KatanaDamageBonus 1
execute as @a if items entity @s weapon.mainhand minecraft:diamond_sword[minecraft:custom_data~{Katana: 1b}] unless items entity @s weapon.mainhand minecraft:diamond_sword[minecraft:custom_data~{BrokenKatana: 1b}] run item modify entity @s weapon.mainhand wx:katana/katana_attack_damage

#Проверка щита
execute as @a if items entity @s weapon.mainhand minecraft:diamond_sword[minecraft:custom_data~{Katana:1b}] if items entity @s weapon.offhand minecraft:shield run item modify entity @s weapon.mainhand wx:katana/shield
execute as @a if items entity @s weapon.mainhand minecraft:diamond_sword[minecraft:custom_data~{Katana:1b}] unless items entity @s weapon.offhand minecraft:shield run item modify entity @s weapon.mainhand wx:katana/no_shield

#Проверка прочности катаны
execute as @a if items entity @s weapon.mainhand minecraft:diamond_sword[minecraft:custom_data~{RoninKatana: 1b}] store result score @s KatanaDamaged run data get entity @s SelectedItem.components.minecraft:damage 1
execute as @a[scores={KatanaDamaged=1559..}] if items entity @s weapon.mainhand minecraft:diamond_sword[minecraft:custom_data~{RoninKatana: 1b}] unless items entity @s weapon.mainhand minecraft:diamond_sword[minecraft:custom_data~{BrokenKatana: 1b}] run item modify entity @s weapon.mainhand wx:katana/katana_break
execute as @a[scores={KatanaDamaged=..1559}] if items entity @s weapon.mainhand minecraft:diamond_sword[minecraft:custom_data~{RoninKatana: 1b, BrokenKatana: 1b}] run item modify entity @s weapon.mainhand wx:katana/katana_repair

#Активации пкм (съедобный меч)
execute as @a[nbt={SelectedItem:{components:{"minecraft:custom_data":{RoninKatana: 1b}}},OnGround:1b},scores={KatanaHits=5..},x_rotation=-15..90] unless items entity @s weapon.mainhand minecraft:diamond_sword[minecraft:custom_data~{BrokenKatana: 1b}] unless items entity @s weapon.offhand minecraft:shield run item modify entity @s weapon.mainhand wx:katana/katana_edible
execute as @a if items entity @s weapon.mainhand minecraft:diamond_sword[minecraft:custom_data~{Katana: 1b}] unless entity @s[scores={KatanaHits=5..},x_rotation=-15..90,nbt={OnGround:1b}] run item modify entity @s weapon.mainhand wx:katana/katana_normal
execute as @a if items entity @s weapon.mainhand minecraft:diamond_sword[minecraft:custom_data~{Katana: 1b}] if items entity @s weapon.offhand minecraft:shield run item modify entity @s weapon.mainhand wx:katana/katana_normal

#Активация рывка
execute as @a[scores={DashDelay=0,RoninDash=1..}] if items entity @s weapon.mainhand minecraft:diamond_sword[minecraft:custom_data~{Katana: 1b}] run function wx:shogun/katana/ronin_dash
execute as @a[scores={DashDelay=1..}] run scoreboard players remove @s DashDelay 1
execute as @a[scores={RoninDash=1..}] unless items entity @s weapon.mainhand minecraft:diamond_sword[minecraft:custom_data~{RoninKatana: 1b}] at @s run kill @e[type=armor_stand,tag=ronin_dash,limit=1,sort=nearest]
execute as @a[scores={RoninDash=1..}] unless items entity @s weapon.mainhand minecraft:diamond_sword[minecraft:custom_data~{RoninKatana: 1b}] run scoreboard players set @s RoninDash 0

#Визуальный счётчик ударов
execute as @a[scores={KatanaCooldown=1..}] run scoreboard players remove @s KatanaCooldown 1
execute as @a[scores={KatanaHits=..-1}] run scoreboard players set @s KatanaHits 0
execute as @a[scores={KatanaHits=0,KatanaCooldown=0}] if items entity @s weapon.mainhand minecraft:diamond_sword[minecraft:custom_data~{Katana: 1b}] run title @s actionbar {"text":"░░░░░","color":"gray"}
execute as @a[scores={KatanaHits=1,KatanaCooldown=0}] if items entity @s weapon.mainhand minecraft:diamond_sword[minecraft:custom_data~{Katana: 1b}] run title @s actionbar {"text": "░","color": "yellow","extra": [{"text": "░░░░","color": "gray"}]}
execute as @a[scores={KatanaHits=2,KatanaCooldown=0}] if items entity @s weapon.mainhand minecraft:diamond_sword[minecraft:custom_data~{Katana: 1b}] run title @s actionbar {"text": "░░","color": "yellow","extra": [{"text": "░░░","color": "gray"}]}
execute as @a[scores={KatanaHits=3,KatanaCooldown=0}] if items entity @s weapon.mainhand minecraft:diamond_sword[minecraft:custom_data~{Katana: 1b}] run title @s actionbar {"text": "░░░","color": "yellow","extra": [{"text": "░░","color": "gray"}]}
execute as @a[scores={KatanaHits=4,KatanaCooldown=0}] if items entity @s weapon.mainhand minecraft:diamond_sword[minecraft:custom_data~{Katana: 1b}] run title @s actionbar {"text": "░░░░","color": "yellow","extra": [{"text": "░","color": "gray"}]}
execute as @a[scores={KatanaHits=5..,KatanaCooldown=0}] if items entity @s weapon.mainhand minecraft:diamond_sword[minecraft:custom_data~{Katana: 1b}] run title @s actionbar {"text": "░░░░░","color": "yellow"}
#Визуальный счётчик кулдауна
execute as @a[scores={KatanaCooldown=1..20}] if items entity @s weapon.mainhand minecraft:diamond_sword[minecraft:custom_data~{Katana: 1b}] run title @s actionbar {"text": "░","color": "dark_gray","extra": [{"text": "░░░░","color": "gray"}]}
execute as @a[scores={KatanaCooldown=21..40}] if items entity @s weapon.mainhand minecraft:diamond_sword[minecraft:custom_data~{Katana: 1b}] run title @s actionbar {"text": "░░","color": "dark_gray","extra": [{"text": "░░░","color": "gray"}]}
execute as @a[scores={KatanaCooldown=41..60}] if items entity @s weapon.mainhand minecraft:diamond_sword[minecraft:custom_data~{Katana: 1b}] run title @s actionbar {"text": "░░░","color": "dark_gray","extra": [{"text": "░░","color": "gray"}]}
execute as @a[scores={KatanaCooldown=61..80}] if items entity @s weapon.mainhand minecraft:diamond_sword[minecraft:custom_data~{Katana: 1b}] run title @s actionbar {"text": "░░░░","color": "dark_gray","extra": [{"text": "░","color": "gray"}]}
execute as @a[scores={KatanaCooldown=81..100}] if items entity @s weapon.mainhand minecraft:diamond_sword[minecraft:custom_data~{Katana: 1b}] run title @s actionbar {"text": "░░░░░","color": "dark_gray"}
#Частицы
execute as @a[scores={KatanaHits=3..}] if items entity @s weapon.mainhand minecraft:diamond_sword[minecraft:custom_data~{RoninKatana: 1b}] at @s run particle minecraft:trial_spawner_detection ~ ~1 ~ 0.2 0.5 0.2 0 1 normal
execute as @a[scores={KatanaHits=5..}] if items entity @s weapon.mainhand minecraft:diamond_sword[minecraft:custom_data~{RoninKatana: 1b}] at @s run particle minecraft:trial_spawner_detection ~ ~1 ~ 0.3 0.5 0.3 0.1 2 normal