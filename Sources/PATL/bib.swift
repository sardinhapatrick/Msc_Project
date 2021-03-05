import Rendery
import Foundation
import Glibc


///////////////////////////////////////////////////////////////////////////////
/*
// structure declaration

public struct Mesh {
    // Here we work with 2D cartesian and 2D polar coordinates
    public var meshType: String
    public var meshPosition: (Double, Double)
    public var meshProps: [Any?]

    public init(meshType: String, meshPosition: (Double, Double), meshProps: [Any?]) {
        self.meshType = meshType
        self.meshPosition = meshPosition
        self.meshProps = meshProps
    }
}

public struct Angles {
    public var deg: Double?
    public var rad: Double?

    public init(deg: Double? = nil, rad: Double? = nil) {
        self.deg = deg
        self.rad = rad
    }

    public func degToRad() -> Double {
        return (deg! * (Double.pi/180))
    }

    public func radToDeg() -> Double {
        return rad! * (180/Double.pi)
    }
}

public struct Coord {
    public var polar: (Double, Angles)?
    public var cart: (Double, Double)?

    public init(polar: (Double, Angles)? = nil, cart: (Double, Double)? = nil) {
        self.polar = polar
        self.cart = cart
    }

    public func polarToCart() -> (Double, Double) {
        let x = polar!.0 * cos(polar!.1.deg!)
        let y = polar!.0 * sin(polar!.1.deg!)
        return (x,y)
    }

    public func cartToPolar() -> (Double, Angles) {
        let r = sqrt(pow(cart!.0, 2.0) + pow(cart!.1, 2.0))
        let t = Angles(deg: atan(cart!.1 / cart!.0))
        return (r,t)
    }

}


// function declarations

public func log(str: String) {
    print(str)
}

public func updateState(currentState: [String: [String: Any]], nextState: [String: [String: Any]]) -> [String: [String: Any]] {
    var tmpState = currentState
    for (outerKey, _) in nextState {
        for (innerKey, _) in nextState[outerKey]! {
            tmpState[outerKey]![innerKey]! = nextState[outerKey]![innerKey]!
            //tmpState[outerKey]![innerKey]!.updateValue(nextState[outerKey]!, forKey: innerKey)
        }
    }
    return tmpState
}


/// ---- --- -- - -- - - --

// public class Sol: Node {
//   public init(scene: Scene) {
//     // Create a sphere for the solar
//       let solar = root.createChild()
//       print(solar)
//       solar.name = "Solar"
//       solar.model = Model(
//         meshes: [.sphere(segments: 100, rings: 100, radius: 5.0)],
//         materials: [Material()])
//       // Apply a texture to the solar
//       solar.model?.materials[0].diffuse = .texture(ImageTexture(image: Image(contentsOfFile: "Sources"+"/img/pink_tex.jpg")!, wrapMethod: .repeat))
//       // Modify its color
//       //solar.model?.materials[0].multiply = .color(Color(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5))
//       solar.translation.x = 0.0
//       solar.translation.y = 0.0
//       solar.translation.z = 0.0
//   }
//
// }


public class SystemSolar: Scene {

  public override init() {
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

    // // Create a sphere for the solar
    //let solar = root.createChild() // solar is type Node
    //let s = Node().init(scene: self)
    let solar = root.createChild()
    //print("->", type(of:solar))
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
  public func updatePostion(revo: Double, angle: Double) -> Double {
    let newAngle = angle + (360/(revo*50))
    return (newAngle.truncatingRemainder(dividingBy: 360.0))
  }

  // Convert polar coordinates to cartesian
  public func P2C(r: Double, theta: Double) -> (Double, Double) {
    let x = r * cos(theta)
    let y = r * sin(theta)
    return (x,y)
  }

  // Convert cartesian coordinates to polar
  public func C2P(x: Double, y: Double) -> (Double, Double) {
    let r = sqrt(pow(x,2) + pow(y,2))
    let theta = atan(y/x)*(180/Double.pi)
    return (r,theta)
  }

  // Real planet scale
  public func sizePlanet(s: Double, p: Double) -> Double {
    return (p*s)/696340
  }

  // Real distance solar - planets
  public func distPlanet(s: Double, d: Double) -> Double {
    let d_m = d*pow(10.0, 6)
    return -1*(d_m/696340)
  }
}

// Call sampleScene() to build the entire scene
public func createScene(name: String, scene: Scene) {

  // Initialize Rendery's engine.
  guard let window = AppContext.shared.initialize(width: 1500, height: 800, title: name)
    else { fatalError() }
  //defer { AppContext.shared.clear() } #TODO: bug under linux
  // Create the game scene and present it in the window's viewport.
  let scene = scene
  window.viewports.first?.present(scene: scene)

  // Run the rendering loop.
  AppContext.shared.targetFrameRate = 60
  AppContext.shared.render()
}
*/
///////////////////////////////////////////////////////////////////////////////

