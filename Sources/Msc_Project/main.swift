import PATL
import Foundation
import Glibc

class SystemSolar: ComponentTopLevel {

  var state: [String: [String: Any]] = [:]
  // Import cunstom shaders
  let solarShader = importCustomShader(shaderProgram: GLSLPinkShader())
  let testShader = importCustomShader(shaderProgram: GLSLTestShader())

  let solarRadius: Double = 50.0

  override init() {
    super.init()

    // Define the background color as "#______" or using the Color class developed
    // in Rendery and call setBackgroundColor(colHexa: Color)
    self.setBackgroundColor(colHexa: "#000000")

    // TODO: make inputable camera farDistance and translation

    // Define the global state of the application: this is a dictionary of dictionary
    // Each object in the scene has some properties
    // Here, each planet has a name, a radius, coordinates (polar: which are represented by the distance from the sun and the polar angle),
    // a revolution and finally an image representing its texture
    self.state = ["root": ["name": "Solar", "radius": solarRadius, "coord": Coord(polar: (0.0, Angles(deg: 0.0), Angles(deg: 0.0))), "tex": "/img/solar_tex.jpg"],
                  "obj0": ["name": "Mercury", "radius": self.sizePlanet(s: solarRadius, p: 11440), "coord": Coord(polar: (self.distPlanet(s: solarRadius, d: 35.791), Angles(deg: 0.0), Angles(deg: 0.0))), "revo": 88.0, "tex": "/img/mercury_tex.jpeg"],
                  "obj1": ["name": "Venus", "radius": self.sizePlanet(s: solarRadius, p: 15052), "coord": Coord(polar: (self.distPlanet(s: solarRadius, d: 45.82), Angles(deg: 0.0), Angles(deg: 0.0))), "revo": 225.0, "tex": "/img/venus_tex.jpg"],
                  "obj2": ["name": "Earth", "radius": self.sizePlanet(s: solarRadius, p: 16371), "coord": Coord(polar: (self.distPlanet(s: solarRadius, d: 64.96), Angles(deg: 0.0), Angles(deg: 0.0))), "revo": 365.0, "tex": "/img/earth_tex.jpg"],
                  "obj3": ["name": "Mars", "radius": self.sizePlanet(s: solarRadius, p: 12390), "coord": Coord(polar: (self.distPlanet(s: solarRadius, d: 72.79), Angles(deg: 0.0), Angles(deg: 0.0))), "revo": 687.0, "tex": "/img/mars_tex.jpg"],
                  "obj4": ["name": "Jupiter", "radius": self.sizePlanet(s: solarRadius, p: 69911), "coord": Coord(polar: (self.distPlanet(s: solarRadius, d: 97.85), Angles(deg: 0.0), Angles(deg: 0.0))), "revo": 1380.0, "tex": "/img/jupiter_tex.jpg"],
                  "obj5": ["name": "Saturn", "radius": self.sizePlanet(s: solarRadius, p: 58232), "coord": Coord(polar: (self.distPlanet(s: solarRadius, d: 143.40), Angles(deg: 0.0), Angles(deg: 0.0))), "revo": 3585.0, "tex": "/img/saturn_tex.jpg"],
                  "obj6": ["name": "Uranus", "radius": self.sizePlanet(s: solarRadius, p: 25362), "coord": Coord(polar: (self.distPlanet(s: solarRadius, d: 227.10), Angles(deg: 0.0), Angles(deg: 0.0))), "revo": 4660.0, "tex": "/img/uranus_tex.jpg"],
                  "obj7": ["name": "Neptune", "radius": self.sizePlanet(s: solarRadius, p: 24622), "coord": Coord(polar: (self.distPlanet(s: solarRadius, d: 350.50), Angles(deg: 0.0), Angles(deg: 0.0))), "revo": 6225.0, "tex": "/img/neptune_tex.jpg"]
                 ]

    self.render()
  }

