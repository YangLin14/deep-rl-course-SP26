
(define (domain action-castle)
  (:requirements :strips :negative-preconditions :typing)
  (:types player location direction monster item)

  (:predicates
    (at ?x - object ?l - location)
    (connected ?l1 - location ?dir - direction ?l2 - location)
    (blocked ?l1 - location ?dir - direction ?l2 - location)
    (inventory ?x - object ?i - item)
    (fishingpole ?i - item)
    (catchable ?i - item)
    (haslake ?l - location)
  )

  (:action get
    :parameters (?i - item ?p - player ?l - location)
    :precondition (and (at ?p ?l) (at ?i ?l))
    :effect (and (inventory ?p ?i) (not (at ?i ?l)))
  )

  (:action go
    :parameters (?dir - direction ?p - player ?l1 - location ?l2 - location)
    :precondition (and (at ?p ?l1) (connected ?l1 ?dir ?l2) (not (blocked ?l1 ?dir ?l2)))
    :effect (and (at ?p ?l2) (not (at ?p ?l1)))
  )

  (:action gofish
    :parameters (?pole - item ?p - player ?l - location ?fish - item)
    :precondition (and (at ?p ?l) (inventory ?p ?pole) (fishingpole ?pole) (haslake ?l) (catchable ?fish))
    :effect (and (at ?fish ?l) (not (catchable ?fish)))
  )
)
