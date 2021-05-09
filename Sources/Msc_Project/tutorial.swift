import PATL
import Foundation
import Glibc

class Tutorial: ComponentTopLevel {

  var state: [String: [String: Any]] = [:]

  override init() {
    super.init()

    // Define the background color as "#______" or using the Color class developed
    // in Rendery and call setBackgroundColor(colHexa: Color)
    self.setBackgroundColor(colHexa: "#000000")


    // Define the global state of the application: this is a dictionary of dictionary
    // Each object in the scene has some properties
    // Here, each planet has a name, a radius, coordinates (polar: which are represented by the distance from the sun and the polar angle),
    // a revolution and finally an image representing its texture
    self.state = ["root": ["name": "Solar", "radius": 50.0, "coord": Coord(polar: (0.0, Angles(deg: 0.0), Angles(deg: 0.0))), "tex": "/img/solar_tex.jpg"]]

    self.render()
  }

  func update(node: [Any]) {
    self.state = updateState(
      currentState: self.state,
      nextState: ["root": ["name": "Solar", "radius": 50.0, "coord": Coord(polar: (0.0, Angles(deg: 0.0), Angles(deg: 0.0))), "tex": "/img/solar_tex.jpg"]]
      )

    self.rerender(newState: self.state, node: node)
  }

  // This is RENDER and not RERENDER because it's the first time we render our objetcs
  func render() {
    // When it's the first rendering, we init the camera
    let cam = self.createCamera(farDistance: 5000.0, x: 650.0, y: 90.0, z: 0.0)
    let camSpeed: Double = 10.0

    let sol = Sphere_(name: (self.state["root"]!["name"] as! String),
                   scene: self,
                   coord: (self.state["root"]!["coord"] as! Coord),
                   props: [(self.state["root"]!["tex"] as! String), (self.state["root"]!["radius"] as! Double)]
                   // m: solarShader
                   ).render()
    var l: [Any] = []

    // Register to tick()
    // This allows to call update() like 60 times per second (60FPS)
    registerTick(selectorUpdate: {
      self.update(node: l)

      // Solar is @(0.0, 0.0, 0.0) and the camera cannot take negative value for each axes.
      // To simulate a more realistic behavior here the idea would be to place the sun at central coordinates like (1000.0, 1000.0, 1000.0)
      var e = getKeyEvent()
      //print("Key pressed: ",e)
      switch e {
      case "W":
          self.setNodePosition(node: cam, x: cam.translation.x - camSpeed, y: cam.translation.y, z:cam.translation.z)
      case "S":
          self.setNodePosition(node: cam, x: cam.translation.x + camSpeed, y: cam.translation.y, z:cam.translation.z)
      case "A":
          self.setNodePosition(node: cam, x: cam.translation.x, y: cam.translation.y, z:cam.translation.z + camSpeed)
      case "D":
          self.setNodePosition(node: cam, x: cam.translation.x, y: cam.translation.y, z:cam.translation.z - camSpeed)
      default:
        break
      }
    })

  }

  func rerender(newState: [String: [String: Any]], node: [Any]) { }

}


class Sphere_ {

  var name: String?
  var node: Any?
  var scene: Tutorial
  var coord: Coord
  var props: [Any]?
  var m: Any?

  init(name: String, scene: Tutorial, coord: Coord, props: [Any]) {
    // scene is the current scene, where to place 3D objects
    self.name = name
    self.scene = scene
    self.coord = coord
    self.props = props
  }

  init(name: String, scene: Tutorial, coord: Coord, props: [Any], m: Any) {
    self.name = name
    self.scene = scene
    self.coord = coord
    self.props = props
    self.m = m
  }

  // Render function is called the first time a component is mounted
  func render() -> Any {

    // createChildNode() allows to create a child node in the scene (root is the parent node of the scene)
    let n = scene.createChildNode(name: self.name!)
    // Call createSphere_() to create a sphere in the current scene

    // Create a Sphere with a customShader material: (customShader can be `nil`)
    scene.createSphere(node: n, segments: 100, rings: 100, radius: self.props![1] as! Double)

    // Apply a texture from an image (if affected by the default shader) else from a custom shader
    if (n.name != "") {
      scene.applyTextureFromImg(node: n, tex: self.props![0] as! String)
    } else {
      scene.applyTextureFromShaders(node: n, customShader: m)
    }

    // Users can define their own abstract types like Coord given in the lib
    let x = coord.cart.0
    let y = coord.cart.1
    let z = coord.cart.2

    scene.setNodePosition(node: n, x: x, y: y, z: z)
    return n
  }

  // Rerender function is called for a mounted component
  func rerender() {
    let x = coord.cart.0
    let y = coord.cart.1
    let z = coord.cart.2

    scene.setNodePosition(node: node!, x: x, y: y, z: z)
  }
}

// Entry: Call the highest component
func entry_point_tutorial() {
    let _ = createScene(name: "Tutorial", compTL: Tutorial())
}
