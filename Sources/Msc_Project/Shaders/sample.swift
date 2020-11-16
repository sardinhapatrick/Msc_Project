//version 330 core

let aPos: Vector3 = Vector3(x: 1.0, y: 1.0, z: 0.0)
let aColor: Color = Color(r: 1.0, g: 0.0, b: 0.0)

func main() -> (Vector4, Color) {
     let gl_Position: Vector4 = cat(aPos, 1.0)
     let ourColor: Color = aColor
     return (gl_Position, ourColor)
}
