; Tugas Besar 2 IF3170
; Breast Cancer Identification System using CLIPS
; =============================================== 
; Pencipta:
; 13519045 M Reyhanullah Budiaman
; 13519148 Muhammad Atthaumar Rifqy
; ===============================================



; Mean Concave Points (Initial Fact)
; ==================================

(defrule mean-concave-points-rule
	(initial-fact)
=>
	(printout t crlf "Mean concave points? ")
	(assert (mean-concave-points (read)))
)

(defrule mean-concave-points-error
	?error <- (mean-concave-points ?value)
	(test (not(numberp ?value)))
=>
	(retract ?error)
	(printout t "ERROR! Input valid merupakan bilangan")
	(printout t crlf "Mean concave points? ")
	(assert (mean-concave-points (read)))
)


; Worst Radius
; ============

(defrule worst-radius-rule
	(mean-concave-points ?value&
	:(numberp ?value)&
	:(<= ?value 0.05))
=>
	(printout t crlf "Worst radius? ")
	(assert (worst-radius (read))))

(defrule worst-radius-error
	?error <- (worst-radius ?value)
	(test (not(numberp ?value)))
=>
	(retract ?error)
	(printout t "ERROR! Input valid merupakan bilangan")
	(printout t crlf "Worst radius? ")
	(assert (worst-radius (read)))
)


; Worst Perimeter
; ===============

(defrule worst-perimeter-rule
	(mean-concave-points ?value&
	:(numberp ?value)&
	:(> ?value 0.05))
=>
	(printout t crlf "Worst perimeter? ")
	(assert (worst-perimeter (read)))
)

(defrule worst-perimeter-error
	?error <- (worst-perimeter ?value)
	(test (not(numberp ?value)))
=>
	(retract ?error)
	(printout t "ERROR! Input valid merupakan bilangan")
	(printout t crlf "Worst perimeter? ")
	(assert (worst-perimeter (read)))
)

(defrule worst-perimeter-goal-0
	(worst-perimeter ?value&
	:(numberp ?value)&
	:(> ?value 114.45))
=>
	(assert (goal 0))
)


; Mean Texture
; ============

(defrule mean-texture-rule
	(worst-radius ?value&
	:(numberp ?value)&
	:(> ?value 16.83))
=>
	(printout t crlf "Mean texture? ")
	(assert (mean-texture (read)))
)

(defrule mean-texture-error
	?error <- (mean-texture ?value)
	(test (not (numberp ?value)))
=>
	(retract ?error)
	(printout t "ERROR! Input valid merupakan bilangan")
	(printout t crlf "Mean texture? ")
	(assert (mean-texture (read)))
)

(defrule mean-texture-goal-1
	(mean-texture ?value&
	:(numberp ?value)&
	:(<= ?value 16.19))
=>
	(assert (goal 1))
)


; Worst Texture
; =============

(defrule worst-texture-rule
	(worst-perimeter ?value&
	:(numberp ?value)&
	:(<= ?value 114.45))
=>
	(printout t crlf "Worst texture? ")
	(assert (worst-texture (read)))
)

(defrule worst-texture-error
	?error <- (worst-texture ?value)
	(test (not (numberp ?value)))
=>
	(retract ?error)
	(printout t "ERROR! Input valid merupakan bilangan")
	(printout t crlf "Worst texture? ")
	(assert (worst-texture (read)))
)


; Concave Points Error
; ====================

(defrule concave-points-error-rule
	(mean-texture ?value&
	:(numberp ?value)&
	:(> ?value 16.19))
=>
	(printout t crlf "Concave points error? ")
	(assert (concave-points-error (read)))
)

(defrule concave-points-error-error
	?error <- (concave-points-error ?value)
	(test (not (numberp ?value)))
=>
	(retract ?error)
	(printout t "ERROR! Input valid merupakan bilangan")
	(printout t crlf "Concave points error? ")
	(assert (concave-points-error (read)))
)

(defrule concave-points-error-goal-0
	(concave-points-error ?value&
	:(numberp ?value)&
	:(<= ?value 0.01))
=>
	(assert (goal 0))
)

(defrule concave-points-error-goal-1
	(concave-points-error ?value&
	:(numberp ?value)&
	:(> ?value 0.01))
=>
	(assert (goal 1))
)


; Worst Concave Points
; ====================

(defrule worst-concave-points-rule
	(worst-texture ?value&
	:(numberp ?value)&
	:(<= ?value 25.65))
=>
	(printout t crlf "Worst concave points? ")
	(assert (worst-concave-points (read)))
)

