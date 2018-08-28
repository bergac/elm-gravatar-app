module Snippets exposing (addNumbers, addTwo)


addNumbers : Int -> Int -> Int
addNumbers a b =
    a + b


addTwo : Int -> Int
addTwo =
    addNumbers 2


type alias Employee =
    { name : String
    , salary : Int
    }


type alias Company =
    { name : String
    , employees : List Employee
    }
