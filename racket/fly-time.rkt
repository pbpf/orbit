#lang racket
(provide Kepler-solver
         M->E)
;飞行时间方程

;Kepler 方程 M->E
;0<=e<1
(define(Kepler-solver M e #:precision [eps 1e-16])
  (let loop([E M])
    (let([E1 (+ M (* e (sin E)))])
      (if(< (abs (- E1 E)) eps)
         E1
         (loop E1)))))

(define(M->E M e)
  (Kepler-solver M e))
  