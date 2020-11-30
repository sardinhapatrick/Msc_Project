//version 330 core

let (aPos, loc_aPos): (Vector3, Int) = (nil, 0)
let (aColor, loc_aColor): (Color, Int) = (nil, 1)

func main() -> (Vector4, Color) {
     let gl_Position: Vector4 = aPos.cat(v1: aPos, d: 1.0)
     let ourColor: Color = aColor
     return (gl_Position, ourColor)
}
