//: Playground - noun: a place where people can play

import UIKit

let image = UIImage(named: "tattoo.JPG")!

var myRGBAImage = RGBAImage(image: image)!

/* Commented as the code is not efficient!
var totalRed = 0
var totalGreen = 0
var totalBlue = 0

for x in 0..<myRGBAImage.height {
    for y in 0..<myRGBAImage.width {
        let index = y * myRGBAImage.width + x
        var pixel = myRGBAImage.pixels[index]
        totalRed += Int(pixel.red)
        totalGreen += Int(pixel.green)
        totalBlue += Int(pixel.blue)
    }
}

totalRed
totalGreen
totalBlue

let count = myRGBAImage.height * myRGBAImage.width //40000
let avgRed = totalRed / count //170
let avgGreen = totalGreen / count //148
let avgBlue = totalBlue / count //127
*/

//define avgs calculated before as constants
let avgRed = 170
let avgGreen = 148
let avgBlue = 127

// lets uniform red pixels
for x in 0..<myRGBAImage.height {
    for y in 0..<myRGBAImage.width {
        let index = y * myRGBAImage.width + x
        var pixel = myRGBAImage.pixels[index]
        let redDiff = Int(pixel.red) - avgRed
        if (redDiff > 0) {
            //apply a generic transformation to the red pixel staying within
            //the 0 -> 255 limit
            var redAdjustment = avgRed + redDiff * 5
            redAdjustment = min(255, redAdjustment)
            redAdjustment = max(0, redAdjustment)
            pixel.red = UInt8(redAdjustment)
            myRGBAImage.pixels[index] = pixel
        }
    }
}

var newImage = myRGBAImage.toUIImage()