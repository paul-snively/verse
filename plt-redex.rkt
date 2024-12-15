#lang racket
(require redex)

(define-language L
  (e (e e)
     (λ (x t) e)
     x
     (amb e ...)
     number
     (+ e ...)
     (if0 e e e)
     (fix e))
  (t (→ t t) num)
  (x variable-not-otherwise-mentioned))

; First example
(redex-match
 L
 e
 (term (λ (x) x)))

; Second example
(redex-match
 L
 e
 (term ((λ (x num) (amb x 1))
        (+ 1 2))))

; Third example
(redex-match
 L
 (e_1 e_2)
 (term ((λ (x num) (amb x 1))
        (+ 1 2))))

; Fourth example
(redex-match
 L
 (e_1 ... e_2 e_3 ...)
 (term ((+ 1 2)
        (+ 3 4)
        (+ 5 6))))

; Exercise 1
(redex-match
 L
 ((λ (_ _) e) _)
 (term ((λ (x num) (+ x 1))
  17)))

; Exercise 2
(redex-match
 L
 (→ num t)
 (term (→ num (→ num num))))

; Exercise 3
(redex-match
 L
 (_ ... e_1 e_2 _ ...)
 (term (1 2 3 4)))

; Exercise 4
(redex-match
 L
 (_ ..._1 e_left _ ..._2 _ _ ..._2 e_right _ ..._1)
 (term (1 2 3 4 5)))

; Typing

(define-extended-language L+Γ L
  [Γ · (x : t Γ)])

(define-judgment-form
  L+Γ
  #:mode (types I I O)
  #:contract (types Γ e t)
 
  [(types Γ e_1 (→ t_2 t_3))
   (types Γ e_2 t_2)
   -------------------------
   (types Γ (e_1 e_2) t_3)]
 
  [(types (x : t_1 Γ) e t_2)
   -----------------------------------
   (types Γ (λ (x t_1) e) (→ t_1 t_2))]
 
  [(types Γ e (→ (→ t_1 t_2) (→ t_1 t_2)))
   ---------------------------------------
   (types Γ (fix e) (→ t_1 t_2))]
 
  [---------------------
   (types (x : t Γ) x t)]
 
  [(types Γ x_1 t_1)
   (side-condition (different x_1 x_2))
   ------------------------------------
   (types (x_2 : t_2 Γ) x_1 t_1)]
 
  [(types Γ e num) ...
   -----------------------
   (types Γ (+ e ...) num)]
 
  [--------------------
   (types Γ number num)]
 
  [(types Γ e_1 num)
   (types Γ e_2 t)
   (types Γ e_3 t)
   -----------------------------
   (types Γ (if0 e_1 e_2 e_3) t)]
 
  [(types Γ e num) ...
   --------------------------
   (types Γ (amb e ...) num)])

(judgment-holds
   (types ·
          ((λ (x num) (amb x 1))
           (+ 1 2))
          t)
   t)