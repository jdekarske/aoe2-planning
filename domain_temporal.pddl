(define (domain aoe2)
  (:requirements :strips :typing :fluents :durative-actions :timed-initial-literals)

  (:types
    location society - object
    resource building - location
    town_center barracks - building
    lumber berries sheep gold - resource
  )

  (:predicates
    (working ?l - location)
    (idle ?l - location)
  )

  (:functions
    (idle_villagers ?s - society)
    (train_villager_time ?s - society)

    (workers ?r - resource)
    (walk_time ?r - resource)
    (collect_rate ?r - resource)
    (amount ?r - resource)

  )

  (:durative-action train_villager
    :parameters (?tc - town_center ?s - society)
    :duration (= ?duration (train_villager_time ?s))
    :condition (and
      (at start (idle ?tc))
    )
    :effect (and
      (at start (not (idle ?tc)))
      (at start (working ?tc))
      (at end (idle ?tc))
      (at end (not (working ?tc)))
      (at end (increase (idle_villagers ?s) 1))
    )
  )

  (:durative-action send_idle_to_resource
    :parameters (?r - resource ?s - society)
    :duration (= ?duration (walk_time ?r))
    :condition (and
      (at start (> (idle_villagers ?s) 0))
    )
    :effect (and
      (at start (decrease (idle_villagers ?s) 1))
      (at end (increase (workers ?r) 1))
    )
  )

  (:action send_resource_to_idle
    :parameters (?r - resource ?s - society)
    :precondition (and
      (> (workers ?r) 0)
    )
    :effect (and
      (increase (idle_villagers ?s) 1)
      (decrease (workers ?r) 1)
    )
  )

  (:durative-action collect_resource
    :parameters (?r - resource)
    :duration (= ?duration 10)
    :condition (and
      (at start (> (workers ?r) 0))
      (at start (idle ?r))
      )
    :effect (and
      (at start (not (idle ?r)))
      (at start (working ?r))
      (at end (idle ?r))
      (at end (not (working ?r)))
    (at end (increase (amount ?r) (* (collect_rate ?r)(workers ?r))))
    )
  )
)