//: Playground - noun: a place where people can play

import UIKit

// optional binding

var str = "Hello, playground"

var maybeString: String? = "Hi"

//print(maybeString)

//safe way
if maybeString != nil {
    maybeString!.characters.count //avoid
}

//OR

// safe way, clearer syntax -> way to go
if let defintelyString = maybeString {
    defintelyString.characters.count
} else {
    print("It's nil!")
}

// guard let string = maybeString else { return } -> allows to exit if condition isn't true


//implicitely unwrapped object
var mostLikelyString: String! = "Hey"  //optional but unrwrapped everytime -> but most dangerous
mostLikelyString.characters.count

//---------------------------------------
// optional chaining

class CupHolder {
    var cups:[String]? = nil
}

class Car {
    var cupHolders:CupHolder? = nil
}

let niceCar = Car()
niceCar.cupHolders = CupHolder()
niceCar.cupHolders?.cups = ["Sprite"]

if var cupHolder = niceCar.cupHolders {
    if var cups = cupHolder.cups {
        cups.append("Coke")
    } else {
        cupHolder.cups = ["Coke"]
    }
}

if let cupHolder = niceCar.cupHolders {
    if let cups = cupHolder.cups {
        if (cups[0] == "Coke") {
            print("Yay")
        } else {
            print("Aww")
        }
    }
}

let firstCup = niceCar.cupHolders?.cups?[0] //optional chaining '?' checks if has property. if fails returns nil

if niceCar.cupHolders?.cups?.count > 0 {
    niceCar.cupHolders?.cups?[0] = "Coke"
} else {
    
}

niceCar.cupHolders?.cups?.append("Coke")



