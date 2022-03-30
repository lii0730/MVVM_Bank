import UIKit

var greeting = "Hello, playground"


var errorMessage: String = ""

var errors: [String] = [String]()
errors.append("Name is Not Valid")
errors.append("Balance is Not Valid")

errorMessage = errors.joined(separator: "\n") // separator를 이용해서 합침
print(errorMessage)
