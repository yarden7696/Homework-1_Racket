#lang pl

#| Question 1.1
This function receives 5 characters as input and converts them into one string.
To do this I used the word string which turns a finite set of characters into a string.
(: append5 : Char Char Char Char Char -> String)
(define (append5 a b c d e)
  (string a b c d e))
         
(test (append5 #\e #\d #\c #\b #\a) => "edcba")
(test (append5 #\e #\d #\  #\b #\a) => "ed ba")
(test (append5 #\  #\  #\  #\  #\ ) => "     ")
(test (append5 #\A #\R #\# #\^ #\() => "AR#^(")
|#


#| Question 1.2
This function receives 3 characters as input.
The goal is to create all the permutations with the 3 characters
(when all three are always used).
To do this I used the word string which creates a string of characters.
Each string created was inserted into the list of strings I created.|#
(: permute3 : Char Char Char -> (Listof String))
(define (permute3 a b c)
  (list(string a b c) (string a c b) (string b a c)
                      (string b c a) (string c a b) (string c b a)))

(test (permute3 #\a #\b #\c) =>'("abc" "acb" "bac" "bca" "cab" "cba"))
(test (permute3 #\# #\% #\&) =>'("#%&" "#&%" "%#&" "%&#" "&#%" "&%#"))
(test (permute3 #\4 #\5 #\6) =>'("456" "465" "546" "564" "645" "654"))
(test (permute3 #\z #\3 #\@) =>'("z3@" "z@3" "3z@" "3@z" "@z3" "@3z"))












  
