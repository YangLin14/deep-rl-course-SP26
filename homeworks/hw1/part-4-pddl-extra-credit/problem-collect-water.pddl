(define (problem collect_water)
   (:domain survive_in_the_woods)

   (:objects
      npc - player
      camp path waterfall - location
      east west - direction
      canteen - item
      water - water
   )

   (:init
      (connected camp west path)
      (connected path east camp)
      (connected path west waterfall)
      (connected waterfall east path)
      (at npc camp)
      (at canteen camp)
      (container canteen)
      (has_water_source waterfall)
   )

   (:goal (and (inventory npc water)))
)
