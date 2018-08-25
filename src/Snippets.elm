module Snippets exposing (addNumbers, addTwo)


addNumbers : Int -> Int -> Int
addNumbers a b =
    a + b


addTwo : Int -> Int
addTwo =
    addNumbers 2