(defrule worst-concave-points-error
	?error <- (worst-concave-points ?value)
	(test (not (numberp ?value)))
=>
	(retract ?error)
	(printout t "ERROR! Input valid merupakan bilangan")
	(printout t crlf "Worst concave points? ")
	(assert (worst-concave-points (read)))
)

(defrule worst-concave-points-goal-0
	(worst-concave-points ?value&
	:(numberp ?value)&
	:(> ?value 0.17))
=>
	(assert (goal 0))
)

(defrule worst-concave-points-goal-1
	(worst-concave-points ?value&
	:(numberp ?value)&
	:(<= ?value 0.17))
=>
	(assert (goal 1))
)


; ====================================================
; Radius Error
; ====================================================
(defrule radius-error
	(worst-radius ?value&
		:(numberp ?value)&
		:(<= ?value 16.83)
	)
=>
	;(retract (worst-radius ?value))
	(printout t "Berapa radius error-nya? ")
	(assert (radius-error (read)))
)

(defrule bad-radius-error
	(declare (salience 10))
	?phase <- (radius-error ?value)
	(test (not (numberp ?value)))
=>
	(retract ?phase)
	(printout t "ERROR! Masukkan angka!!" crlf)	
	(printout t "Berapa radius error-nya? ")
	(assert (radius-error (read)))
)

; ====================================================
; Worst Texture
; ====================================================
(defrule worst-texture-depth4
	(radius-error ?value&
		:(numberp ?value)&
		:(<= ?value 0.63)
	)
=>
	;(retract (radius-error ?value))
	(printout t "Berapa worst texture-nya? ")
	(assert (worst-texture (read)))
)

(defrule bad-worst-texture
	(declare (salience 10))
	?phase <- (worst-texture ?value)
	(test (not (numberp ?value)))
=>
	(retract ?phase)
	(printout t "Masukkan angka!!")	
	(printout t "Berapa worst texture-nya? ")
	(assert (worst-texture (read)))
)

(defrule goal-from-worst-texture
	(radius-error ?value2&
		:(numberp ?value2)&
		:(<= ?value2 0.63)
	)
	(worst-texture ?value&
		:(numberp ?value)&
		:(<= ?value 30.15)	
	)
=>
	(assert (goal 1))
)

; ====================================================
; Worst Area
; ====================================================
(defrule worst-area
	(radius-error ?value2&
		:(numberp ?value2)&
		:(<= ?value2 0.63)
	)
	(worst-texture ?value&
		:(numberp ?value)&
		:(> ?value 30.15)
	)
=>
	;(retract (worst-radius ?value))
	(printout t "Berapa worst area-nya? ")
	(assert (worst-area (read)))
)

(defrule bad-worst-area
	(declare (salience 10))
	?phase <- (worst-area ?value)
	(test (not (numberp ?value)))
=>
	(retract ?phase)
	(printout t "ERROR! Masukkan angka!!" crlf)	
	(printout t "Berapa worst area-nya? ")
	(assert (worst-area (read)))
)

(defrule goal-from-worst-area
	(worst-area ?value&
		:(numberp ?value)&
		:(<= ?value 641.60)	
	)
=>
	(assert (goal 1))
)

; ====================================================
; Mean Radius (Dari Worst Area)
; ====================================================
(defrule mean-radius-depth6
	(worst-area ?value&
		:(numberp ?value)&
		:(> ?value 641.60)
	)
=>
	;(retract (worst-radius ?value))
	(printout t "Berapa mean radius-nya? ")
	(assert (mean-radius (read)))
)

(defrule bad-mean-radius
	(declare (salience 10))
	?phase <- (mean-radius ?value)
	(test (not (numberp ?value)))
=>
	(retract ?phase)
	(printout t "ERROR! Masukkan angka!!" crlf)	
	(printout t "Berapa mean radius-nya? ")
	(assert (mean-radius (read)))
)

(defrule goal-from-mean-radius
	(worst-area ?value&
		:(numberp ?value)&
		:(> ?value 641.60)
	)
	(mean-radius ?value&
		:(numberp ?value)&
		:(> ?value 13.45)	
	)
=>
	(assert (goal 1))
)

; ====================================================
; Mean Texture (Dari Mean Radius)
; ====================================================
(defrule mean-texture-depth7
	(worst-area ?value&
		:(numberp ?value)&
		:(> ?value 641.60)
	)
	(mean-radius ?value2&
		:(numberp ?value2)&
		:(<= ?value2 13.45)
	)
=>
	;(retract (worst-radius ?value))
	(printout t "Berapa mean texture-nya? ")
	(assert (mean-texture (read)))
)