// Build the Scene related to ComponentTopLevel
open class ComponentTopLevel: Scene {
  public override init() {
    super.init()
    // Define the camera which gives us a view to the scene
    let cameraNode = root.createChild()
    cameraNode.name = "Camera"
    cameraNode.camera = Camera()
    cameraNode.camera?.farDistance = 5000.0
    cameraNode.translation = Vector3(x: 750.0, y: 65, z: 0.0)
    cameraNode.constraints.append(LookAtConstraint(target: root))
  }

  // Set the background color of the scene
  public func setBackgroundColor(colHexa: Color) -> Color {
    backgroundColor = colHexa
    return backgroundColor!
  }

  public func createSphere(name: String, seg: Int, rin: Int, rad: Double, tex: String, x: Double, y: Double, z: Double) {
    let child = root.createChild()
    child.name = name
    child.model = Model(
      meshes: [.sphere(segments: seg, rings: rin, radius: rad)],
      materials: [Material()])
    // Apply a texture to the solar
    child.model?.materials[0].diffuse = .texture(ImageTexture(image: Image(contentsOfFile: "Sources"+tex)!, wrapMethod: .repeat))
    // Modify its color
    //child.model?.materials[0].multiply = .color(Color(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5))
    child.translation.x = x
    child.translation.y = y
    child.translation.z = z
  }

}


public struct Angles {
    public var deg: Double?
    public var rad: Double?

    public init(deg: Double? = nil, rad: Double? = nil) {
        self.deg = deg
        self.rad = rad
    }

    public func degToRad() -> Double {
        return (deg! * (Double.pi/180))
    }

    public func radToDeg() -> Double {
        return rad! * (180/Double.pi)
    }
}

public struct Coord {
    public var polar: (Double, Angles)?
    public var cart: (Double, Double)?

    public init(polar: (Double, Angles)? = nil, cart: (Double, Double)? = nil) {
        self.polar = polar
        self.cart = cart
    }

    public func polarToCart() -> (Double, Double) {
        let x = polar!.0 * cos(polar!.1.deg!)
        let y = polar!.0 * sin(polar!.1.deg!)
        return (x,y)
    }

    public func cartToPolar() -> (Double, Angles) {
        let r = sqrt(pow(cart!.0, 2.0) + pow(cart!.1, 2.0))
        let t = Angles(deg: atan(cart!.1 / cart!.0))
        return (r,t)
    }

}

// First function to call:
public func createScene(name: String, compTL: Scene) {
  // Initialize Rendery's engine.
  guard let window = AppContext.shared.initialize(width: 1500, height: 800, title: name)
    else { fatalError() }
  //defer { AppContext.shared.clear() } #TODO: bug under linux

  // Create the game scene and present it in the window's viewport.
  let scene = compTL
  window.viewports.first?.present(scene: scene)

  // Run the rendering loop.
  AppContext.shared.targetFrameRate = 60
  AppContext.shared.render()
}
