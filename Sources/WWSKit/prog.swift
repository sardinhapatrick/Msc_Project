// To run the code:
// swift prog.swift

import Foundation

// takes a swift shader file (vertex or fragment), read it in order to parse it
// and translate it into a GLSL shader

public func readSwiftShader(shaderType: String, name: String, ext: String) -> String {
  // interface to write shaders with abstract types in Swift: notepad for now
  let fileName = "Msc_Project/Sources/WWSKit/Shaders/" + name + "." + ext
  let documentDirectoryUrl = try! FileManager.default.url(
    for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true
  )
  let fileUrl = documentDirectoryUrl.appendingPathComponent(fileName)
  var readFile = ""
  do {
    readFile = try String(contentsOf: fileUrl)
  } catch let error as NSError {
    print(error)
  }
  // readFile -> String
  return readFile
}

public func swiftToGLSL(swiftShader: String) -> String {
  // parser + AST
  // return a GLSL shader used by createGLSLShader to generate a shader file used
  // in the main render loop in the C-like program
  return ""
}

// create new files .vs or .fs which will be used in the main GLSL program
// these shaders are understandable for the OpenGL pipeline
public func createGLSLShader(shaderType: String, name: String) {
  let fileName = "Msc_Project/Sources/WWSKit/Shaders/" + name
  let documentDirectoryUrl = try! FileManager.default.url(
    for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true
  )
  // TODO: try catch shader type
  // could also check if type is geometry
  let extensionName = shaderType.prefix(1) + "s"
  let fileUrl = documentDirectoryUrl.appendingPathComponent(fileName).appendingPathExtension(String(extensionName))
  print(fileUrl)
  // data to write in file which is the swift shaders already translate to GLSL shaders
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
print(createGLSLShader(shaderType: "vertex", name: "sample2"))
print("------------")
print(readSwiftShader(shaderType: "vertex", name: "sample", ext: "swift"))

// let v = Vector3()
//
// var vec1: Vector3 = Vector3(x: 1, y:2, z:3)
// var vec2: Vector3 = Vector3(x: 10, y:20, z:30)
// print(vec1.add(v1:vec1, v2:vec2))
