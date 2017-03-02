//: Playground - noun: a place where people can play

import UIKit

let image = UIImage(named: "tattoo.JPG")!

var myRGBAImage = RGBAImage(image: image)!

let x = 10
let y = 10
//pixel (10, 10)

//calculate the 1 dimensional index for the pixel
let index = y * myRGBAImage.width + x

//get the pixel!
var pixel = myRGBAImage.pixels[index]

//Read the red, green and blue channel of the pixel
pixel.red
pixel.green
pixel.blue

//change the pixel
pixel.red = 255
pixel.green = 0
pixel.blue = 0

myRGBAImage.pixels[index] = pixel

let newImage = myRGBAImage.toUIImage()