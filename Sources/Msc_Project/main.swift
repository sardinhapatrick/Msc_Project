import Rendery
import Foundation
import Glibc

// class Sphere {
//     // Here we work with 2D cartesian and 2D polar coordinates
//     var name: String
//     var pos: (Double, Double)
//     var props: [Any?]
//
//     init(name: String, pos: Coord, props: [Any?]) {
//       self.name = name
//       self.pos = pos.polarToCart()
//       self.props = props
//
//       let _ = self.render()
//     }
//
//     func render() -> Mesh {
//       log(str: "render a Sphere for [\(name) at position: \(pos) with props: \(props)]")
//       return (
//           Mesh(meshType: "Sphere", meshPosition: pos, meshProps: props)
//       )
//     }
// }
//
// class SystemSolar {
//     var state: Dictionary<String, Any> = [:]
//     var callTick: Bool = true
//
//     init() {
//         self.state =  ["solarCoord": Coord(polar: (0, Angle(deg: 0))), "solarRevo": 0.0, "solarRadius": 696340.0,
//                        "mercuryCoord": Coord(polar: (58, Angle(deg: 0))), "mercuryRevo": 88.0, "mercuryRadius": 2440.0,
//                        "venusCoord": Coord(polar: (108, Angle(deg: 0))), "venusRevo": 225.0, "venusRadius": 6050.0,
//                        "earthCoord": Coord(polar: (150, Angle(deg: 0))), "earthRevo": 365.0, "earthRadius": 6370.0,
//                        "marsCoord": Coord(polar: (228, Angle(deg: 0))), "marsRevo": 687.0, "marsRadius": 3390.0,
//                        "jupiterCoord": Coord(polar: (779, Angle(deg: 0))), "jupiterRevo": 4380.0, "jupiterRadius": 69910.0,
//                        "saturnCoord": Coord(polar: (1434, Angle(deg: 0))), "saturnRevo": 10585.0, "saturnRadius": 58230.0,
//                        "uranusCoord": Coord(polar: (2871, Angle(deg: 0))), "uranusRevo": 30660.0, "uranusRadius": 25360.0,
//                        "neptuneCoord": Coord(polar: (4495, Angle(deg: 0))), "neptuneRevo": 60225.0, "neptuneRadius": 24600.0
//                      ]
//         self.subTick(interval: 1)
//     }
//
//     // Directly call when the component is created
//     func subTick(interval: UInt32) {
//         self.callTick = true
//         while(callTick) {
//             log(str: "\n\n\(self.state)\n")
//             self.tick()
//             sleep(interval)
//         }
//     }
//
//     // Call when the component is removed
//     func unsubTick() {
//        self.callTick = false
//     }
//
//     func updatePlanetPos(currentAngle: Angle, revolution: Double) -> Double {
//       let newAngle = currentAngle.deg!+(360/revolution)
//       return (newAngle.truncatingRemainder(dividingBy: 360.0))
//     }
//
//     func tick() {
//       self.state = updateState(currentState: state,
//                                nextState: ["mercuryCoord": Coord(polar: ((state["mercuryCoord"] as! Coord).polar!.0,
//                                                                           Angle(deg: self.updatePlanetPos(currentAngle: (state["mercuryCoord"] as! Coord).polar!.1,
//                                                                                                           revolution: (state["mercuryRevo"] as! Double))))),
//                                            "venusCoord": Coord(polar: ((state["venusCoord"] as! Coord).polar!.0,
//                                                                         Angle(deg: self.updatePlanetPos(currentAngle: (state["venusCoord"] as! Coord).polar!.1,
//                                                                                                         revolution: (state["venusRevo"] as! Double))))),
//                                            "earthCoord": Coord(polar: ((state["earthCoord"] as! Coord).polar!.0,
//                                                                         Angle(deg: self.updatePlanetPos(currentAngle: (state["earthCoord"] as! Coord).polar!.1,
//                                                                                                         revolution: (state["earthRevo"] as! Double))))),
//                                            "marsCoord": Coord(polar: ((state["marsCoord"] as! Coord).polar!.0,
//                                                                        Angle(deg: self.updatePlanetPos(currentAngle: (state["marsCoord"] as! Coord).polar!.1,
//                                                                                                        revolution: (state["marsRevo"] as! Double))))),
//                                            "jupiterCoord": Coord(polar: ((state["jupiterCoord"] as! Coord).polar!.0,
//                                                                           Angle(deg: self.updatePlanetPos(currentAngle: (state["jupiterCoord"] as! Coord).polar!.1,
//                                                                                                           revolution: (state["jupiterRevo"] as! Double))))),
//                                            "saturnCoord": Coord(polar: ((state["saturnCoord"] as! Coord).polar!.0,
//                                                                          Angle(deg: self.updatePlanetPos(currentAngle: (state["saturnCoord"] as! Coord).polar!.1,
//                                                                                                          revolution: (state["saturnRevo"] as! Double))))),
//                                            "uranusCoord": Coord(polar: ((state["uranusCoord"] as! Coord).polar!.0,
//                                                                          Angle(deg: self.updatePlanetPos(currentAngle: (state["uranusCoord"] as! Coord).polar!.1,
//                                                                                                          revolution: (state["uranusRevo"] as! Double))))),
//                                            "neptuneCoord": Coord(polar: ((state["neptuneCoord"] as! Coord).polar!.0,
//                                                                           Angle(deg: self.updatePlanetPos(currentAngle: (state["neptuneCoord"] as! Coord).polar!.1,
//                                                                                                           revolution: (state["neptuneRevo"] as! Double))))),
//                                     ]
//                         )
//       let _ = self.render()
//     }
//
//     func render() -> (Sphere, Sphere, Sphere, Sphere, Sphere, Sphere, Sphere, Sphere, Sphere) {
//       return (
//         Sphere(name: "Solar", pos: (state["solarCoord"] as! Coord), props: [state["solarRadius"]]),
//         Sphere(name: "Mercury", pos: (state["mercuryCoord"] as! Coord), props: [state["mercuryRadius"]]),
//         Sphere(name: "Venus", pos: (state["venusCoord"] as! Coord), props: [state["venusRadius"]]),
//         Sphere(name: "Earth", pos: (state["earthCoord"] as! Coord), props: [state["earthRadius"]]),
//         Sphere(name: "Mars", pos: (state["marsCoord"] as! Coord), props: [state["marsRadius"]]),
//         Sphere(name: "Jupiter", pos: (state["jupiterCoord"] as! Coord), props: [state["jupiterRadius"]]),
//         Sphere(name: "Saturn", pos: (state["saturnCoord"] as! Coord), props: [state["saturnRadius"]]),
//         Sphere(name: "Uranus", pos: (state["uranusCoord"] as! Coord), props: [state["uranusRadius"]]),
//         Sphere(name: "Neptune", pos: (state["neptuneCoord"] as! Coord), props: [state["neptuneRadius"]])
//       )
//     }
// }
//

