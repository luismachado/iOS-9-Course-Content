//: Playground - noun: a place where people can play

import UIKit

// Strings
/*
var str = "Hello, playground"
var name = "Luis"

print("Hello " + name + ".")
print("Hello \(name)")

// Integers

var int:Int = 9
int = int * 2
int = int / 4 // rounds bcause it's an int

var anotherInt = 7
print(int + anotherInt)
print("The value of int is \(int)")

// Doubles

var number:Double = 8.4
print(number*7)
print(number * Double(int))

// Boolean

var isMale:Bool = true



// Test
var myInt:Int = 23
var myDouble:Double = 3.25

var result = Double(myInt) * myDouble

var myString = "The result of multiplying \(myInt) with \(myDouble) is \(result)."
print(myString)*/

// Arrays
/*var array = [17,25,13,47]
print(array[0])
print(array[2])
print(array.count)
array.append(56)
print(array.count)
array.removeAtIndex(3)
array.sort()


var myArray = [5,8,9]
myArray.removeAtIndex(1)
myArray.append(myArray[0]*myArray[1])

Dictionary
var dictionary = ["computer":"something to play COD on", "coffee":"best drink ever"]
print(dictionary["coffee"]!)
print(dictionary.count)
dictionary["pen"] = "used to write"
dictionary.removeValueForKey("computer")

Challenge
var myDictionary = ["pizza": 10.50, "beer" : 2.99, "cake" : 4.50]
var totalCost = myDictionary["pizza"]! + myDictionary["beer"]! + myDictionary["cake"]!
print("The total cost of the 3 items is \(totalCost).")*/

// If Statements

var age = 13

if age >= 18 {
    
    print("You can play!")
    
} else {
    
    print("Sorry, you're too young!")
    
}


var name = "Kirsten"

if name == "Rob" {
    
    print("Hi " + name + " you can play!")
    
} else {
    
    print("Sorry, " + name + " you can't play")
    
}

if name == "Kirsten" && age >= 18 {
    print("You can play!")
}

if name == "Kirsten" || name == "Rob" {
    
    print("Welcome " + name)
    
}

var isMale = true

if isMale {
    print("You are a man!")
}

var username = "xpto1"
var password = "pass1234"

if username == "xpto" && password == "pass123" {
    print("You're in")
} else if username == "xpto" && password != "pass123" {
    print("Your password is wrong")
} else if username != "xpto" && password == "pass123" {
    print("Your username is wrong")
} else {
    print("Both your username and password are wrong")
}








