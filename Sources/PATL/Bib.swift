import Rendery
import Foundation
import Glibc

// Build the Scene related to ComponentTopLevel
open class ComponentTopLevel: Scene {
  public override init() {
    super.init()

  }

  public func createCamera(farDistance: Double, x: Double, y: Double, z: Double) -> Node {
    // Define the camera which gives us a view to the scene
    let cameraNode = root.createChild()
    cameraNode.name = "Camera"
    cameraNode.camera = Camera()
    cameraNode.camera?.farDistance = farDistance
    cameraNode.translation = Vector3(x: x, y: y, z: z)
    cameraNode.constraints.append(LookAtConstraint(target: root))
    return cameraNode
  }

  public func createLight(x: Double, y: Double, z: Double) -> Node {
    let lightNode = root.createChild()
    lightNode.light = Light(type: .directional)
    lightNode.light?.isCastingShadow = true
    lightNode.translation = Vector3(x: x, y: y, z: z)
    lightNode.constraints.append(LookAtConstraint(target: root))
    return lightNode
  }

  // Set the background color of the scene
  public func setBackgroundColor(colHexa: Color) {
    backgroundColor = colHexa
  }

  // Create a Child node in the current scene
  public func createChildNode(name: String) -> Node {
    let node = root.createChild()
    node.name = name
    return node
  }

  // Apply the "tex" texture to the node
  public func applyTextureFromImg(node: Node, tex: String) {
    // TODO: Add the different possibles wrapMethod
    node.model?.materials[0].diffuse = .texture(ImageTexture(image: Image(contentsOfFile: "Sources"+tex)!, wrapMethod: .repeat))

  }

  public func applyTextureFromShaders(node: Node, customShader: Any?) {
    node.model?.materials[0] = (customShader as! Material)
  }

  // TODO: fix me ?
  public func applyTextureFromColor(node: Node, rgba: (Double, Double, Double, Double)) {
    node.model?.materials[0].multiply = .color(Color(red: rgba.0, green: rgba.1, blue: rgba.2, alpha: rgba.3))
  }

  // Set the position of a node
  public func setNodePosition(node: Any, x: Double, y: Double, z: Double) {
    (node as! Node).translation.x = x
    (node as! Node).translation.y = y
    (node as! Node).translation.z = z
  }

  // Define a node as sphere with some properties: (segments, rings, radius)
  public func createSphere(node: Node, segments: Int, rings: Int, radius: Double) {
    // By default a new Sphere has (0,0,0) as coordinates
    node.model = Model(
      meshes: [.sphere(segments: segments, rings: rings, radius: radius)],
      materials: [Material()]) // --> Always create object with the default shader can be changed in applyTextureFromShaders()
    print(node.model!.name)
  }

  public func createBox(node: Node) {
    node.model = Model(
      // TODO: inputable centeredAt & dimensions
      meshes: [.box(.init(centeredAt: .zero, dimensions: .unitScale))],
      materials: [Material()])
  }

  public func createRectangle(node: Node) {
    node.model = Model(
      // TODO: inputable centeredAt & dimensions + output missing?
      meshes: [.rectangle(Rectangle(centeredAt: .zero, dimensions: Vector2(x: 5.0, y: 5.0)))],
      materials: [Material()])
  }

  // TODO: Add function to generate other basic mesh


  // https://products.aspose.app/3d/conversion/glb-to-gltf : convert glb to gltf
  public func loadGLTF() {
      let t = GLTFFile(contentsOfFile: "Sources/models/azeria/scene.gltf")
      // let nnn: Node? = nil
      // nnn!.model = Model(
      //   meshes: [t!.models[0].meshes[0]],
      //   materials: [t!.models[0].materials[0]])
      let tt = t!.models[0].meshes[0]
      //print("\n-->",t!.models,"\n")
      print("\n-->",t!,"\n")
  }
}

public func test_load_blend() {
    let t = BlendFile(contentsOfFile: "Sources/models/piper.blend")
    print(t!)
}

public func importCustomShader(shaderProgram: GLSLProgramDelegate) -> Material {
  let material = Material(program: GLSLProgram(delegate: shaderProgram))
  return material
}


public func registerTick(selectorUpdate: @escaping () -> Void) {
  AppContext.shared.subscribe(frameListener: { _, delta in
    selectorUpdate()
  })
}


public func getKeyEvent() -> String {
  // Directional keys
  let keyUpPressed = AppContext.shared.inputs.isPressed(key: 265)
  let keyDownPressed = AppContext.shared.inputs.isPressed(key: 264)
  let keyLeftPressed = AppContext.shared.inputs.isPressed(key: 263)
  let keyRightPressed = AppContext.shared.inputs.isPressed(key: 262)

  // w a s d keys
  let keyWPressed = AppContext.shared.inputs.isPressed(key: 87)
  let keySPressed = AppContext.shared.inputs.isPressed(key: 83)
  let keyAPressed = AppContext.shared.inputs.isPressed(key: 65)
  let keyDPressed = AppContext.shared.inputs.isPressed(key: 68)

  if (keyUpPressed || keyWPressed) {
    return "W"
  }
  if (keyDownPressed || keySPressed) {
    return "S"
  }
  if (keyLeftPressed || keyAPressed) {
    return "A"
  }
  if (keyRightPressed || keyDPressed) {
    return "D"
  }
  return ""
}

public func getMouseEvent() -> String {
  // Mouse button
  let button0Pressed = AppContext.shared.inputs.isPressed(mouseButton: 0)
  let button1Pressed = AppContext.shared.inputs.isPressed(mouseButton: 1)
  if (button0Pressed) {
    return "0"
  }
  if (button1Pressed) {
    return "1"
  }
  return ""
}


// Predefined function to update the global state of the application
public func updateState(currentState: [String: [String: Any]], nextState: [String: [String: Any]]) -> [String: [String: Any]] {
    var tmpState = currentState
    for (outerKey, _) in nextState {
        for (innerKey, _) in nextState[outerKey]! {
            tmpState[outerKey]![innerKey]! = nextState[outerKey]![innerKey]!
        }
    }
    return tmpState
}



// First function to call:
public func createScene(name: String, compTL: Scene) {
  // Initialize Rendery's engine.
  guard let window = AppContext.shared.initialize(width: 1500, height: 800, title: name)
    else { fatalError() }
  //defer { AppContext.shared.clear() } #TODO: bug with linux

  // Create the game scene and present it in the window's viewport.
  let scene = compTL
  window.viewports.first?.present(scene: scene)

  // Run the rendering loop.
  AppContext.shared.targetFrameRate = 60
  AppContext.shared.render()
}
