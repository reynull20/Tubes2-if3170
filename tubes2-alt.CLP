; Tugas Besar 2 IF3170
; Breast Cancer Identification System using CLIPS
; =============================================== 
; Pencipta:
; 13519045 M Reyhanullah Budiaman
; 13519148 Muhammad Atthaumar Rifqy
; ===============================================
; ===============================================
; Template untuk Kondisi
; ===============================================
(deftemplate condition
	(slot name)
	(slot value)
)


; Pengecekan Input
; ==================================
(defrule bad-input
	(declare (salience 10))
	?phase <- (condition (name ?name) (value ?value))
	(test (not (numberp ?value)))
=>
	(retract ?phase)
	(printout t crlf"ERROR! Masukkan angka!!" crlf)	
	(printout t "Berapa ")
	(printout t ?name)
	(printout t "? ")
	(assert (condition (name ?name) (value (read))))
)


; Mean Concave Points (Initial Fact)
; ==================================
(defrule mean-concave-points-rule
	(initial-fact)
=>
	(retract *)
	(printout t crlf "Mean concave points? ")
	(assert (condition (name mean-concave-points) (value (read))))
)


; Worst Radius
; ============
(defrule worst-radius-rule
	(condition (name mean-concave-points) (value ?value&
	:(numberp ?value)&
	:(<= ?value 0.05)))
=>
	(printout t crlf "Worst radius? ")
	(assert (condition (name worst-radius) (value (read))))
)


; Worst Perimeter
; ===============
(defrule worst-perimeter-rule
	(condition (name mean-concave-points) (value ?value&
	:(numberp ?value)&
	:(> ?value 0.05)))
=>
	(printout t crlf "Worst perimeter? ")
	(assert (condition (name worst-perimeter) (value (read))))
)

(defrule worst-perimeter-goal-0
	(condition (name worst-perimeter) (value ?value&
	:(numberp ?value)&
	:(> ?value 114.45)))
=>
	(assert (goal 0))
)


; Mean Texture
; ============

(defrule mean-texture-rule
	(condition (name worst-radius) (value ?value&
	:(numberp ?value)&
	:(> ?value 16.83)))
=>
	(printout t crlf "Mean texture? ")
	(assert (condition (name mean-texture) (value(read))))
)

(defrule mean-texture-goal-1
	(not (condition (name worst-area) (value ?)))
	(condition (name mean-texture) (value ?value&
	:(numberp ?value)&
	:(<= ?value 16.19)))
=>
	(assert (goal 1))
)


; Worst Texture
; =============
(defrule worst-texture-rule
	(condition (name worst-perimeter) (value ?value&
	:(numberp ?value)&
	:(<= ?value 114.45)))
=>
	(printout t crlf "Worst texture? ")
	(assert (condition (name worst-texture) (value (read))))
)


; Concave Points Error
; ====================
(defrule concave-points-error-rule
	(not (condition (name mean-radius) (value ?)))
	(condition (name mean-texture) (value ?value&
	:(numberp ?value)&
	:(> ?value 16.19)))
=>
	(printout t crlf "Concave points error? ")
	(assert (condition (name concave-points-error) (value (read))))
)

(defrule concave-points-error-goal-0
	(condition (name concave-points-error) (value ?value&
	:(numberp ?value)&
	:(<= ?value 0.01)))
=>
	(assert (goal 0))
)

(defrule concave-points-error-goal-1
	(condition (name concave-points-error) (value ?value&
	:(numberp ?value)&
	:(> ?value 0.01)))
=>
	(assert (goal 1))
)


; Worst Concave Points
; ====================
(defrule worst-concave-points-rule
	(exists (condition (name worst-perimeter) (value ?)))
	(condition (name worst-texture) (value ?value&
	:(numberp ?value)&
	:(<= ?value 25.65)))
=>
	(printout t crlf "Worst concave points? ")
	(assert (condition (name worst-concave-points) (value (read))))
)

(defrule worst-concave-points-goal-0
	(condition (name worst-concave-points) (value ?value&
	:(numberp ?value)&
	:(> ?value 0.17)))
=>
	(assert (goal 0))
)

(defrule worst-concave-points-goal-1
	(condition (name worst-concave-points) (value ?value&
	:(numberp ?value)&
	:(<= ?value 0.17)))
=>
	(assert (goal 1))
)


; Radius Error
; ===============
(defrule radius-error
	(condition 
		(name worst-radius)
		(value ?value&
			:(numberp ?value)&
			:(<= ?value 16.83)
		))
=>
	(printout t crlf "Berapa radius error-nya? ")
	(assert (condition (name radius-error) (value (read))))
)


; Worst Texture
; ===============
(defrule worst-texture-depth4
	(condition (name radius-error) (value ?value&
		:(numberp ?value)&
		:(<= ?value 0.63)
	))
=>
	(printout t crlf "Berapa worst texture-nya? ")
	(assert (condition (name worst-texture) (value (read))))
)

