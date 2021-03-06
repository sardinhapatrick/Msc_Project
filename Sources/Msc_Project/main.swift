import PATL
import Rendery
import Foundation
import Glibc


//////////////////////////////////////////////////////////////////////////////

/*
class Sphere {
    // Here we work with 2D cartesian and 2D polar coordinates
    var name: String
    var pos: (Double, Double)
    var props: [Any?]

    init(name: String, pos: Coord, props: [Any?]) {
      self.name = name
      self.pos = pos.polarToCart()
      self.props = props

      let _ = self.render()
    }

    func render() -> Mesh {
      //log(str: "render a Sphere for [\(name) at position: \(pos) with props: \(props)]")
      return (
          Mesh(meshType: "Sphere", meshPosition: pos, meshProps: props)
      )
    }
}

class Sphere_ : Scene {
    public override init() {
        super.init()

        let solar = root.createChild()
        print("->",solar)
    }


}

class SystemSolar_ : Scene {

    var state: [String: [String: Any]] = [:]
    var callTick: Bool = true
    let solarRadius: Double = 5.0

    public override init() {
        super.init()

        backgroundColor = "#000000"

        // planet = [name, radius, solar_dist, polar_angle, revolution, texture_path]

        self.state = ["obj0": ["name": "Mercury", "radius": 11440.0, "coord": Coord(polar: (35.791, Angles(deg: 0.0))), "revo": 88.0, "tex": "/img/mercury_tex.jpeg"],
                      "obj1": ["name": "Venus", "radius": 15052.0, "coord": Coord(polar: (45.82, Angles(deg: 0.0))), "revo": 225.0, "tex": "/img/venus_tex.jpg"],
                      "obj2": ["name": "Earth", "radius": 16371.0, "coord": Coord(polar: (64.96, Angles(deg: 0.0))), "revo": 365.0, "tex": "/img/earth_tex.jpg"],
                      "obj3": ["name": "Mars", "radius": 12390.0, "coord": Coord(polar: (72.79, Angles(deg: 0.0))), "revo": 687.0, "tex": "/img/mars_tex.jpg"],
                      "obj4": ["name": "Jupiter", "radius": 69911.0, "coord": Coord(polar: (97.85, Angles(deg: 0.0))), "revo": 1380.0, "tex": "/img/jupiter_tex.jpg"],
                      "obj5": ["name": "Saturn", "radius": 58232.0, "coord": Coord(polar: (143.40, Angles(deg: 0.0))), "revo": 3585.0, "tex": "/img/saturn_tex.jpg"],
                      "obj6": ["name": "Uranus", "radius": 25362.0, "coord": Coord(polar: (227.10, Angles(deg: 0.0))), "revo": 4660.0, "tex": "/img/uranus_tex.jpg"],
                      "obj7": ["name": "Neptune", "radius": 24622.0, "coord": Coord(polar: (350.50, Angles(deg: 0.0))), "revo": 6225.0, "tex": "/img/neptune_tex.jpg"]
                     ]
        self.subTick(interval: 1)
    }

    // Directly call when the component is created
    func subTick(interval: UInt32) {
        self.callTick = true
        while(callTick) {
            //log(str: "\n\n\(self.state)\n")
            self.tick()
            sleep(interval)
        }
    }

    // Call when the component is removed
    func unsubTick() {
       self.callTick = false
    }

    func updatePlanetPos(currentAngle: Angles, revolution: Double) -> Double {
      let newAngle = currentAngle.deg!+(360/revolution)
      return (newAngle.truncatingRemainder(dividingBy: 360.0))
    }

    func tick() {
      self.state = updateState(currentState: state,
                               nextState: ["obj0": ["coord": Coord(polar: ((state["obj0"]!["coord"] as! Coord).polar!.0,
                                                                          Angles(deg: self.updatePlanetPos(currentAngle: (state["obj0"]!["coord"] as! Coord).polar!.1,
                                                                                                          revolution: (state["obj0"]!["revo"] as! Double)))))],
                                           "obj1": ["coord": Coord(polar: ((state["obj1"]!["coord"] as! Coord).polar!.0,
                                                                           Angles(deg: self.updatePlanetPos(currentAngle: (state["obj1"]!["coord"] as! Coord).polar!.1,
                                                                                                          revolution: (state["obj1"]!["revo"] as! Double)))))],
                                           "obj2": ["coord": Coord(polar: ((state["obj2"]!["coord"] as! Coord).polar!.0,
                                                                           Angles(deg: self.updatePlanetPos(currentAngle: (state["obj2"]!["coord"] as! Coord).polar!.1,
                                                                                                          revolution: (state["obj2"]!["revo"] as! Double)))))],
                                           "obj3": ["coord": Coord(polar: ((state["obj3"]!["coord"] as! Coord).polar!.0,
                                                                           Angles(deg: self.updatePlanetPos(currentAngle: (state["obj3"]!["coord"] as! Coord).polar!.1,
                                                                                                          revolution: (state["obj3"]!["revo"] as! Double)))))],
                                           "obj4": ["coord": Coord(polar: ((state["obj4"]!["coord"] as! Coord).polar!.0,
                                                                           Angles(deg: self.updatePlanetPos(currentAngle: (state["obj4"]!["coord"] as! Coord).polar!.1,
                                                                                                          revolution: (state["obj4"]!["revo"] as! Double)))))],
                                           "obj5": ["coord": Coord(polar: ((state["obj5"]!["coord"] as! Coord).polar!.0,
                                                                           Angles(deg: self.updatePlanetPos(currentAngle: (state["obj5"]!["coord"] as! Coord).polar!.1,
                                                                                                          revolution: (state["obj5"]!["revo"] as! Double)))))],
                                           "obj6": ["coord": Coord(polar: ((state["obj6"]!["coord"] as! Coord).polar!.0,
                                                                           Angles(deg: self.updatePlanetPos(currentAngle: (state["obj6"]!["coord"] as! Coord).polar!.1,
                                                                                                          revolution: (state["obj6"]!["revo"] as! Double)))))],
                                           "obj7": ["coord": Coord(polar: ((state["obj7"]!["coord"] as! Coord).polar!.0,
                                                                           Angles(deg: self.updatePlanetPos(currentAngle: (state["obj7"]!["coord"] as! Coord).polar!.1,
                                                                                                          revolution: (state["obj7"]!["revo"] as! Double)))))]
                                        ]
                        )
      print("hého")
      let test = Sphere_()
      print(test)
      //self.render()
    }

    func render() -> (Sphere, Sphere, Sphere, Sphere, Sphere, Sphere, Sphere, Sphere) {
      return (
        //Sphere(name: "Solar", pos: (state["solarCoord"] as! Coord), props: [state["solarRadius"]]),
        Sphere(name: "Mercury", pos: (state["obj0"]!["coord"] as! Coord), props: [state["obj0"]!["radius"]]),
        Sphere(name: "Venus", pos: (state["obj1"]!["coord"] as! Coord), props: [state["obj1"]!["radius"]]),
        Sphere(name: "Earth", pos: (state["obj2"]!["coord"] as! Coord), props: [state["obj2"]!["radius"]]),
        Sphere(name: "Mars", pos: (state["obj3"]!["coord"] as! Coord), props: [state["obj3"]!["radius"]]),
        Sphere(name: "Jupiter", pos: (state["obj4"]!["coord"] as! Coord), props: [state["obj4"]!["radius"]]),
        Sphere(name: "Saturn", pos: (state["obj5"]!["coord"] as! Coord), props: [state["obj5"]!["radius"]]),
        Sphere(name: "Uranus", pos: (state["obj6"]!["coord"] as! Coord), props: [state["obj6"]!["radius"]]),
        Sphere(name: "Neptune", pos: (state["obj7"]!["coord"] as! Coord), props: [state["obj7"]!["radius"]])
      )
    }
}


// Entry: Call the highest component
let _ = createScene(name: "Solar System", scene: SystemSolar())
//let _ = sampleScene(name: "Solar System", scene: SystemSolar_())
*/
////////////////////////////////////////////////////////////////////////////////
print("ENTRY POINT")