(defrule bad-mean-texture
	(declare (salience 10))
	?phase <- (mean-texture ?value)
	(test (not (numberp ?value)))
=>
	(retract ?phase)
	(printout t "ERROR! Masukkan angka!!" crlf)	
	(printout t "Berapa mean texture-nya? ")
	(assert (mean-texture (read)))
)

(defrule good-goal-from-mean-texture-depth7
	(exists (mean-radius ?))
	(mean-texture ?value&
		:(numberp ?value)&
		:(> ?value 28.79)	
	)
=>
	(assert (goal 1))
)

(defrule bad-goal-from-mean-texture-depth7
	(mean-radius ?value2&
		:(numberp ?value2)&
		:(<= ?value2 13.45)	
	)
	(mean-texture ?value&
		:(numberp ?value)&
		:(<= ?value 28.79)	
	)
=>
	(assert (goal 0))
)

; ====================================================
; Mean Smoothness 
; ====================================================
(defrule mean-smoothness
	(radius-error ?value&
		:(numberp ?value)&
		:(> ?value 0.63)
	)
=>
	;(retract (worst-radius ?value))
	(printout t "Berapa mean smoothness-nya? ")
	(assert (mean-smoothness (read)))
)

(defrule bad-mean-smoothness
	(declare (salience 10))
	?phase <- (mean-smoothness ?value)
	(test (not (numberp ?value)))
=>
	(retract ?phase)
	(printout t "ERROR! Masukkan angka!!" crlf)	
	(printout t "Berapa mean smoothness-nya? ")
	(assert (mean-smoothness (read)))
)

(defrule good-goal-from-mean-smoothness
	(mean-smoothness ?value&
		:(numberp ?value)&
		:(<= ?value 0.09)	
	)
=>
	(assert (goal 1))
)

(defrule bad-goal-from-mean-smoothness
	(mean-smoothness ?value&
		:(numberp ?value)&
		:(> ?value 0.09)	
	)
=>
	(assert (goal 0))
)

; ====================================================
; Perimeter Error
; ====================================================
(defrule perimeter-error
	(worst-perimeter ?value2&
		:(numberp ?value2)&
		:(<= ?value2 114.45)
	)
	(worst-texture ?value&
		:(numberp ?value)&
		:(> ?value 25.65)
	)
=>
	;(retract (worst-radius ?value))
	(printout t "Berapa perimeter error-nya? ")
	(assert (perimeter-error (read)))
)

(defrule bad-perimeter-error
	(declare (salience 10))
	?phase <- (perimeter-error ?value)
	(test (not (numberp ?value)))
=>
	(retract ?phase)
	(printout t "ERROR! Masukkan angka!!" crlf)	
	(printout t "Berapa perimeter error-nya? ")
	(assert (perimeter-error (read)))
)

(defrule goal-from-perimeter-error
	(mean-radius ?value&
		:(numberp ?value)&
		:(> ?value 1.56)	
	)
=>
	(assert (goal 0))
)

; ====================================================
; Mean Radius (Dari Perimeter Error) 
; ====================================================
(defrule mean-radius-depth5
	(perimeter-error ?value&
		:(numberp ?value)&
		:(<= ?value 1.56)
	)
=>
	;(retract (worst-radius ?value))
	(printout t "Berapa mean texture-nya? ")
	(assert (mean-texture (read)))
)

(defrule good-goal-from-mean-radius-depth5
	(perimeter-error ?value&
		:(numberp ?value)&
		:(<= ?value 1.56)
	)
	(mean-radius ?value&
		:(numberp ?value)&
		:(> ?value 13.34)	
	)
=>
	(assert (goal 1))
)

(defrule bad-goal-from-mean-radius-depth5
	(perimeter-error ?value&
		:(numberp ?value)&
		:(<= ?value 1.56)
	)
	(mean-radius ?value&
		:(numberp ?value)&
		:(<= ?value 13.34)	
	)
=>
	(assert (goal 0))
)

; ====================================================
; Hasil Prediksi 
; ====================================================
(defrule positive-breast-cancer
	(goal 1)
=>
	(printout t crlf "Hasil Prediksi : Terprediksi terjangkit Kanker Payudara" crlf)
	;(retract *)
)

(defrule negative-breast-cancer
	(goal 0)
=>
	(printout t crlf "Hasil Prediksi : Terprediksi tidak terjangkit Kanker Payudara" crlf)
	;(retract *)
)