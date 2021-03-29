#lang pl

#|------------------------------------Q1---------------------------------------------|#

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


#|------------------------------------Q2---------------------------------------------|#


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



#| Question 2.c
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
|#

#|-------------------------------------Q3---------------------------------------------|#


#| Question 3.1 && 3.2
In both of these sections I created a new type called KeyStack.
It has 2 constructors:
EmptyKS- A constructor that represents an empty stack.
Push- accepts 3 things as input (symbol, string and KeyStack)
and returns an extended keystack in the natural
|#
(define-type KeyStack
  [EmptyKS] ;; 3.1
  [Push Symbol String KeyStack]) ;;3.2


#| Question 3.3
This function accepts as input Symbol and a KeyStack and return the first
value that is keyed accordingly.
If the key does not appear in the original stack, it should return a #f value.
To do this I checked if the stack I received was of type EmptyKS or Push.
If it is a Push type,I checked whether the keys are the same, if yes-
i return the string linked to it, otherwise i will recursively call the search-stack
function until we find the key.if the key wat not found - i will return #f. |#
(: search-stack  : (Symbol KeyStack -> (U String False)) )
(define (search-stack smbl stck)
  (cases stck
    [(EmptyKS) #f] ;; if the stack is empy- return false 
    [(Push smb str mySTCK ) ;; the stak is not empty-
     (if(eq? smb smbl)
        str
        (search-stack smbl mySTCK))]))

(test (search-stack 'a (Push 'a "AAA" (Push 'b "B" (Push 'a "A" (EmptyKS))))) => "AAA")
(test (search-stack 'c (Push 'a "AAA" (Push 'b "B" (Push 'a "A" (EmptyKS))))) => #f)
(test (search-stack 'c (Push 'd "AAA" (Push 'b "B" (Push 'c "A" (EmptyKS))))) => "A")
(test (search-stack 'e (Push 'e "100" (Push 'e "B" (Push 'e "A" (EmptyKS))))) => "100")
(test (search-stack 'y (Push 'a "jin" (Push 'y "hector" (Push 'a "A" (EmptyKS))))) => "hector")



#| Question 3.4
This function accepts as input a KeyStack and return the keyed-stack without
its first value.
If the original stack was empty, it should return a #f value.
To do this I checked if the stack I received was of type EmptyKS or Push.
If it is a Push type,I return the rest of the stack (without the first value).
Otherwise - this means the stack is empty so we will return #F value. |#

(: pop-stack  : (KeyStack -> (U KeyStack False)))
(define (pop-stack stck)
  (cases stck
     [(EmptyKS) #f] ;; if the stack is empy- return false 
    [(Push smb str rest_mySTCK )rest_mySTCK])) ;; else-the stack is not empty

(test (pop-stack (EmptyKS)) => #f) 
(test (pop-stack (Push 'a "AAA" (Push 'b "B" (Push 'a "A" (EmptyKS))))) =>
                                                 (Push 'b "B" (Push 'a "A" (EmptyKS))))
(test (pop-stack (Push 'd "racket" (Push 'c "f" (Push 'c "F" (EmptyKS))))) =>
                                                 (Push 'c "f" (Push 'c "F" (EmptyKS))))
(test (pop-stack (Push 'S "SDF" (Push 'b "B" (Push 'b "B" (EmptyKS))))) =>
                                                 (Push 'b "B" (Push 'b "B" (EmptyKS))))


#|------------------------------------Q4---------------------------------------------|#


(: is-odd? : Natural -> Boolean)
#|
input: x that is a Natural Number.
output: true if x is odd Natural Number, otherwise- false.
This method checks whether the number we got is odd or not.
To check that, 'is-odd?' function works recursively as follows:
-If x is equal to '0' then x is even number so the need to return false (stop condition).
-If we got an odd number,we called the is-even?(X-1) function, Which will call is-odd(x-1)
and so on and so forth until it enters the 'is-even?' function for the last time that it returns
true for the odd number we got.
-If we got an even number,we called the is-even?(X-1) function, Which will call is-odd(x-1)
and so on and so forth until it enters the 'is-odd?' function for the last time that it returns
false for the even number we got.       
|#

(define (is-odd? x)
 (if (zero? x)
 false
 (is-even? (- x 1))))

(: is-even? : Natural -> Boolean)
#|
input: x that is a Natural Number.
output: true if x is even Natural Number, otherwise- false.
This method checks whether the number we got is even or not.
To check that, 'is-even?' function works recursively as follows:
-If x is equal to '0' then x is even number so the need to return true (stop condition).
-If we got an odd number,we called the is-odd?(X-1) function, Which will call is-even(x-1)
and so on and so forth until it enters the 'is-odd?' function for the last time that it returns
false for the odd number we got.
-If we got an even number,we called the is-odd?(X-1) function, Which will call is-even(x-1)
and so on and so forth until it enters the 'is-even?' function for the last time that it returns
true for the even number we got.       
|#
(define (is-even? x)
 (if (zero? x)
 true
 (is-odd? (- x 1))))

;; tests --- is-odd?/is-even?
(test (not (is-odd? 12)))
(test (is-even? 12))
(test (not (is-odd? 0)))
(test (is-even? 0))
(test (is-odd? 1))
(test (not (is-even? 1)))


(: every? : (All (A) (A -> Boolean) (Listof A) -> Boolean))
;; See explanation about the All syntax at the end of the file…
;; << Add your comments here>>
;; << Add your comments here>>
(define (every? pred lst)
 (or (null? lst)
 (and (pred (first lst))
 (every? pred (rest lst)))))
;; An example for the usefulness of this polymorphic function
(: all-even? : (Listof Natural) -> Boolean)
;; << Add your comments here>>
;; << Add your comments here>>
(define (all-even? lst)
 (every? is-even? lst))
;; tests
(test (all-even? null))
(test (all-even? (list 0)))
(test (all-even? (list 2 4 6 8)))
(test (not (all-even? (list 1 3 5 7))))
(test (not (all-even? (list 1))))
(test (not (all-even? (list 2 4 1 6))))
(: every2? : (All (A B) (A -> Boolean) (B -> Boolean) (Listof A) (Listof B) ->
Boolean))
;; << Add your comments here>>
;; << Add your comments here>>
(define (every2? pred1 pred2 lst1 lst2)
 (or (null? lst1) ;; both lists assumed to be of same length
 (and (pred1 (first lst1))
 (pred2 (first lst2))
 (every2? pred1 pred2 (rest lst1) (rest lst2)))))










