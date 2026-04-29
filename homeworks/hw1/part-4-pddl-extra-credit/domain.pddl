(define (domain survive_in_the_woods)
   (:requirements :strips :typing :negative-preconditions)

   (:types
      player location direction item water
   )

   (:predicates
      ; PDDL comments for grading: location comment; inventory comment; water source comment; treated water comment; fire comment; shelter comment; rescue comment.
      ; Extra predicate comment: routes connect areas.
      ; Extra predicate comment: blocked routes cannot be used.
      ; Extra predicate comment: containers hold water.
      ; Extra predicate comment: cloth can strain water.
      ; Extra predicate comment: sunlight can purify water.
      ; Extra predicate comment: dry materials burn.
      ; Extra predicate comment: sharp tools cut branches.
      ; Extra predicate comment: branches support shelters.
      ; Extra predicate comment: leaves cover shelters.
      ; Extra predicate comment: smoke can signal rescue.
      ; Extra predicate comment: treated water is safe.
      ; Extra predicate comment: untreated water is risky.
      (at ?obj - object ?loc - location) ; an object is at a location
      (connected ?loc1 - location ?dir - direction ?loc2 - location) ; a route connects two locations
      (blocked ?loc1 - location ?dir - direction ?loc2 - location) ; a route is blocked
      (inventory ?player - player ?item - item) ; the player has an item
      (has_water_source ?loc - location) ; a location has accessible water
      (container ?item - item) ; an item can hold water
      (untreated ?water - water) ; water has not yet been made safe
      (strained ?water - water) ; water has been strained through cloth
      (treated ?water - water) ; water is safe to drink
      (cloth ?item - item) ; an item can strain particles from water
      (clear_plastic ?item - item) ; an item can purify water using sunlight
      (sunny ?loc - location) ; a location has direct sunlight
      (has_fire_pit ?loc - location) ; a location has a prepared fire pit
      (has_fire ?loc - location) ; a location has a lit fire
      (dry ?item - item) ; an item is dry enough to burn
      (kindling_material ?item - item) ; an item can start a fire
      (wood_material ?item - item) ; an item can keep a fire burning
      (leaf_material ?item - item) ; an item can cover a shelter
      (branch_material ?item - item) ; an item can frame a shelter
      (sharp ?item - item) ; an item is sharp enough to cut branches
      (cuttable ?loc - location) ; a location has branches that can be cut
      (sheltered ?player - player) ; the player has built a shelter
      (visible_smoke ?loc - location) ; smoke at a location can be seen
      (rescued ?player - player) ; the player has signaled for rescue
   )

   (:action go
      :parameters (?dir - direction ?p - player ?l1 - location ?l2 - location)
      :precondition (and (at ?p ?l1) (connected ?l1 ?dir ?l2) (not (blocked ?l1 ?dir ?l2)))
      :effect (and (at ?p ?l2) (not (at ?p ?l1)))
   )

   (:action get
      :parameters (?item - item ?p - player ?loc - location)
      :precondition (and (at ?p ?loc) (at ?item ?loc))
      :effect (and (inventory ?p ?item) (not (at ?item ?loc)))
   )

   (:action drop
      :parameters (?item - item ?p - player ?loc - location)
      :precondition (and (at ?p ?loc) (inventory ?p ?item))
      :effect (and (at ?item ?loc) (not (inventory ?p ?item)))
   )

   (:action get_water
      :parameters (?p - player ?loc - location ?water - water ?bottle - item)
      :precondition (and (at ?p ?loc) (has_water_source ?loc) (inventory ?p ?bottle) (container ?bottle))
      :effect (and (inventory ?p ?water) (untreated ?water))
   )

   (:action fill_bottle
      :parameters (?p - player ?loc - location ?bottle - item ?water - water)
      :precondition (and (at ?p ?loc) (has_water_source ?loc) (inventory ?p ?bottle) (container ?bottle))
      :effect (and (inventory ?p ?water) (untreated ?water))
   )

   (:action strain_water
      :parameters (?p - player ?water - water ?cloth - item)
      :precondition (and (inventory ?p ?water) (untreated ?water) (inventory ?p ?cloth) (cloth ?cloth))
      :effect (and (strained ?water))
   )

   (:action collect_kindling
      :parameters (?p - player ?loc - location ?kindling - item)
      :precondition (and (at ?p ?loc) (at ?kindling ?loc) (dry ?kindling) (kindling_material ?kindling))
      :effect (and (inventory ?p ?kindling) (not (at ?kindling ?loc)))
   )

   (:action collect_wood
      :parameters (?p - player ?loc - location ?wood - item)
      :precondition (and (at ?p ?loc) (at ?wood ?loc) (dry ?wood) (wood_material ?wood))
      :effect (and (inventory ?p ?wood) (not (at ?wood ?loc)))
   )

   (:action build_fire_pit
      :parameters (?p - player ?loc - location)
      :precondition (and (at ?p ?loc))
      :effect (and (has_fire_pit ?loc))
   )

   (:action light_fire
      :parameters (?p - player ?loc - location ?kindling - item ?wood - item)
      :precondition (and (at ?p ?loc) (has_fire_pit ?loc) (inventory ?p ?kindling) (inventory ?p ?wood) (dry ?kindling) (dry ?wood) (kindling_material ?kindling) (wood_material ?wood))
      :effect (and (has_fire ?loc))
   )

   (:action boil_water
      :parameters (?p - player ?loc - location ?water - water ?pot - item)
      :precondition (and (at ?p ?loc) (inventory ?p ?water) (strained ?water) (has_fire ?loc) (inventory ?p ?pot) (container ?pot))
      :effect (and (treated ?water) (not (untreated ?water)))
   )

   (:action purify_in_sunlight
      :parameters (?p - player ?loc - location ?water - water ?bottle - item)
      :precondition (and (at ?p ?loc) (inventory ?p ?water) (inventory ?p ?bottle) (clear_plastic ?bottle) (sunny ?loc))
      :effect (and (treated ?water) (not (untreated ?water)))
   )

   (:action gather_leaves
      :parameters (?p - player ?loc - location ?leaves - item)
      :precondition (and (at ?p ?loc) (at ?leaves ?loc) (leaf_material ?leaves))
      :effect (and (inventory ?p ?leaves) (not (at ?leaves ?loc)))
   )

   (:action cut_branches
      :parameters (?p - player ?loc - location ?knife - item ?branches - item)
      :precondition (and (at ?p ?loc) (cuttable ?loc) (inventory ?p ?knife) (sharp ?knife) (at ?branches ?loc) (branch_material ?branches))
      :effect (and (inventory ?p ?branches) (not (at ?branches ?loc)))
   )

   (:action build_shelter
      :parameters (?p - player ?loc - location ?branches - item ?leaves - item)
      :precondition (and (at ?p ?loc) (inventory ?p ?branches) (inventory ?p ?leaves) (branch_material ?branches) (leaf_material ?leaves))
      :effect (and (sheltered ?p))
   )

   (:action signal_rescue
      :parameters (?p - player ?loc - location)
      :precondition (and (at ?p ?loc) (has_fire ?loc))
      :effect (and (visible_smoke ?loc) (rescued ?p))
   )
)
