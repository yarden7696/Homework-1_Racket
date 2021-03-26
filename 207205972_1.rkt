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
Each string created was inserted into the list of strings I created.
(: permute3 : Char Char Char -> (Listof String))
(define (permute3 a b c)
  (list(string a b c) (string a c b) (string b a c)
                      (string b c a) (string c a b) (string c b a)))

(test (permute3 #\a #\b #\c) =>'("abc" "acb" "bac" "bca" "cab" "cba"))
(test (permute3 #\# #\% #\&) =>'("#%&" "#&%" "%#&" "%&#" "&#%" "&%#"))
(test (permute3 #\4 #\5 #\6) =>'("456" "465" "546" "564" "645" "654"))
(test (permute3 #\z #\3 #\@) =>'("z3@" "z@3" "3z@" "3@z" "@z3" "@3z"))
|#


#|-------------------------------------------------------------------------------------|#


#| Question 2.a
This function gets a list that has internal lists with members of different types.
The goal is to check how many internal lists contain exactly 3 elements.
I used helper function that gets a list and counts the number of members in it.

(: list-length : (Listof Any) -> Natural)
(define(list-length lst)
  (if(null? lst)
   0
   (+ 1 (list-length(rest lst)))))
   

(: count-3lists : (Listof (Listof Any)) -> Natural)
(define (count-3lists myList)
  (if(null? myList) ;; stop condition
     0
     (if (= (list-length(first myList)) 3);; if the first list contain exactly 3 elements 
         (+ 1 (count-3lists (rest myList))) ;;count++
         (count-3lists (rest myList)))));;else-the first list doesn't contain exactly 3 elements


(test (count-3lists '((9 3 5) (() (1 2 3)) ("tt" 4 #\E) (2 4 6 8) (1 2 3))) => 3)
(test (count-3lists '((1 5 4) (() (1 2 3) (6)) ("tt" "mom" #\@) (2 4 6 8) (1 2 3))) => 4)
(test (count-3lists '((2 "t" 4) (() () ()) ("tt" "Three" 7) (2 4 6 8) (1 2 3))) => 4)
(test (count-3lists '((2 "t" 4) ((1) (7 8 9) (6 2)))) => 2)
(test (count-3lists '((2 "t" 4) ((1) (7 8 9) (6 2)))) => 2)
(test (count-3lists '((1 2 4) ((3 5) () (6)))) => 2) 
(test (count-3lists '((1 2 4) ((3 5) () 7))) => 2)
(test (count-3lists '((() (1 2 3) (6)) ("tt" "mom" #\@) (2 4 6 8) (1 2 3))) => 3)

;;this 2 test in the second list there is 2 ((...))check if its shoult return 1 or 2?
;;(test (count-3lists '((() () ()) (("tt" "Three" 7)))) => 1)this test pass with res 1
;;(test (count-3lists '((() () ()) (("tt" "Three" 7)))) => 2)this test not pass with res 2

;;(test (count-3lists '((2 "t" 4) 7 8 9)) => 1) this test is not pass      
|# 


#| Question 2.b
As in 2.a, i used the 'list-length-tail' helper function that counts the
number of internal elements in a given list.
The difference between the two sections is that now the function is a tail recursion
that retains the final answer at each stage until we reach the stop conditions.|#

#|An helper function that counts the number of elements in a given list
(: list-length-tail : (Listof Any) -> Natural)
(define(list-length-tail lst)
  (if(null? lst) ;; stop condition
   0
   (+ 1 (list-length-tail(rest lst))))) ;;else- the list is not empty

#|An helper function that saves the result in every stage|#
(: helper-tail : (Listof (Listof Any)) Natural -> Natural)
(define(helper-tail lst acc)
  (if(null? lst);; stop condition
   acc
   (if (= (list-length-tail(first lst)) 3);; if the first list contain exactly 3 elements 
       (helper-tail(rest lst) (+ 1 acc));; count++
       (helper-tail (rest lst) acc))));;else-the first list doesn't contain exactly 3 elements
   
#|Source function|#
(: count-3lists-tail : (Listof (Listof Any)) -> Natural)
(define (count-3lists-tail List_tail)
  (helper-tail List_tail 0)) ;;It's 0 caz I calculate sum and i want it start from 0
 
  
(test (count-3lists-tail '((9 3 5) (() (1 2 3)) ("tt" 4 #\E) (2 4 6 8) (1 2 3))) => 3)
(test (count-3lists-tail '((1 5 4) (() (1 2 3) (6)) ("tt" "mom" #\@) (2 4 6 8) (1 2 3))) => 4)
(test (count-3lists-tail '((2 "t" 4) (() () ()) ("tt" "Three" 7) (2 4 6 8) (1 2 3))) => 4)
(test (count-3lists-tail '((2 "t" 4) ((1) (7 8 9) (6 2)))) => 2)
(test (count-3lists-tail '((2 "t" 4) ((1) (7 8 9) (6 2)))) => 2)
(test (count-3lists-tail '((1 2 4) ((3 5) () (6)))) => 2) 
(test (count-3lists-tail '((1 2 4) ((3 5) () 7))) => 2)

;;this 2 test in the second list there is 2 ((...))check if its shoult return 1 or 2?
;;(test (count-3lists-tail '((() () ()) (("tt" "Three" 7)))) => 1)this test pass with res 1
;;(test (count-3lists-tail '((() () ()) (("tt" "Three" 7)))) => 2)this test not pass with res 2

;;(test (count-3lists-tail '((2 "t" 4) 7 8 9)) => 1) this test is not pass  
|#



#| Question 2.c|#
(: list-length-REC : (Listof Any) -> Natural)
(define(list-length-REC lst)
  (if(null? lst)
   0
   (+ 1 (list-length-REC(rest lst)))))
   
(define (list-of-lists? v)
  (and (list? v) (andmap list? v)))

(: count-3listsRec  : (Listof(Listof Any)) -> Natural)
(define (count-3listsRec myLST)
  (if(null? myLST) ;; stop condition
     0
     #|(if(and(list? (first myLST));; if the first list contain exactly 3 elements 
            (= (list-length-REC (first myLST)) 3)) ;;and its one internal list
         (+ 1 (count-3listsRec (rest myLST))) ;;count++
         (count-3listsRec (rest myLST));; else |#

         
     (if(list-of-lists? (first myLST))
            (and(count-3listsRec(first first myLST))
            (count-3listsRec(first rest myLST))
            (count-3listsRec(rest myLST)))

            (if(= (list-length-REC (first myLST)) 3)
               (+ 1 (count-3listsRec (rest myLST))) ;;count++
               (count-3listsRec (rest myLST))))))
     
           
            
     
   


(test (count-3listsRec '((1 3 4) (() (1 2 3)) ("tt" "Three" 7) (2 4 6 8) (1 2 3))) => 4)



#|-------------------------------------------------------------------------------------|#





