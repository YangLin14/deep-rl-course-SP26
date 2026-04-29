
(define (problem go-fish)
   (:domain action-castle)

   (:objects
      npc - player
      cottage gardenpath fishingpond - location
      in out north south - direction
      pole fish - item
   )

   (:init
      (connected cottage out gardenpath)
      (connected gardenpath in cottage)
      (connected gardenpath south fishingpond)
      (connected fishingpond north gardenpath)
      (at npc cottage)
      (at pole cottage)
      (fishingpole pole)
      (catchable fish)
      (haslake fishingpond)
   )

   (:goal (and (inventory npc fish))))
