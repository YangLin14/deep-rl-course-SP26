(define (problem build_shelter)
   (:domain survive_in_the_woods)

   (:objects
      npc - player
      camp grove - location
      east west - direction
      knife branches leaves - item
   )

   (:init
      (connected camp east grove)
      (connected grove west camp)
      (at npc camp)
      (at knife camp)
      (at branches grove)
      (at leaves grove)
      (sharp knife)
      (cuttable grove)
      (branch_material branches)
      (leaf_material leaves)
   )

   (:goal (and (sheltered npc)))
)
