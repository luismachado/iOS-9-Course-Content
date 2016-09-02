import UIKit

let image = UIImage(named: "sample")!
let rgbaImage = RGBAImage(image: image)!

/*
    FILTER CLASS - CONTAINS ALL THE AVAILABLE FILTERS (STEP 2)
*/

class Filter {
    
    // Make sure if the pixel value is [0,255]
    func checkPixelValue(pixelValue: Double) -> Int {
        if (pixelValue > 255) {
            return 255
        } else if (pixelValue < 0) {
            return 0
        } else {
            return Int(pixelValue)
        }
    }
    
    // Make sure if the pixel value is [0,255]
    func checkPixelValue(pixelValue: Int) -> Int {
        return checkPixelValue(Double(pixelValue))
    }
    
    // FILTER 1: Contrast - strength [-100,100]
    func changeContrast(filterStrength : Int) -> ((RGBAImage) -> RGBAImage) {
        func applyFilter(image : RGBAImage) -> RGBAImage {
            let factor = Double(259 * ((Double(filterStrength) * 2.25) + 255)) / Double(255 * (259 - (Double(filterStrength) * 2.25)))
            
            for y in 0..<image.height{
                for x in 0..<image.width {
                    let index = y * image.height + x
                    var pixel = image.pixels[index]
                    
                    pixel.red = UInt8(checkPixelValue(factor * (Double(pixel.red) - 128) + 128))
                    pixel.green = UInt8(checkPixelValue(factor * (Double(pixel.green) - 128) + 128))
                    pixel.blue = UInt8(checkPixelValue(factor * (Double(pixel.blue) - 128) + 128))
                    image.pixels[index] = pixel
                }
            }
            return image
        }
        return applyFilter
    }

    // FILTER 2: Negative effect - strength [-100,100]
    func applyNegative(filterStrength : Int) -> ((RGBAImage) -> RGBAImage) {
        func applyFilter(image : RGBAImage) -> RGBAImage {
            let factor = Double(259 * ((Double(filterStrength) * 22.5) + 255)) / Double(255 * (259 - (Double(filterStrength) * 22.5)))
            
            for y in 0..<image.height{
                for x in 0..<image.width {
                    let index = y * image.height + x
                    var pixel = image.pixels[index]
                    
                    pixel.red = UInt8(checkPixelValue(factor * (Double(pixel.red) - 128) + 128))
                    pixel.green = UInt8(checkPixelValue(factor * (Double(pixel.green) - 128) + 128))
                    pixel.blue = UInt8(checkPixelValue(factor * (Double(pixel.blue) - 128) + 128))
                    image.pixels[index] = pixel
                }
            }
            return image
        }
        return applyFilter
    }

    // FILTER 3: Brightness - strength [-100,100]
    func changeBrightness(filterStrength : Int) -> ((RGBAImage) -> RGBAImage) {
        func applyFilter(image : RGBAImage) -> RGBAImage {
            
            for y in 0..<image.height{
                for x in 0..<image.width {
                    let index = y * image.height + x
                    var pixel = image.pixels[index]
                    
                    pixel.red = UInt8(checkPixelValue(Double(pixel.red) + Double(filterStrength) * 2.25))
                    pixel.green = UInt8(checkPixelValue(Double(pixel.green) + Double(filterStrength) * 2.25))
                    pixel.blue = UInt8(checkPixelValue(Double(pixel.blue) + Double(filterStrength) * 2.25))
                    image.pixels[index] = pixel
                }
            }
            return image
        }
        return applyFilter
    }
    
    // FILTER 4: GreyScale - strength [-100,100]
    func convertToGreyScale(filterStrength : Int) -> ((RGBAImage) -> RGBAImage) {
        func applyFilter(image : RGBAImage) -> RGBAImage {
            
            for y in 0..<image.height{
                for x in 0..<image.width {
                    let index = y * image.height + x
                    var pixel = image.pixels[index]
                    
                    let greyValue = UInt8(checkPixelValue(((0.299 * Double(pixel.red)) + (0.587 * Double(pixel.green)) + (0.114 * Double(pixel.blue))) + Double(filterStrength) * 2.25))
                    
                    pixel.red = greyValue
                    pixel.green = greyValue
                    pixel.blue = greyValue
                    image.pixels[index] = pixel
                }
            }
            return image
        }
        return applyFilter
    }
    
    // FILTER 5: Sepia - strength [-100,100]
    func convertToSepia(filterStrength : Int) -> ((RGBAImage) -> RGBAImage) {
        func applyFilter(image : RGBAImage) -> RGBAImage {
            
            for y in 0..<image.height{
                for x in 0..<image.width {
                    let index = y * image.height + x
                    var pixel = image.pixels[index]
                    
                    pixel.red = UInt8(checkPixelValue(((0.393 * Double(pixel.red)) + (0.769 * Double(pixel.green)) + (0.189 * Double(pixel.blue))) + Double(filterStrength) * 2.25))
                    pixel.green = UInt8(checkPixelValue(((0.349 * Double(pixel.red)) + (0.686 * Double(pixel.green)) + (0.168 * Double(pixel.blue))) + Double(filterStrength) * 2.25))
                    pixel.blue = UInt8(checkPixelValue(((0.272 * Double(pixel.red)) + (0.534 * Double(pixel.green)) + (0.131 * Double(pixel.blue))) + Double(filterStrength) * 2.25))
                    image.pixels[index] = pixel
                }
                
            }
            return image
        }
        return applyFilter
    }

