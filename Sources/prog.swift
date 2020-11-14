// To run the code:
// swift prog.swift

import Foundation

public func createShader(shaderType: String, name: String) {
  let fileName = "Msc_Project/Sources/Shaders/" + name
  let documentDirectoryUrl = try! FileManager.default.url(
    for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true
  )
  // TODO: try catch shader type
  let extensionName = shaderType.prefix(1) + "s"

  let fileUrl = documentDirectoryUrl.appendingPathComponent(fileName).appendingPathExtension(String(extensionName))
  // could also check if type is geometry

  // data to write in file
  let stringData = "#version 330 core \n"
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


// shaderType can be: "vertex" or "fragment".
print(createShader(shaderType: "vertex", name: "sample"))
