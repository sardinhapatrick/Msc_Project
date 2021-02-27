import Msc_Project
import Foundation
import Glibc

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
      log(str: "render a Sphere for [\(name) at position: \(pos) with props: \(props)]")
      return (
          Mesh(meshType: "Sphere", meshPosition: pos, meshProps: props)
      )
    }
}

class SystemSolar {
    var state: Dictionary<String, Any> = [:]
    var callTick: Bool = true

    init() {
        self.state =  ["solarCoord": Coord(polar: (0, Angle(deg: 0))), "solarRevo": 0.0, "solarRadius": 696340.0,
                       "mercuryCoord": Coord(polar: (58, Angle(deg: 0))), "mercuryRevo": 88.0, "mercuryRadius": 2440.0,
                       "venusCoord": Coord(polar: (108, Angle(deg: 0))), "venusRevo": 225.0, "venusRadius": 6050.0,
                       "earthCoord": Coord(polar: (150, Angle(deg: 0))), "earthRevo": 365.0, "earthRadius": 6370.0,
                       "marsCoord": Coord(polar: (228, Angle(deg: 0))), "marsRevo": 687.0, "marsRadius": 3390.0,
                       "jupiterCoord": Coord(polar: (779, Angle(deg: 0))), "jupiterRevo": 4380.0, "jupiterRadius": 69910.0,
                       "saturnCoord": Coord(polar: (1434, Angle(deg: 0))), "saturnRevo": 10585.0, "saturnRadius": 58230.0,
                       "uranusCoord": Coord(polar: (2871, Angle(deg: 0))), "uranusRevo": 30660.0, "uranusRadius": 25360.0,
                       "neptuneCoord": Coord(polar: (4495, Angle(deg: 0))), "neptuneRevo": 60225.0, "neptuneRadius": 24600.0
                     ]
        self.subTick(interval: 1)
    }

    // Directly call when the component is created
    func subTick(interval: UInt32) {
        self.callTick = true
        while(callTick) {
            log(str: "\n\n\(self.state)\n")
            self.tick()
            sleep(interval)
        }
    }

    // Call when the component is removed
    func unsubTick() {
       self.callTick = false
    }

    func updatePlanetPos(currentAngle: Angle, revolution: Double) -> Double {
      let newAngle = currentAngle.deg!+(360/revolution)
      return (newAngle.truncatingRemainder(dividingBy: 360.0))
    }

    func tick() {
      self.state = updateState(currentState: state,
                               nextState: ["mercuryCoord": Coord(polar: ((state["mercuryCoord"] as! Coord).polar!.0,
                                                                          Angle(deg: self.updatePlanetPos(currentAngle: (state["mercuryCoord"] as! Coord).polar!.1,
                                                                                                          revolution: (state["mercuryRevo"] as! Double))))),
                                           "venusCoord": Coord(polar: ((state["venusCoord"] as! Coord).polar!.0,
                                                                        Angle(deg: self.updatePlanetPos(currentAngle: (state["venusCoord"] as! Coord).polar!.1,
                                                                                                        revolution: (state["venusRevo"] as! Double))))),
                                           "earthCoord": Coord(polar: ((state["earthCoord"] as! Coord).polar!.0,
                                                                        Angle(deg: self.updatePlanetPos(currentAngle: (state["earthCoord"] as! Coord).polar!.1,
                                                                                                        revolution: (state["earthRevo"] as! Double))))),
                                           "marsCoord": Coord(polar: ((state["marsCoord"] as! Coord).polar!.0,
                                                                       Angle(deg: self.updatePlanetPos(currentAngle: (state["marsCoord"] as! Coord).polar!.1,
                                                                                                       revolution: (state["marsRevo"] as! Double))))),
                                           "jupiterCoord": Coord(polar: ((state["jupiterCoord"] as! Coord).polar!.0,
                                                                          Angle(deg: self.updatePlanetPos(currentAngle: (state["jupiterCoord"] as! Coord).polar!.1,
                                                                                                          revolution: (state["jupiterRevo"] as! Double))))),
                                           "saturnCoord": Coord(polar: ((state["saturnCoord"] as! Coord).polar!.0,
                                                                         Angle(deg: self.updatePlanetPos(currentAngle: (state["saturnCoord"] as! Coord).polar!.1,
                                                                                                         revolution: (state["saturnRevo"] as! Double))))),
                                           "uranusCoord": Coord(polar: ((state["uranusCoord"] as! Coord).polar!.0,
                                                                         Angle(deg: self.updatePlanetPos(currentAngle: (state["uranusCoord"] as! Coord).polar!.1,
                                                                                                         revolution: (state["uranusRevo"] as! Double))))),
                                           "neptuneCoord": Coord(polar: ((state["neptuneCoord"] as! Coord).polar!.0,
                                                                          Angle(deg: self.updatePlanetPos(currentAngle: (state["neptuneCoord"] as! Coord).polar!.1,
                                                                                                          revolution: (state["neptuneRevo"] as! Double))))),
                                    ]
                        )
      let _ = self.render()
    }

    func render() -> (Sphere, Sphere, Sphere, Sphere, Sphere, Sphere, Sphere, Sphere, Sphere) {
      return (
        Sphere(name: "Solar", pos: (state["solarCoord"] as! Coord), props: [state["solarRadius"]]),
        Sphere(name: "Mercury", pos: (state["mercuryCoord"] as! Coord), props: [state["mercuryRadius"]]),
        Sphere(name: "Venus", pos: (state["venusCoord"] as! Coord), props: [state["venusRadius"]]),
        Sphere(name: "Earth", pos: (state["earthCoord"] as! Coord), props: [state["earthRadius"]]),
        Sphere(name: "Mars", pos: (state["marsCoord"] as! Coord), props: [state["marsRadius"]]),
        Sphere(name: "Jupiter", pos: (state["jupiterCoord"] as! Coord), props: [state["jupiterRadius"]]),
        Sphere(name: "Saturn", pos: (state["saturnCoord"] as! Coord), props: [state["saturnRadius"]]),
        Sphere(name: "Uranus", pos: (state["uranusCoord"] as! Coord), props: [state["uranusRadius"]]),
        Sphere(name: "Neptune", pos: (state["neptuneCoord"] as! Coord), props: [state["neptuneRadius"]])
      )
    }
}


// Entry: Call the highest component
let _ = SystemSolar()
