#version 330 core

let ourColor: Color

func main() -> (Vector4) {
     let FragColor: Vector4 = cat(ourColor, 1.0)
     return FragColor
}
