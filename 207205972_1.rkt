#lang pl

#| Question 1.1
In this function we get 5 characters and turn them into one string.
To do this, I used the word string which converts some number of characters to string. |#
(: append5 : Char Char Char Char Char -> String)
(define (append5 a b c d e)
  (string a b c d e))
           
(test (append5 #\e #\d #\c #\b #\a) => "edcba")
(test (append5 #\e #\d #\  #\b #\a) => "ed ba")
(test (append5 #\  #\  #\  #\  #\ ) => "     ")
(test (append5 #\A #\R #\# #\^ #\() => "AR#^(")

         
#| Question 1.2 |#
(: permute3 : Char Char Char -> (ListOf(String String String String String String)))
(define (permute3 a b c )
  (list(string a b c) (string a c b) (string b a c)
       (string b c a) (string c a b ) (string c b a)))

(test (permute3 #\a #\b #\c) =>
 '("abc" "acb" "bac" "bca" "cab" "cba"))