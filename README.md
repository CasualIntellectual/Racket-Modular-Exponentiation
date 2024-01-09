# Racket Modular Exponentiation


This was an self-imposed exercise to write a program using properties of modulus (specifically congruence power and congruence multiply/divide)
to more efficiently calculate the modulo of very large exponents.

While a built-in library already exists to do so, this small project was an opportunity for me to apply my Racket and algebra skills to 
try and match the efficiency of (modular-expt) from (require math/number-theory).
```racket
(define (modulo-simplifier base exponent divisor held)
  (local[(define (find-threshold base exponent divisor held)
           (cond[(> held divisor)(find-threshold base exponent divisor (modulo held divisor))]
                [(= 1 exponent)(modulo (* held base) divisor)];congruence multiply
                [(odd? exponent)(find-threshold base (sub1 exponent) divisor (* held base))];congruence divide
                [(> base divisor)(modulo-simplifier base exponent divisor held)]
                [(< base divisor)(find-threshold (sqr base)(/ exponent 2) divisor held)]))]
        ;;mutual recursion is used when the base is smaller that the divisor 
  (cond[(= base 1) 1]
       [(= base 0) 0];base cases
       [(> base divisor)
        (modulo-simplifier (modulo base divisor) exponent divisor held)];congruence power
       [(< base divisor)
        (find-threshold base exponent divisor held)])))
```
