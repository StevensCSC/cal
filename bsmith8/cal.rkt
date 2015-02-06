;Bradford Smith (bsmith8@stevens.edu)
;cal.rkt
;provides a Racket (Scheme) definition for the bash cal command

#lang racket
;because apparently eopl (which is used in CS135 and CS496) is too basic

(require racket/date) ;we need this guy for doing date things
;(require racket/format) ;might need for string formats (seems to work without)

;cal: [Number]*[Number]->'()
;usage: (cal) displays a calendar of the current month
;   (cal month year) displays a calendar for the given month and year
(define cal
  (lambda ([month (date-month (current-date))]
           [year (date-year (current-date))])
    ;optional month and year parameters
  (display-cal
   (date-week-day (get-date month year))
   month
   (date-day (get-date month year))
   year)))

;get-date: Number*Number->Date*
;   helper function for cal, gets the date struct for the first day of the month
;    for the given month and year
;ASSUMES: month is between 1-12, year is a valid year,
;   all other behavior is undefined
(define (get-date month year) (seconds->date (find-seconds 0
                                                           0
                                                           0
                                                           1
                                                           month
                                                           year
                                                           #t)))

;display-cal: helper function for cal, this one actually does all the formatting
(define (display-cal weekday month day year)
  ;(display (cons (cons (cons weekday month) day) year)) ;debugging statement
  ;(display "\n")
  ;(display (month->string month))
  ;(display " ")
  ;(display year)
  (display-month-year month year)
  (display "\n")
  (display "Su Mo Tu We Th Fr Sa\n")
  (display-nums 1 (modulo (- weekday (- day 1)) 7) (month-days month year) 0))

;display-month-year: Number*Number->'()
;   helper funtion for display-cal, prints the month and year title centered
(define (display-month-year month year)
  (define title (string-append (month->string month) " " (number->string year)))
  (display (~a title #:min-width 20 #:align 'center #:left-pad-string " "
           #:right-pad-string " ")))

;month-days: Number*Number->Number
;   helper function for display-cal, returns the number of days 
;    in a given month and year
(define (month-days month year)
  (cond [(and (eq? month 2) (leap? year)) 29]
        [else (vector-ref #(31 28 31 30 31 30 31 31 30 31 30 31) (- month 1))]))

;leap?: Number->Boolean
;   helper function for month-days, returns a boolean for whether or not the
;    given year is a leap year, #t if it is a leap year, otherwise #f
(define (leap? year)
  (if (eq? (modulo year 4) 0)
      (if (eq? (modulo year 100) 0) 
          (if (eq? (modulo year 400) 0)
              #t ;divisible by 4, 100 and 400
              #f) ;divisible by 4 and 100 but not 400
          #t) ;divisible by 4 but not 100
      #f)) ;not divisible by 4

;month->string: Number->String
;   helper function for display-cal, converts the month number to a string
;ASSUMES: the number will be between 1-12, all other behavior is undefined
(define (month->string month)
  (vector-ref #("January" "February" "March" "April" "May" "June" "July"
                          "August" "September" "October" "November" "December")
              (- month 1)))

;display-nums: Number*Number*Number*Number->'()
;   helper function for display-cal, prints the calendar numbers based on
;    the starting day number (num), offset in calendar days (offset), number
;    of days in the month (end), and how many numbers have already been
;    printed (count)
(define (display-nums num offset end count)
  (cond [(and (> num 1) (eq? (modulo count 7) 0)) (display "\n")])
  ;checked if we need to start a new line (end of a week)
  (cond [(> offset 0) (display "   ") ;offset for days before the month started
                      (display-nums num (- offset 1) end (+ count 1))]
        [(>= num end) (display num)] ;printing the last number
        [(< num 10) (display " ") ; printing a 1 digit number
                    (display num)
                    (display " ")
                    (display-nums (+ num 1) offset end (+ count 1))]
        [else (display num) ;printing a two digit number
              (display " ")
              (display-nums (+ num 1) offset end (+ count 1))]))
