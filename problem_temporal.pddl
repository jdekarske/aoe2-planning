(define (problem dark_age)
    (:domain aoe2)
    (:requirements :strips :typing :fluents :durative-actions :timed-initial-literals)

    (:objects
        tc1 - town_center
        mysociety - society
        lumber1 - lumber
        sheep1 - sheep
    )

    (:init
        (= (train_villager_time mysociety) 25)
        (= (idle_villagers mysociety) 0)
        (idle tc1)

        (= (workers lumber1) 0)
        (= (walk_time lumber1) 5)
        (= (collect_rate lumber1) 3)
        (= (amount lumber1) 0)
        (idle lumber1)

        (= (workers sheep1) 5)
        (= (walk_time sheep1) 0)
        (= (collect_rate sheep1) 3)
        (= (amount sheep1) 0)
        (idle sheep1)
    )

    (:goal
        (and
            ; (= (idle_villagers mysociety) 1)
            ; (> (workers lumber1) 1)
            (> (amount lumber1) 600)
            (> (amount sheep1) 600)
        )
    )
)