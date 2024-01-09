;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname modulo-solver) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

 (require math/number-theory)

;;======================================================

;;This is a simple function designed to optimize the calculation of
;;modulo for exponents using Congruence Power

;;I wrote this short program on the side as an exercise to practice
;;implementing properties of modulo in racket

;;======================================================


;;(modulo-simplifier base exponent divisor) uses Congruence Power to help
;;simplify the modulo so that Racket can handle the calculation

;;Examples:

;;modulo-simplifier: Int Nat Int -> Nat

(define (modulo-simplifier base exponent divisor held)
  (local[(define (find-threshold base exponent divisor held)
           (cond[(> held divisor)(find-threshold base exponent divisor (modulo held divisor))]
                [(= 1 exponent)(modulo (* held base) divisor)]
                [(odd? exponent)(find-threshold base (sub1 exponent) divisor (* held base))]
                [(> base divisor)(modulo-simplifier base exponent divisor held)]
                [(< base divisor)(find-threshold (sqr base)(/ exponent 2) divisor held)]))]
         
  (cond[(= base 1) 1]
       [(= base 0) 0];base cases
       [(> base divisor)
        (modulo-simplifier (modulo base divisor) exponent divisor held)]
       [(< base divisor)
        (find-threshold base exponent divisor held)])))


;;My program matches the built-in modular-expt from the Number Theory library in Racket

(time (modulo-simplifier  3432343234223423445234523452345564564564574234342342 146225134334234232323452345234523423423423412341234123412341234345343523453267674567342525745684745634525 2345234 1))

(time (modular-expt 3432343234223423445234523452345564564564574234342342 146225134334234232323452345234523423423423412341234123412341234345343523453267674567342525745684745634525 2345234 ))




