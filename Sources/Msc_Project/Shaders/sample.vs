#version 330 core

let aPos: Vector3 = Vector3(x: ,y: ,z: )
let aColor: Vector3 = Vector3(x: ,y:, z: )

func main() -> (Vector3, Vector3) {
     let gl_Position: Vector3 = cat(aPos, 1.0)
     let ourColor: Vector3 = aColor
     return (gl_Position, ourColor)
}