class SystemSolar: Scene {

  override init() {
    super.init()

    backgroundColor = "#000000"

    let solarRadius: Double = 50.0

    // planet = [name, radius, solar_dist, polar_angle, revolution, texture_path]
    let listPlanet = [["Mercury", sizePlanet(s: solarRadius, p: 11440), distPlanet(s: solarRadius, d: 35.791), 0.0, 88.0, "/img/mercury_tex.jpeg"],
                      ["Venus", sizePlanet(s: solarRadius, p: 15052), distPlanet(s: solarRadius, d: 45.82), 0.0, 225.0, "/img/venus_tex.jpg"],
                      ["Earth", sizePlanet(s: solarRadius, p: 16371), distPlanet(s: solarRadius, d: 64.96), 0.0, 365.0, "/img/earth_tex.jpg"],
                      ["Mars", sizePlanet(s: solarRadius, p: 12390), distPlanet(s: solarRadius, d: 72.79), 0.0, 687.0, "/img/mars_tex.jpg"],
                      ["Jupiter", sizePlanet(s: solarRadius, p: 69911), distPlanet(s: solarRadius, d: 97.85), 0.0, 1380.0, "/img/jupiter_tex.jpg"],
                      ["Saturn", sizePlanet(s: solarRadius, p: 58232), distPlanet(s: solarRadius, d: 143.40), 0.0, 3585.0, "/img/saturn_tex.jpg"],
                      ["Uranus", sizePlanet(s: solarRadius, p: 25362), distPlanet(s: solarRadius, d: 227.10), 0.0, 4660.0, "/img/uranus_tex.jpg"],
                      ["Neptune", sizePlanet(s: solarRadius, p: 24622), distPlanet(s: solarRadius, d: 350.50), 0.0, 6225.0, "/img/neptune_tex.jpg"]
                     ]

    // Create a sphere for the solar
    let solar = root.createChild()
    solar.name = "Solar"
    solar.model = Model(
      meshes: [.sphere(segments: 100, rings: 100, radius: solarRadius)],
      materials: [Material()])
    // Apply a texture to the solar
    solar.model?.materials[0].diffuse = .texture(ImageTexture(image: Image(contentsOfFile: "Sources"+"/img/solar_tex.jpg")!, wrapMethod: .repeat))
    // Modify its color
    //solar.model?.materials[0].multiply = .color(Color(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5))
    solar.translation.x = 0.0
    solar.translation.y = 0.0
    solar.translation.z = 0.0

    // Create a sphere for each planet
    for planet in listPlanet {
      var planetAngle: Double = (planet[3] as! Double)
      let p = root.createChild()
      p.name = (planet[0] as! String)
      p.model = Model(
        meshes: [.sphere(segments: 50, rings: 50, radius: (planet[1] as! Double))],
      materials: [Material()])
      // Apply a texture to each planet
      p.model?.materials[0].diffuse = .texture(ImageTexture(image: Image(contentsOfFile: "Sources"+(planet[5] as! String))!, wrapMethod: .repeat))
      // p.translation.z = -x because x = -z
      p.translation.z = -(self.P2C(r: (planet[2] as! Double), theta: planetAngle)).0
      // p.translation.x = -y because y = -x
      p.translation.x = -(self.P2C(r: (planet[2] as! Double), theta: planetAngle)).1

      // Rotate the planets on them self
      var a = Angle(radians: 0)
      AppContext.shared.subscribe(frameListener: { _, delta in
        a += .rad(Double(delta) / 1000)
        p.rotation = Quaternion(axis: .unitY, angle: a)
      })

      // Change the planets' position
      AppContext.shared.subscribe(frameListener: { _, delta in
        // Compute polar coordinates and compote (x,y) cartesian coordinates to update planets' position
        var newTheta = self.updatePostion(revo: (planet[4] as! Double), angle: planetAngle)
        // p.translation.z = -x because x = -z
        p.translation.z = -(self.P2C(r: (planet[2] as! Double), theta: newTheta)).0
        // p.translation.x = -y because y = -x
        p.translation.x = -(self.P2C(r: (planet[2] as! Double), theta: newTheta)).1
        planetAngle = newTheta

      })

    }

    // Define the lighting of the scene
    let lightNode = root.createChild()
    lightNode.light = Light(type: .directional)
    lightNode.light?.isCastingShadow = true
    lightNode.translation = Vector3(x: 10.0, y: 5.0, z: 7.5)
    lightNode.constraints.append(LookAtConstraint(target: root))


    // Define the user view (camera)
    let cameraNode = root.createChild()
    cameraNode.name = "Camera"
    cameraNode.camera = Camera()
    cameraNode.camera?.farDistance = 5000.0
    cameraNode.translation = Vector3(x: 750.0, y: 65, z: 0.0)
    cameraNode.constraints.append(LookAtConstraint(target: root))
  }

