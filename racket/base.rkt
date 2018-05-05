#lang racket/base
;(require plot/utils)
;base
(provide a->energy
         a->T
         r->v
         a->n
         dt->M
         mod-2pi
         mod-2pi-for-abs
         orbit-direction
         cross)

(define this-pi 3.141592653589793)
;计算轨道总能量
(define(a->energy a mu)
  (* -1 (/ mu 2 a)))
;计算周期
(define(a->T a mu)
  (* 2 this-pi (sqrt (/ (expt a 3) mu))))

;角速度
(define(a->n a mu)
  (sqrt (/ mu (expt a 3))))

;平近点角
(define(dt->M dt n)
  ;dt 间隔时间
  ;n 平均角速度
  (* n dt))

;活力公式计算速度
(define(r->v r mu energy)
  (sqrt (* 2 (+ (/ mu r) energy))))

;偏近点角到真近点角
(define(E->f E e)
  (define cosf(/ (- (cos E) e) (- 1 (* e (cos E)))))
  (define sinf(/ (* (sqrt (- 1 (square e))) (sin E)) (- 1 (* e (cos E)))))
  (atan sinf cosf))

;真近点角到偏近点角
(define(f->E f e)
  (define cosE (/ (+ e (cos f)) (+ 1 (* e (cos f)))))
  (define sinE (/ (* (sqrt (- 1 (square e))) (sin f))(+ 1 (* e (cos f)))))
  (atan sinE cosE))

;mod2pi
;变换角度范围
(define(mod-2pi x)
    (define t (floor (/ x 2 this-pi)))
    (- x (* t 2 this-pi)))
;-pi -> pi
(define(mod-2pi-for-abs x)
  (define x1 (mod-2pi x))
  (if(> x1 this-pi)
      (- x1 (* 2 this-pi))
     x1))
  
          
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

(define(square x)(* x x))