(defrule goal-from-worst-texture
	(condition (name radius-error) (value ?value2&
		:(numberp ?value2)&
		:(<= ?value2 0.63)
	))
	(condition (name worst-texture) (value ?value&
		:(numberp ?value)&
		:(<= ?value 30.15)	
	))
=>
	(assert (goal 1))
)


; Worst Area
; ===============
(defrule worst-area
	(condition (name radius-error) (value ?value2&
		:(numberp ?value2)&
		:(<= ?value2 0.63)
	))
	(condition (name worst-texture) (value ?value&
		:(numberp ?value)&
		:(> ?value 30.15)
	))
=>
	(printout t crlf "Berapa worst area-nya? ")
	(assert (condition (name worst-area) (value (read))))
)

(defrule goal-from-worst-area
	(condition (name worst-area) (value ?value&
		:(numberp ?value)&
		:(<= ?value 641.60)	
	))
=>
	(assert (goal 1))
)


; Mean Radius (Dari Worst Area)
; ===============
(defrule mean-radius-depth6
	(condition (name worst-area) (value ?value&
		:(numberp ?value)&
		:(> ?value 641.60)
	))
=>
	(printout t crlf "Berapa mean radius-nya? ")
	(assert (condition (name mean-radius) (value (read))))
)

(defrule goal-from-mean-radius
	(condition (name worst-area) (value ?value2&
		:(numberp ?value2)&
		:(> ?value2 641.60)
	))
	(condition (name mean-radius) (value ?value&
		:(numberp ?value)&
		:(> ?value 13.45)	
	))
=>
	(assert (goal 1))
)


; Mean Texture (Dari Mean Radius)
; ===============
(defrule mean-texture-depth7
	(condition (name worst-area) (value ?value&
		:(numberp ?value)&
		:(> ?value 641.60)
	))
	(condition (name mean-radius) (value ?value2&
		:(numberp ?value2)&
		:(<= ?value2 13.45)
	))
=>
	(printout t crlf "Berapa mean texture-nya? ")
	(assert (condition (name mean-texture) (value (read))))
)

(defrule good-goal-from-mean-texture-depth7
	(exists (condition (name mean-radius) (value ?)))
	(condition (name mean-texture) (value ?value&
		:(numberp ?value)&
		:(> ?value 28.79)	
	))
=>
	(assert (goal 1))
)

(defrule bad-goal-from-mean-texture-depth7
	(condition (name mean-radius) (value ?value2&
		:(numberp ?value2)&
		:(<= ?value2 13.45)	
	))
	(condition (name mean-texture) (value ?value&
		:(numberp ?value)&
		:(<= ?value 28.79)	
	))
=>
	(assert (goal 0))
)


; Mean Smoothness 
; ===============
(defrule mean-smoothness
	(condition 
		(name radius-error)
		(value ?value&
			:(numberp ?value)&
			:(> ?value 0.63)
		))
=>
	(printout t crlf "Berapa mean smoothness-nya? ")
	(assert (condition (name mean-smoothness) (value (read))))
)

(defrule good-goal-from-mean-smoothness
	(condition (name mean-smoothness) (value ?value&
		:(numberp ?value)&
		:(<= ?value 0.09)	
	))
=>
	(assert (goal 1))
)

(defrule bad-goal-from-mean-smoothness
	(condition (name mean-smoothness) (value ?value&
		:(numberp ?value)&
		:(> ?value 0.09)	
	))
=>
	(assert (goal 0))
)


; Perimeter Error
; ===============
(defrule perimeter-error
	(condition (name worst-perimeter) (value ?value2&
		:(numberp ?value2)&
		:(<= ?value2 114.45)
	))
	(condition (name worst-texture) (value ?value&
		:(numberp ?value)&
		:(> ?value 25.65)
	))
=>
	(printout t crlf "Berapa perimeter error-nya? ")
	(assert (condition (name perimeter-error) (value (read))))
)

(defrule goal-from-perimeter-error
	(condition (name perimeter-error) (value ?value&
		:(numberp ?value)&
		:(> ?value 1.56)	
	))
=>
	(assert (goal 0))
)


; Mean Radius depth 5
; ===============
(defrule mean-radius-depth5
	(condition (name perimeter-error) (value ?value&
		:(numberp ?value)&
		:(<= ?value 1.56)
	))
=>
	(printout t crlf "Berapa mean radius-nya? ")
	(assert (condition (name mean-radius) (value (read))))
)

(defrule good-goal-from-mean-radius-depth5
	(condition (name perimeter-error) (value ?value2&
		:(numberp ?value2)&
		:(<= ?value2 1.56)
	))
	(condition (name mean-radius) (value ?value&
		:(numberp ?value)&
		:(> ?value 13.34)	
	))
=>
	(assert (goal 1))
)

(defrule bad-goal-from-mean-radius-depth5
	(condition (name perimeter-error)(value ?value&
		:(numberp ?value)&
		:(<= ?value 1.56)
	))
	(condition (name mean-radius) (value ?value&
		:(numberp ?value)&
		:(<= ?value 13.34)	
	))
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