  // Update the polar angle of each planet
  func updatePostion(revo: Double, angle: Double) -> Double {
    let newAngle = angle + (360/(revo*50))
    return (newAngle.truncatingRemainder(dividingBy: 360.0))
  }

  // Convert polar coordinates to cartesian
  func P2C(r: Double, theta: Double) -> (Double, Double) {
    let x = r * cos(theta)
    let y = r * sin(theta)
    return (x,y)
  }

  // Convert cartesian coordinates to polar
  func C2P(x: Double, y: Double) -> (Double, Double) {
    let r = sqrt(pow(x,2) + pow(y,2))
    let theta = atan(y/x)*(180/Double.pi)
    return (r,theta)
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
}

// Call sampleScene() to build the entire scene
func sampleScene() {

  // Initialize Rendery's engine.
  guard let window = AppContext.shared.initialize(width: 1500, height: 800, title: "Solar System")
    else { fatalError() }
  //defer { AppContext.shared.clear() } #TODO: bug under linux
  // Create the game scene and present it in the window's viewport.
  let scene = SystemSolar()
  window.viewports.first?.present(scene: scene)

  // Run the rendering loop.
  AppContext.shared.targetFrameRate = 60
  AppContext.shared.render()
}

// Entry: Call the highest component
//let _ = SystemSolar()
sampleScene()
