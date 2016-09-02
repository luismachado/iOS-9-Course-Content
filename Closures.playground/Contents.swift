//: Playground - noun: a place where people can play

import UIKit

func performMagic(thingy: String) -> String {
    return thingy
}

performMagic("Hey")

var magicFunction = performMagic
magicFunction("Hey")

var newMagicFunction = {
    (thingy: String) -> String in
    return thingy
}

var adderFunction: (Int, Int) -> Int = {
    (a: Int, b: Int) -> Int in
    return a + b
}

adderFunction(1, 3)

func doComplicatedStuff(completion: () -> ()) {
    // does crazy stuff
    completion()
}

//doComplicatedStuff { doComplicatedStuff() } // if argument is a callback one can drop the '()'


var b = 3
var scopeAdderFunction: (Int) -> Int = {
    (a: Int) -> Int in
    return a + b
} // captures internal copy

b = 7
scopeAdderFunction(1)

class number {
    var b: Int = 3
}

var aNumber = number()
var anotherAdderFunction: (Int) -> Int = {
    (a: Int) -> Int in
    return a + aNumber.b
}

anotherAdderFunction(1)
aNumber.b = 5
anotherAdderFunction(1)
