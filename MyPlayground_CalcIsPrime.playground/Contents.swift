//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

func isPrime(number:Int)->Bool {
    if number == 2 || number == 3 {
        return false
    }
    if number % 2 == 0 || number % 3 == 0 {
        return false
    }
    
    var i = 5, w = 3
    
    while i * i <= number {
        if number % i == 0 {
            return false
        }
        i += w
        w = 6 - w
    }
    
    return true
}

isPrime(1312345393)