  func updatePlanetPos(currentAngle: Angles, revolution: Double) -> Double {
    let newAngle = currentAngle.deg+(360/(revolution*50))
    return newAngle
  }

  // Real planet scale
  func sizePlanet(s: Double, p: Double) -> Double {
    return (p*s)/696340
  }

  // Real distance solar - planets
  func distPlanet(s: Double, d: Double) -> Double {
    let d_m = d*pow(10.0, 6)
    return -1*(d_m/696340)
  }

  func update(node: [Any]) {
    self.state = updateState(
      currentState: self.state,
      nextState: ["obj0": ["coord": Coord(polar: ((self.state["obj0"]!["coord"] as! Coord).polar.0,
                                                   Angles(deg: self.updatePlanetPos(currentAngle: (self.state["obj0"]!["coord"] as! Coord).polar.1,
                                                                                    revolution: (self.state["obj0"]!["revo"] as! Double))),
                                                   Angles(deg: (self.state["obj0"]!["coord"] as! Coord).polar.2.deg)))],
                  "obj1": ["coord": Coord(polar: ((self.state["obj1"]!["coord"] as! Coord).polar.0,
                                                   Angles(deg: self.updatePlanetPos(currentAngle: (self.state["obj1"]!["coord"] as! Coord).polar.1,
                                                                                    revolution: (self.state["obj1"]!["revo"] as! Double))),
                                                   Angles(deg: (self.state["obj1"]!["coord"] as! Coord).polar.2.deg)))],
                  "obj2": ["coord": Coord(polar: ((self.state["obj2"]!["coord"] as! Coord).polar.0,
                                                   Angles(deg: self.updatePlanetPos(currentAngle: (self.state["obj2"]!["coord"] as! Coord).polar.1,
                                                                                    revolution: (self.state["obj2"]!["revo"] as! Double))),
                                                   Angles(deg: (self.state["obj2"]!["coord"] as! Coord).polar.2.deg)))],
                  "obj3": ["coord": Coord(polar: ((self.state["obj3"]!["coord"] as! Coord).polar.0,
                                                   Angles(deg: self.updatePlanetPos(currentAngle: (self.state["obj3"]!["coord"] as! Coord).polar.1,
                                                                                    revolution: (self.state["obj3"]!["revo"] as! Double))),
                                                   Angles(deg: (self.state["obj3"]!["coord"] as! Coord).polar.2.deg)))],
                  "obj4": ["coord": Coord(polar: ((self.state["obj4"]!["coord"] as! Coord).polar.0,
                                                   Angles(deg: self.updatePlanetPos(currentAngle: (self.state["obj4"]!["coord"] as! Coord).polar.1,
                                                                                    revolution: (self.state["obj4"]!["revo"] as! Double))),
                                                   Angles(deg: (self.state["obj4"]!["coord"] as! Coord).polar.2.deg)))],
                  "obj5": ["coord": Coord(polar: ((self.state["obj5"]!["coord"] as! Coord).polar.0,
                                                   Angles(deg: self.updatePlanetPos(currentAngle: (self.state["obj5"]!["coord"] as! Coord).polar.1,
                                                                                    revolution: (self.state["obj5"]!["revo"] as! Double))),
                                                   Angles(deg: (self.state["obj5"]!["coord"] as! Coord).polar.2.deg)))],
                  "obj6": ["coord": Coord(polar: ((self.state["obj6"]!["coord"] as! Coord).polar.0,
                                                   Angles(deg: self.updatePlanetPos(currentAngle: (self.state["obj6"]!["coord"] as! Coord).polar.1,
                                                                                    revolution: (self.state["obj6"]!["revo"] as! Double))),
                                                   Angles(deg: (self.state["obj6"]!["coord"] as! Coord).polar.2.deg)))],
                  "obj7": ["coord": Coord(polar: ((self.state["obj7"]!["coord"] as! Coord).polar.0,
                                                   Angles(deg: self.updatePlanetPos(currentAngle: (self.state["obj7"]!["coord"] as! Coord).polar.1,
                                                                                    revolution: (self.state["obj7"]!["revo"] as! Double))),
                                                   Angles(deg: (self.state["obj7"]!["coord"] as! Coord).polar.2.deg)))]
                 ]
      )

    self.rerender(newState: self.state, node: node)
  }

