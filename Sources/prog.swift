// To run the code:
// swift prog.swift

import Foundation

public func createShader(type: String) {
  print(type)
  let fileName = "Msc_Project/shaders/sample_vs"
  let documentDirectoryUrl = try! FileManager.default.url(
    for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true
  )
  let fileUrl = documentDirectoryUrl.appendingPathComponent(fileName).appendingPathExtension("vs")
  // prints the file path
  print("File path \(fileUrl.path)")
  //data to write in file.
  let stringData = "Hello Tutorials Point"
  do {
    try stringData.write(to: fileUrl, atomically: true, encoding: String.Encoding.utf8)
  } catch let error as NSError {
    print (error)
  }
  var readFile = ""
  do {
    readFile = try String(contentsOf: fileUrl)
  } catch let error as NSError {
    print(error)
  }
  print (readFile)
}



print(createShader(type: "vertex"))
