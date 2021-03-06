import Rendery
import Foundation
import Glibc

public struct Angles {

  public var deg: Double = 0.0
  public var rad: Double = 0.0

  public init(deg: Double) {
    self.deg = deg
  }

  public init(rad: Double) {
    self.rad = rad
  }

  public func degToRad() -> Double {
    return (deg * (Double.pi/180))
  }

  public func radToDeg() -> Double {
    return rad * (180/Double.pi)
  }
}

public struct Coord {

  public var polar: (Double, Angles, Angles) = (0.0, Angles(deg: 0.0), Angles(deg: 0.0))
  public var cart: (Double, Double, Double) = (0.0, 0.0, 0.0)

  public init(polar: (Double, Angles, Angles)) {
    self.polar = polar
  }

  public init(cart: (Double, Double, Double)) {
    self.cart = cart
  }

  public func polarToCart() -> (Double, Double, Double) {
    let x = polar.0 * sin(polar.1.deg) * cos(polar.2.deg)
    let y = polar.0 * sin(polar.1.deg) * sin(polar.2.deg)
    let z = polar.0 * cos(polar.1.deg)
    return (x,y,z)
  }

  // TODO: Convert C2P for 3D coordinates
  // public func cartToPolar() -> (Double, Angles, Anlges) {
  //   let r = sqrt(pow(cart.0, 2.0) + pow(cart.1, 2.0))
  //   let t = Angles(deg: atan(cart.1 / cart.0))
  //   return (r,t)
  // }
}

// Build the Scene related to ComponentTopLevel
open class ComponentTopLevel: Scene {
  public override init() {
    super.init()
    // Define the camera which gives us a view to the scene
    let cameraNode = root.createChild()
    cameraNode.name = "Camera"
    cameraNode.camera = Camera()
    cameraNode.camera?.farDistance = 5000.0
    cameraNode.translation = Vector3(x: 650.0, y: 90, z: 0.0)
    cameraNode.constraints.append(LookAtConstraint(target: root))
  }

  // Set the background color of the scene
  public func setBackgroundColor(colHexa: Color) -> Color {
    backgroundColor = colHexa
    return backgroundColor!
  }

  // Create a Child node in the current scene
  public func createChildNode(name: String) -> Node {
    let node = root.createChild()
    node.name = name
    return node
  }

  // Apply the "tex" texture to the node
  public func applyTexture(node: Node, tex: String) {
    // TODO: Add different possibles map to add texture
    // TODO: Add the different possibles wrapMethod
    // TODO: Add color for Material() not only texture
    node.model?.materials[0].diffuse = .texture(ImageTexture(image: Image(contentsOfFile: "Sources"+tex)!, wrapMethod: .repeat))
  }

  // Set the position of a node
  public func setNodePosition(node: Node, x: Double, y: Double, z: Double) {
    node.translation.x = x
    node.translation.y = y
    node.translation.z = z
  }

  // Define a node as sphere with some properties: (segments, rings, radius)
  public func createSphere(node: Node, segments: Int, rings: Int, radius: Double) {
    node.model = Model(
      meshes: [.sphere(segments: segments, rings: rings, radius: radius)],
      materials: [Material()])
    // By default a new Sphere has (0,0,0) as coordinates
  }

  // Define a node as box with some properties: (segments, rings, radius)
  public func createBox(node: Node) {
    node.model = Model(
      // TODO: inputable centeredAt & dimensions
      meshes: [.box(.init(centeredAt: .zero, dimensions: .unitScale))],
      materials: [Material()])
  }

  // Define a node as rectangle with some properties: (segments, rings, radius)
  public func createRectangle(node: Node) {
    node.model = Model(
      // TODO: inputable centeredAt & dimensions + output missing?
      meshes: [.rectangle(Rectangle(centeredAt: .zero, dimensions: Vector2(x: 5.0, y: 5.0)))],
      materials: [Material()])
  }

  // TODO: Add function to generate other basic mesh


  // TODO HERE ??: Subscribe to function Tick()
  // subTick() call the tick() function "targetFrameRate" per second (defined in createScene())

  // TODO: function unsubTick()

}

// Predefined function to update the global state of the application
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
