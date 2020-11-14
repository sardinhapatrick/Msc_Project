import Foundation

// definition of new abstract types as struct
struct Vector3 {
    var x: Double
    var y: Double
    var z: Double

    func add(v1: Vector3, v2: Vector3) -> (Double, Double, Double) {
        return (v1.x + v2.x, v1.y + v2.y, v1.z+v2.z)
    }

    func cat(v1: Vector3, a: Double) -> (Double, Double, Double, Double) {
        return (v1.x, v1.y, v1.z, a)
    }
}

struct Vector4 {
    var x: Double
    var y: Double
    var z: Double
    var w: Double

    func add(v1: Vector4, v2: Vector4) -> (Double, Double, Double, Double) {
        return (v1.x + v2.x, v1.y + v2.y, v1.z+v2.z, v1.w+v2.w)
    }

    func trunc(v1: Vector4) -> (Double, Double, Double) {
        return (v1.x, v1.y, v1.z)
    }
}

struct Color {
    var rgb: Vector3
    var alpha: Double?
}

var vec1: Vector3 = Vector3(x: 1, y:2, z:3)
var vec2: Vector3 = Vector3(x: 10, y:20, z:30)
print(vec1.add(v1:vec1, v2:vec2))
