#lang racket
(require "base.rkt")
(provide (all-defined-out))
;orbit-transfer
;提供脉冲推力变轨模型


;提升近地点
(define(transfer-np-up v0 f0 p0 p1 mu)
  ;v0 远地点速度
  ;f0 远地点距离
  ;p0 近地点距离
  ;p1 变轨后的近地点距离
  ;mu 中心引力常数
  (let([a20 (+ f0 p0)];变轨前长轴
       [a21 (+ f0 p1)];变轨后
       )
    (define energy0 (- (/ mu a20)))
    (define energy1 (- (/ mu a21)))
    (define drt_energy (- energy1 energy0));动能改变
    (define v1 (sqrt (+ (sqr v0) (* 2 drt_energy))));
    (- v1 v0)));需要的速度增量

;提升远地点
(define(transfer-fp-up v0 p0 f0 f1 mu)
  ;v0 近地点速度
  ;p0 近地点距离
  ;f0 远地点距离
  ;f1 变轨后的远地点距离
  ;mu 中心引力常数
  (let([a20 (+ p0 f0)];变轨前长轴
       [a21 (+ p0 f1)];变轨后
       )
    (define energy0 (- (/ mu a20)))
    (define energy1 (- (/ mu a21)))
    (define drt_energy (- energy1 energy0));动能改变
    (define v1 (sqrt (+ (sqr v0) (* 2 drt_energy))));
    (- v1 v0)));需要的速度增量

;在远地点轨道圆化
(define(transfer-to-circle v0 f0 p0 mu)
  (transfer-np-up v0 f0 p0 f0 mu))

;相交轨道焦点处改变轨道面
;绕地心连线（由地心指向航天器为正）转动beat弧度,不改变轨道形状
(define(transfer-change-flat v0 Theta beta)
  ;v0 变轨点速度
  ;Theta 变轨点到当地速度倾角，向远离地心为正
  ;beta  轨道面转角
  (* 2 v0  (cos Theta) (sin (/ beta 2))));需要的速度增量
  

;计算两个轨道面(0和1)交线
;取赤道面上方的交线(假设不在赤道面内)
(define(transfer-intersection Omega0 i0 Omega1 i1)
  ;
  (define n0 (orbit-direction Omega0 i0))
  (define n1 (orbit-direction Omega1 i1))
  (cross n0 n1))