    // FILTER 6: Blur - strength 0 (no effect) / 1 / 2
    // Can be optimized performance-wise
    func addBlur(filterStrength : Int) -> ((RGBAImage) -> RGBAImage) {
        func applyFilter(image : RGBAImage) -> RGBAImage {
            
            // Small effect config
            var filterWidth = 3
            var filterHeight = 3
            var blurMatrix : [[Int]] = [
                [0,1,0],
                [1,1,1],
                [0,1,0]]
            var factor : Double = 1/5
            
            if(filterStrength <= 0) {
                return image
            } else if (filterStrength > 1) {
                // Big effect config
                filterWidth = 5
                filterHeight = 5
                blurMatrix = [
                    [0,0,1,0,0],
                    [0,1,1,1,0],
                    [1,1,1,1,1],
                    [0,1,1,1,0],
                    [0,0,1,0,0]]
                factor = 1/13
            }
            let imgWidth = image.width
            let imgHeight = image.height
            
            for x in 0..<imgWidth{
                for y in 0..<imgHeight {
                    var red = 0, green = 0, blue = 0
                    
                    for filterY in 0..<filterWidth {
                        for filterX in 0..<filterHeight {
                            let imageX = (x - filterWidth / 2 + filterX + imgWidth) % imgWidth
                            let imageY = (y - filterHeight / 2 + filterY + imgHeight) % imgHeight
                            var pixel = image.pixels[imageY * imgHeight + imageX]
                            red += Int(pixel.red) * blurMatrix[filterX][filterY]
                            blue += Int(pixel.blue) * blurMatrix[filterX][filterY]
                            green += Int(pixel.green) * blurMatrix[filterX][filterY]
                        }
                    }
                    let index = y * imgHeight + x
                    var pixel = image.pixels[index]
                    pixel.red = UInt8(checkPixelValue(Double(red) * factor))
                    pixel.green = UInt8(checkPixelValue(Double(green) * factor))
                    pixel.blue = UInt8(checkPixelValue(Double(blue) * factor))
                    image.pixels[index] = pixel
                }
            }
            return image
        }
        return applyFilter
    }
}

/*
    ImageProcessor class (STEP 3)
        Instanciated with an image (RGBAImage)
        applyFiltersToImage receives an array of filters and applies them by the array order
*/
class ImageProcessor {
    var image : RGBAImage
    var predefinedFilters : [String: (RGBAImage) -> RGBAImage]
    
    init(image : RGBAImage, predefinedFilters : [String: (RGBAImage) -> RGBAImage] = Dictionary<String, (RGBAImage) -> RGBAImage>()) {
        self.image = image
        self.predefinedFilters = predefinedFilters
    }

    func applyFiltersToImage(filterList : [((RGBAImage) -> RGBAImage)?]) -> RGBAImage {
        var imageTemp = image
        for filter in filterList {
            if(filter != nil) {
                imageTemp = filter!(imageTemp)
            }
        }
        return imageTemp
    }
    
    // Get default filters by specifying its name (STEP 5)
    func getPredefinedFilter(filterName : String) ->  ((RGBAImage) -> RGBAImage)? {
        return predefinedFilters[filterName]
    }
    
}
let myFilter : Filter = Filter();

// DEFAULT FILTERS - MAP (STEP 4)
let defaultFilters : [String: (RGBAImage) -> RGBAImage] =
    ["-20% Contrast": myFilter.changeContrast(-20),
    "50% Contrast": myFilter.changeContrast(50),
    "20% Brightness": myFilter.changeBrightness(20),
    "To Grey Scale": myFilter.convertToGreyScale(-90),
    "To Sepia": myFilter.convertToSepia(30),
    "Add Blur Level 1": myFilter.addBlur(1),
    "Add Blur Level 2": myFilter.addBlur(2),
    "Add 25% Negative": myFilter.applyNegative(25)]

let myImageProcessor = ImageProcessor(image: rgbaImage, predefinedFilters: defaultFilters)

// DIRECT USAGE EXAMPLES
//let newImage = myImageProcessor.applyFiltersToImage([myFilter.changeContrast(20)])
//let newImage = myImageProcessor.applyFiltersToImage([myFilter.changeBrightness(-50)])
//let newImage = myImageProcessor.applyFiltersToImage([myFilter.changeBrightness(-100),myFilter.changeContrast(23)])
//let newImage = myImageProcessor.applyFiltersToImage([myFilter.convertToGreyScale(20),myFilter.changeContrast(55)])
//let newImage = myImageProcessor.applyFiltersToImage([myFilter.convertToSepia(10)])
//let newImage = myImageProcessor.applyFiltersToImage([myFilter.addBlur(60)])
//let newImage = myImageProcessor.applyFiltersToImage([myFilter.addBlur(20),myFilter.convertToGreyScale(20)])

// DEFAULT FILTERS USAGE EXAMPLES (STEP 4
//let newImage = myImageProcessor.applyFiltersToImage([defaultFilters["50% Contrast"],defaultFilters["20% Brightness"]])

// GET PREDEFINED FILTER USAGE EXAMPLE (STEP 5)
//let newImage = myImageProcessor.applyFiltersToImage([myImageProcessor.getPredefinedFilter("To Sepia")])

//let finishedImage = newImage.toUIImage()!

//HOW TO RUN:
// UNCOMMENT ONE OF THE 'let newImage...' lines
// UNCOMMENT 'let finishedImage...' line


