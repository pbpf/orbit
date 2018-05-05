#lang racket
;计算轨道上的特征点
;
;计算轨道总能量
(define(a->energy a mu)
  (* -1 (/ mu 2 a)))
;计算周期
(define(a->T a mu)
  (* 2 pi (sqrt (/ (expt a 3) mu))))

;活力公式计算速度
(define(r->v r mu energy)
  (sqrt (* 2 (+ (/ mu r) energy))))