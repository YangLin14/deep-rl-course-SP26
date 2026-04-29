(define (problem purify_water)
   (:domain survive_in_the_woods)

   (:objects
      npc - player
      camp - location
      north south - direction
      water - water
      cloth_filter pot kindling wood - item
   )

   (:init
      (at npc camp)
      (inventory npc water)
      (untreated water)
      (at cloth_filter camp)
      (at pot camp)
      (at kindling camp)
      (at wood camp)
      (cloth cloth_filter)
      (container pot)
      (dry kindling)
      (dry wood)
      (kindling_material kindling)
      (wood_material wood)
   )

   (:goal (and (treated water)))
)
