import Foundation
import Glibc

// structure declaration

struct Mesh {
    // Here we work with 2D cartesian and 2D polar coordinates
    var meshType: String
    var meshPosition: (Double, Double)
    var meshProps: [Any?]

    init(meshType: String, meshPosition: (Double, Double), meshProps: [Any?]) {
        self.meshType = meshType
        self.meshPosition = meshPosition
        self.meshProps = meshProps
    }
}

struct Angle {
    var deg: Double?
    var rad: Double?

    init(deg: Double? = nil, rad: Double? = nil) {
        self.deg = deg
        self.rad = rad
    }

    func degToRad() -> Double {
        return (deg! * (Double.pi/180))
    }

    func radToDeg() -> Double {
        return rad! * (180/Double.pi)
    }
}

struct Coord {
    var polar: (Double, Angle)?
    var cart: (Double, Double)?

    init(polar: (Double, Angle)? = nil, cart: (Double, Double)? = nil) {
        self.polar = polar
        self.cart = cart
    }

    func polarToCart() -> (Double, Double) {
        let x = polar!.0 * cos(polar!.1.deg!)
        let y = polar!.0 * sin(polar!.1.deg!)
        return (x,y)
    }

    func cartToPolar() -> (Double, Angle) {
        let r = sqrt(pow(cart!.0, 2.0) + pow(cart!.1, 2.0))
        let t = Angle(deg: atan(cart!.1 / cart!.0))
        return (r,t)
    }

}


// function declarations

func log(str: String) {
    print(str)
}

func updateState(currentState: [String: Any], nextState: [String: Any]) -> [String: Any] {
    var tmpState = currentState
    for (key, _) in nextState {
        tmpState.updateValue(nextState[key]!, forKey: key)
    }
    return tmpState
}