  // This is RENDER and not RERENDER because it's the first time we render our objetcs
  func render() {
    // When it's the first rendering, we init the camera
    let cam = self.createCamera(farDistance: 5000.0, x: 650.0, y: 90.0, z: 0.0)
    let camSpeed: Double = 10.0

    let sol = Sphere(name: (self.state["root"]!["name"] as! String),
                   scene: self,
                   coord: (self.state["root"]!["coord"] as! Coord),
                   props: [(self.state["root"]!["tex"] as! String), (self.state["root"]!["radius"] as! Double)],
                   m: solarShader
                   ).render()
    var l: [Any] = []
    for planet in 0...7 {
      let s = Sphere(name: (self.state["obj"+String(planet)]!["name"] as! String),
                     scene: self,
                     coord: (self.state["obj"+String(planet)]!["coord"] as! Coord),
                     props: [(self.state["obj"+String(planet)]!["tex"] as! String), (self.state["obj"+String(planet)]!["radius"] as! Double)]
                     //m: testShader
                     ).render() // Call the low level render function
      l.append(s)
    }
    // Register to tick()
    // This allows to call update() like 60 times per second (60FPS)
    registerTick(selectorUpdate: {
      self.update(node: l)

      // Solar is @(0.0, 0.0, 0.0) and the camera cannot take negative value for each axes.
      // To simulate a more realistic behavior here the idea would be to place the sun at central coordinates like (1000.0, 1000.0, 1000.0)
      var e = getKeyEvent()
      switch e {
      case "W":
          self.setNodePosition(node: cam, x: cam.translation.x + camSpeed, y: cam.translation.y, z:cam.translation.z)
      case "S":
          self.setNodePosition(node: cam, x: cam.translation.x - camSpeed, y: cam.translation.y, z:cam.translation.z)
      case "A":
          self.setNodePosition(node: cam, x: cam.translation.x, y: cam.translation.y, z:cam.translation.z + camSpeed)
      case "D":
          self.setNodePosition(node: cam, x: cam.translation.x, y: cam.translation.y, z:cam.translation.z - camSpeed)
      default:
        break
      }
    })

  }

  func rerender(newState: [String: [String: Any]], node: [Any]) {
    for i in 0...7 {
      Sphere(node: node[i],
             scene: self,
             coord: (self.state["obj"+String(i)]!["coord"] as! Coord)
           ).rerender() // Call the low level rerender function
    }
  }

}


class Sphere {

  var name: String?
  var node: Any?
  var scene: SystemSolar
  var coord: Coord
  var props: [Any]?
  var m: Any?

  init(name: String, scene: SystemSolar, coord: Coord, props: [Any]) {
    // scene is the current scene, where to place 3D objects
    self.name = name
    self.scene = scene
    self.coord = coord
    self.props = props
  }

  init(name: String, scene: SystemSolar, coord: Coord, props: [Any], m: Any) {
    self.name = name
    self.scene = scene
    self.coord = coord
    self.props = props
    self.m = m
  }

  init(node: Any, scene: SystemSolar, coord: Coord) {
    self.node = node
    self.scene = scene
    self.coord = coord
  }

  // Render function is called the first time a component is mounted
  func render() -> Any {

    // createChildNode() allows to create a child node in the scene (root is the parent node of the scene)
    let n = scene.createChildNode(name: self.name!)
    // Call createSphere() to create a sphere in the current scene

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
let _ = createScene(name: "Solar System", compTL: SystemSolar())
