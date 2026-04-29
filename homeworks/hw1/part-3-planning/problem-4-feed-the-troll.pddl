
(define (problem feed-troll)
  (:domain action-castle)

    (:objects
      npc - player
      troll - monster
      cottage gardenpath fishingpond windingpath drawbridge - location
      in out north south east west - direction
      pole fish - item
    )

    (:init
      (connected cottage out gardenpath)
      (connected gardenpath in cottage)
      (connected gardenpath south fishingpond)
      (connected fishingpond north gardenpath)
      (connected gardenpath north windingpath)
      (connected windingpath south gardenpath)
      (connected windingpath east drawbridge)
      (connected drawbridge west windingpath)

      (at npc cottage)
      (at pole cottage)
      (at troll drawbridge)

      (fishingpole pole)
      (catchable fish)
      (haslake fishingpond)
      (hungry troll)
    )

    (:goal (and (not (hungry troll)))))
