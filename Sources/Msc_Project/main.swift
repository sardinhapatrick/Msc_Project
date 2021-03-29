import PATL
import Foundation
import Glibc

class SystemSolar: ComponentTopLevel {

  var state: [String: [String: Any]] = [:]
  let solarRadius: Double = 50.0

  override init() {
    super.init()
    // Init the camera
    let cam = self.createCamera(farDistance: 5000.0, x: 650.0, y: 90.0, z: 0.0)

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
      let _ = Sphere(name: (self.state["root"]!["name"] as! String),
                     scene: self,
                     coord: (self.state["root"]!["coord"] as! Coord),
                     props: [(self.state["root"]!["tex"] as! String), (self.state["root"]!["radius"] as! Double)]
                     ).render()
      let s0 = Sphere(name: (self.state["obj0"]!["name"] as! String),
                      scene: self,
                      coord: (self.state["obj0"]!["coord"] as! Coord),
                      props: [(self.state["obj0"]!["tex"] as! String), (self.state["obj0"]!["radius"] as! Double)]
                      ).render() // Call the low level render function
      let s1 = Sphere(name: (self.state["obj1"]!["name"] as! String),
                      scene: self,
                      coord: (self.state["obj1"]!["coord"] as! Coord),
                      props: [(self.state["obj1"]!["tex"] as! String), (self.state["obj1"]!["radius"] as! Double)]
                      ).render()
      let s2 = Sphere(name: (self.state["obj2"]!["name"] as! String),
                      scene: self,
                      coord: (self.state["obj2"]!["coord"] as! Coord),
                      props: [(self.state["obj2"]!["tex"] as! String), (self.state["obj2"]!["radius"] as! Double)]
                      ).render()
      let s3 = Sphere(name: (self.state["obj3"]!["name"] as! String),
                      scene: self,
                      coord: (self.state["obj3"]!["coord"] as! Coord),
                      props: [(self.state["obj3"]!["tex"] as! String), (self.state["obj3"]!["radius"] as! Double)]
                      ).render()
      let s4 = Sphere(name: (self.state["obj4"]!["name"] as! String),
                      scene: self,
                      coord: (self.state["obj4"]!["coord"] as! Coord),
                      props: [(self.state["obj4"]!["tex"] as! String), (self.state["obj4"]!["radius"] as! Double)]
                      ).render()
      let s5 = Sphere(name: (self.state["obj5"]!["name"] as! String),
                      scene: self,
                      coord: (self.state["obj5"]!["coord"] as! Coord),
                      props: [(self.state["obj5"]!["tex"] as! String), (self.state["obj5"]!["radius"] as! Double)]
                      ).render()
      let s6 = Sphere(name: (self.state["obj6"]!["name"] as! String),
                      scene: self,
                      coord: (self.state["obj6"]!["coord"] as! Coord),
                      props: [(self.state["obj6"]!["tex"] as! String), (self.state["obj6"]!["radius"] as! Double)]
                      ).render()
      let s7 = Sphere(name: (self.state["obj7"]!["name"] as! String),
                      scene: self,
                      coord: (self.state["obj7"]!["coord"] as! Coord),
                      props: [(self.state["obj7"]!["tex"] as! String), (self.state["obj7"]!["radius"] as! Double)]
                      ).render()

      // Register to tick()
      // This allows to call update() like 60 times per second (60FPS)
      let l = [s0, s1, s2, s3, s4, s5, s6, s7]
      registerTick(selectorUpdate: {
        self.update(node: l)
      })
  }

  func rerender(newState: [String: [String: Any]], node: [Any]) {
    Sphere(node: node[0],
           scene: self,
           coord: (self.state["obj0"]!["coord"] as! Coord)
         ).rerender() // Call the low level rerender function
    Sphere(node: node[1],
           scene: self,
           coord: (self.state["obj1"]!["coord"] as! Coord)
         ).rerender()
    Sphere(node: node[2],
           scene: self,
           coord: (self.state["obj2"]!["coord"] as! Coord)
         ).rerender()
    Sphere(node: node[3],
           scene: self,
           coord: (self.state["obj3"]!["coord"] as! Coord)
         ).rerender()
    Sphere(node: node[4],
           scene: self,
           coord: (self.state["obj4"]!["coord"] as! Coord)
         ).rerender()
    Sphere(node: node[5],
           scene: self,
           coord: (self.state["obj5"]!["coord"] as! Coord)
         ).rerender()
    Sphere(node: node[6],
           scene: self,
           coord: (self.state["obj6"]!["coord"] as! Coord)
         ).rerender()
    Sphere(node: node[7],
           scene: self,
           coord: (self.state["obj7"]!["coord"] as! Coord)
         ).rerender()
  }
}


class Sphere {

  var name: String?
  var node: Any?
  var scene: SystemSolar
  var coord: Coord
  var props: [Any]?

  init(name: String, scene: SystemSolar, coord: Coord, props: [Any]) {
    // scene is the current scene, where to place 3D objects
    self.name = name
    self.scene = scene
    self.coord = coord
    self.props = props
  }

  init(node: Any, scene: SystemSolar, coord: Coord) {
    // scene is the current scene, where to place 3D objects
    self.node = node
    self.scene = scene
    self.coord = coord
  }

  // Render function is called the first time a component is mounted
  func render() -> Any {
    // createChildNode() allows to create a child node in the scene (root is the parent node of the scene)
    let n = scene.createChildNode(name: self.name!)
    // Call createSphere() to create a sphere in the current scene
    scene.createSphere(node: n, segments: 100, rings: 100, radius: self.props![1] as! Double)
    // Apply a texture from an image
    scene.applyTexture(node: n, tex: self.props![0] as! String)

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
let _ = createScene(name: "Solar System",
                    compTL: SystemSolar())
