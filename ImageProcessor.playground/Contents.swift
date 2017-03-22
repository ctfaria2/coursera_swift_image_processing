//: Playground - noun: a place where people can play

import UIKit

let image = UIImage(named: "sample")

// Process the image!

/*
 Filter protocol to be worked with in our ImageProcessor
 */
protocol Filter {

    func doFilter(pixel: Pixel) -> Pixel
}


/*
 Declare the 5 filters that are supported. Each one conforms to the Filter protocol
 */
class TransparancyFilter:Filter {
    
    var option: Int
    
    required init(option: Int) {
        self.option = option
    }
    
    func doFilter(var pixel: Pixel) -> Pixel {
        pixel.alpha = UInt8(max(min(255, self.option), 0))
        return pixel
    }
}
let transparancyFilter = TransparancyFilter(option: 40)

class ColourSubtractFilter:Filter {
    
    var option: Int
    
    required init(option: Int) {
        self.option = option
    }
    
    func doFilter(var pixel: Pixel) -> Pixel {
        pixel.red = subtractColour(pixel.red, modifier: self.option)
        pixel.blue = subtractColour(pixel.blue, modifier: self.option)
        pixel.green = subtractColour(pixel.green, modifier: self.option)
        return pixel
    }
    
    func subtractColour(colour: UInt8, modifier: Int) -> UInt8 {
        return UInt8(max(Int(colour) - Int(modifier), 0))
    }
}
let colourSubtractFilter = ColourSubtractFilter(option: 30)

class BrightenFilter:Filter {
    
    var option: Double
    
    init(option: Double) {
        self.option = option
    }
    
    func doFilter(var pixel: Pixel) -> Pixel {
        pixel.red = min(255, pixel.red * UInt8(option))
        pixel.green = min(255, pixel.green * UInt8(option))
        pixel.blue = min(255, pixel.blue * UInt8(option))
        return pixel
    }
}
let brightenFilter = BrightenFilter(option: 4.5)

class GreenScaleFilter:Filter {
    
    func doFilter(var pixel: Pixel) -> Pixel {
        pixel.red = doGreyScaleMath(pixel.red, multiplier: 0.30)
        pixel.green = doGreyScaleMath(pixel.green, multiplier: 0.59)
        pixel.blue = doGreyScaleMath(pixel.blue, multiplier: 0.11)
        return pixel
    }
    
    func doGreyScaleMath(colour: UInt8, multiplier: Double) -> UInt8 {
        return UInt8(Double(colour) * multiplier)
    }
}
let greenScaleFilter = GreenScaleFilter()

class RemoveColourFilter:Filter {
    
    var option: Int
    
    required init(option: Int) {
        self.option = option
    }
    
    func doFilter(var pixel: Pixel) -> Pixel {
        switch self.option {
        case 0:
            pixel.red = 0
        case 1:
            pixel.green = 0
        case 3:
            pixel.green = 0
        default:
            pixel
        }
        return pixel
    }
}
let removeColourFilter = RemoveColourFilter(option: 0)

/*
 Image Processor Class! Provides ability to toggle filters with option and eventually process 
 image with enabled filters
 */
class ImageProcessor {
    let availableFilters: [String: Filter] = [
        "BrightenFilter": brightenFilter,
        "ColourSubtractFilter": colourSubtractFilter,
        "GreenScaleFilter": greenScaleFilter,
        "RemoveColourFilter": removeColourFilter,
        "TransparencyFilter": transparancyFilter
    ]
    var filters: [Filter] = []
    
    func enableFilter(filterName: String) {
        var filter: Filter? = availableFilters[filterName]
        if (filter != nil) {
            filters.append(filter!)
        } else {
            print("No idea what you are doing!")
        }
    }
    
    func clearFilters() {
        filters = []
    }
    
    func processImage(image: UIImage) -> UIImage {
        var rgbaImage = RGBAImage(image: image)!
        for y in 0..<rgbaImage.height {
            for x in 0..<rgbaImage.width {
                let index = y * rgbaImage.width + x
                for filter in filters {
                    let pixel = rgbaImage.pixels[index]
                    rgbaImage.pixels[index] = filter.doFilter(pixel)
                }
            }
        }
        return rgbaImage.toUIImage()!
    }
}

/*
 Actually process the image!
 */
var processor: ImageProcessor = ImageProcessor()

//Applying Transparency
processor.enableFilter("TransparencyFilter")
var processedImage = processor.processImage(image!)
processedImage

//Clearing filter
processor.clearFilters()

//Applying Brightness
processor.enableFilter("BrightnessFilter")
processedImage = processor.processImage(image!)
processedImage

processor.clearFilters()

//Applying GreenScale
processor.enableFilter("GreenScaleFilter")
processedImage = processor.processImage(image!)
processedImage
processor.clearFilters()

//Applying ColourSubtract
processor.enableFilter("ColourSubtractFilter")
processedImage = processor.processImage(image!)
processedImage

processor.clearFilters()

//Applying RemoveColour
processor.enableFilter("RemoveColourFilter")
processedImage = processor.processImage(image!)
processedImage

