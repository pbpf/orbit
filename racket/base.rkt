#lang racket/base
;(require plot/utils)
;base
(provide orbit-direction
         cross)
;轨道面法向量
(define(orbit-direction Omega i)
  (vector (* (sin i) (sin Omega))
          (* -1 (sin i) (cos Omega))
          (cos i)))
;叉积
(define(cross-base x1 y1 z1 x2 y2 z2)
  (define x3 (- (* y1 z2) (* z1 y2)))
  (define y3 (- (* z1 x2) (* x1 z2)))
  (define z3 (- (* x1 y2) (* x2 y1)))
  (vector x3 y3 z3))

(define(cross a b)
  (cross-base (vector-ref a 0)
              (vector-ref a 1)
              (vector-ref a 2)
              ;-----------------
              (vector-ref b 0)
              (vector-ref b 1)
              (vector-ref b 2)
              ))
