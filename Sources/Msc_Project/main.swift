import PATL
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
  var callTick: Bool = true
  let solarRadius: Double = 5.0

  override init() {
    super.init()

    // Define the background color as "#______" or using the Color class developed
    // in Rendery and call setBackgroundColor(colHexa: Color)
    self.setBackgroundColor(colHexa: "#000000")

    // Define the global state of the application: this is a dictionary of dictionary
    // Each object in the scene has some properties
    // Here, each planet has a name, a radius, coordinates (polar: which are represented by the distance from the sun and the polar angle),
    // a revolution and finally an image representing its texture
    self.state = ["obj0": ["name": "Mercury", "radius": 11440.0, "coord": Coord(polar: (35.791, Angles(deg: 0.0))), "revo": 88.0, "tex": "/img/mercury_tex.jpeg"],
                  "obj1": ["name": "Venus", "radius": 15052.0, "coord": Coord(polar: (45.82, Angles(deg: 0.0))), "revo": 225.0, "tex": "/img/venus_tex.jpg"],
                  "obj2": ["name": "Earth", "radius": 16371.0, "coord": Coord(polar: (64.96, Angles(deg: 0.0))), "revo": 365.0, "tex": "/img/earth_tex.jpg"],
                  "obj3": ["name": "Mars", "radius": 12390.0, "coord": Coord(polar: (72.79, Angles(deg: 0.0))), "revo": 687.0, "tex": "/img/mars_tex.jpg"],
                  "obj4": ["name": "Jupiter", "radius": 69911.0, "coord": Coord(polar: (97.85, Angles(deg: 0.0))), "revo": 1380.0, "tex": "/img/jupiter_tex.jpg"],
                  "obj5": ["name": "Saturn", "radius": 58232.0, "coord": Coord(polar: (143.40, Angles(deg: 0.0))), "revo": 3585.0, "tex": "/img/saturn_tex.jpg"],
                  "obj6": ["name": "Uranus", "radius": 25362.0, "coord": Coord(polar: (227.10, Angles(deg: 0.0))), "revo": 4660.0, "tex": "/img/uranus_tex.jpg"],
                  "obj7": ["name": "Neptune", "radius": 24622.0, "coord": Coord(polar: (350.50, Angles(deg: 0.0))), "revo": 6225.0, "tex": "/img/neptune_tex.jpg"]
                 ]
    //self.subTick(interval: 1)
    self.render()
  }

  func render() -> (Sphere, Sphere, Sphere, Sphere, Sphere, Sphere, Sphere, Sphere) {
    return (
      //Sphere(name: "Solar", pos: (state["solarCoord"] as! Coord), props: [state["solarRadius"]]),
      Sphere(scene: self, coord: (self.state["obj0"]!["coord"] as! Coord), props: [(self.state["obj0"]!["name"] as! String),
                                                                                   (self.state["obj0"]!["tex"] as! String)]),
      Sphere(scene: self, coord: (self.state["obj1"]!["coord"] as! Coord), props: [(self.state["obj1"]!["name"] as! String),
                                                                                  (self.state["obj1"]!["tex"] as! String)]),
      Sphere(scene: self, coord: (self.state["obj2"]!["coord"] as! Coord), props: [(self.state["obj2"]!["name"] as! String),
                                                                                   (self.state["obj2"]!["tex"] as! String)]),
      Sphere(scene: self, coord: (self.state["obj3"]!["coord"] as! Coord), props: [(self.state["obj3"]!["name"] as! String),
                                                                                   (self.state["obj3"]!["tex"] as! String)]),
      Sphere(scene: self, coord: (self.state["obj4"]!["coord"] as! Coord), props: [(self.state["obj4"]!["name"] as! String),
                                                                                   (self.state["obj4"]!["tex"] as! String)]),
      Sphere(scene: self, coord: (self.state["obj5"]!["coord"] as! Coord), props: [(self.state["obj5"]!["name"] as! String),
                                                                                   (self.state["obj5"]!["tex"] as! String)]),
      Sphere(scene: self, coord: (self.state["obj6"]!["coord"] as! Coord), props: [(self.state["obj6"]!["name"] as! String),
                                                                                   (self.state["obj6"]!["tex"] as! String)]),
      Sphere(scene: self, coord: (self.state["obj7"]!["coord"] as! Coord), props: [(self.state["obj7"]!["name"] as! String),
                                                                                   (self.state["obj7"]!["tex"] as! String)])
    )
  }

}


class Sphere {
  var scene: SystemSolar
  var coord: Coord
  var props: [Any]
  init(scene: SystemSolar, coord: Coord, props: [Any]) {
    // scene is the current scene, where to place 3D objects
    self.scene = scene
    self.coord = coord
    self.props = props

    // Call the low level render function
    self.render()
  }

  func render() {
    // createChildNode() allows to create a child node in the scene (root is the parent node of the scene)
    let n = scene.createChildNode(name: props[0] as! String)

    // Call createSphere() to create a sphere in the current scene
    scene.createSphere(node: n, segments: 100, rings: 100, radius: 10.0)
    // Apply a texture from an image
    scene.applyTexture(node: n, tex: props[1] as! String)

    // Call predefined convert function for coordinates
    // Users can define their own abstract types
    // let x =
    // let y =
    let z = -coord.polarToCart().0
    scene.setNodePosition(node: n, x: 0.0, y: 0.0, z: z)
  }
}

// Entry: Call the highest component
let _ = createScene(name: "Solar System", compTL: SystemSolar())