class SystemSolar: ComponentTopLevel {

  var state: [String: [String: Any]] = [:]
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
    return (newAngle.truncatingRemainder(dividingBy: 360.0))
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

  func tick(node: [Node]) {
    AppContext.shared.subscribe(frameListener: { _, delta in
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

      //print(self.state)
      Sphere(node: node[0],
             scene: self,
             coord: (self.state["obj0"]!["coord"] as! Coord)
           ).rerender() // Call the low level render function
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
    })
  }

  // This is RENDER and not RERENDER because it's the first time we render our objetcs
  func render() {
      let solar = Sphere(name: (self.state["root"]!["name"] as! String),
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

      self.tick(node: [s0 as! Node, s1 as! Node, s2 as! Node, s3 as! Node,
                       s4 as! Node, s5 as! Node, s6 as! Node, s7 as! Node])
  }
}


class Sphere {

  var name: String?
  var node: Node?
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

  init(node: Node, scene: SystemSolar, coord: Coord) {
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

    // Call predefined convert function for coordinates
    // Users can define their own abstract types
    let x = coord.polarToCart().0
    let y = coord.polarToCart().1
    let z = coord.polarToCart().2
    //print(x,y,z)
    scene.setNodePosition(node: n, x: x, y: y, z: z)
    return n
  }

  // Rerender function is called for a mounted component
  func rerender() {
    let x = coord.polarToCart().0
    let y = coord.polarToCart().1
    let z = coord.polarToCart().2
    print(x,y,z)
    scene.setNodePosition(node: node!, x: x, y: y, z: z)
  }
}

// Entry: Call the highest component
let _ = createScene(name: "Solar System", compTL: SystemSolar())
