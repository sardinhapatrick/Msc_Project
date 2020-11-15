// definition of new abstract types as struct
struct Vector3 {
    var x: Double
    var y: Double
    var z: Double

    func add(v1: Vector3, v2: Vector3) -> (Double, Double, Double) {
        return (v1.x + v2.x, v1.y + v2.y, v1.z+v2.z)
    }

    func cat(v1: Vector3, d: Double) -> (Double, Double, Double, Double) {
        return (v1.x, v1.y, v1.z, d)
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
    var r: Double
    var g: Double
    var b: Double
    var a: Double?
}
