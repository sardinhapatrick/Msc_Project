
let v1: Vector3 = Vector3(x:1,y:1,z:1)
let c1: Color = Color(r:1,g:0,b:0)
print("v1: \(v1)")

readSwiftShader(shaderType: "vertex", name: "sample", ext: "swift")


// ----

let (aPos, loc_aPos): (Vector3, Int) = (v1, 0)
let (aColor, loc_aColor): (Color, Int) = (c1, 1)

func main() -> (Vector4, Color) {
     let gl_Position: Vector4 = aPos.cat(v1: aPos, d: 1.0)
     let ourColor: Color = aColor
     return (gl_Position, ourColor)
}

print(main())
