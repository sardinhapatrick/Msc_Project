import PATL
import Foundation
import Glibc

class Tutorial: ComponentTopLevel {

  var state: [String: [String: Any]] = [:]

  override init() {
    super.init()

    self.setBackgroundColor(colHexa: "#ffffff")

    self.state = ["sphere_obj": ["name": "sphere1",
                                 "coord": Coord(cart: (0,0,0)),
                                 "radius": 50.0]
                                ]
    self.render()
  }

  func render() {
    let cam = self.createCamera(farDistance: 5000.0, x: 5.0, y: 0.0, z: -40.0)
    let lig = self.createLight(x: 10.0, y: 5.0, z: 7.5)

    let s1 = SphereObj(name: (self.state["sphere_obj"]!["name"] as! String),
                       scene: self,
                       coord: (self.state["sphere_obj"]!["coord"] as! Coord),
                       props: [(self.state["sphere_obj"]!["radius"] as! Double)]
                       ).render()
  }

  func rerender(newState: [String: [String: Any]], node: [Any]) { }

}

class SphereObj {

  var name: String?
  var scene: Tutorial
  var coord: Coord
  var props: [Any]?
  var node: Any?

  init(name: String, scene: Tutorial, coord: Coord, props: [Any]) {
    self.name = name
    self.scene = scene
    self.coord = coord
    self.props = props
  }

  func render() {
    // let n = scene.createChildNode(name: self.name!)
    // scene.createSphere(node: n, segments: 100, rings: 100, radius: self.props![0] as! Double)
    // scene.applyTextureFromImg(node: n, tex: "/img/red_tex.jpg")

    // let n2 = scene.createChildNode(name: "gltf_obj")
    // scene.loadGLTF(node: n2, path: "Sources/models/azeria/scene.gltf")

    //scene.applyTextureFromImg(node: n2, tex: "/img/red_tex.jpg")

    // let nn = scene.createChildNode(name: "gltf_obj")
    // scene.loadGLTF(node: nn, path: "Sources/models/naruto/scene.gltf")

    // let n3 = scene.createChildNode(name: "gltf_obj")
    // scene.loadGLTF(node: n3, path: "Sources/models/platformer_kit/Models/GLTF format/blockLarge.glb")

    let n4 = scene.createChildNode(name: "gltf_obj")
    scene.loadGLTF(node: n4, path: "Sources/models/Model/Character.glb")
  }

  func rerender() { }
}


func entry_point_tutorial() {
    let _ = createScene(name: "Tutorial", compTL: Tutorial())
}
