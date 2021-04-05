import Rendery
import Foundation
import Glibc

public struct Coord {

  public init(cart: (Double, Double, Double)) {
    self.cart = cart
  }

  public init(polar: (Double, Angles, Angles)) {
    self.cart = (polar.0 * sin(polar.1.deg) * cos(polar.2.deg),
                 polar.0 * sin(polar.1.deg) * sin(polar.2.deg),
                 polar.0 * cos(polar.1.deg))
  }

  public var cart: (Double, Double, Double)

  public var polar: (Double, Angles, Angles) {
    get {
        var sign: Double
        switch cart.0 {
        case let x where x >= 0:
          sign = 1.0
        default:
          sign = -1.0
        }
        return (sign*sqrt(pow(cart.0,2) + pow(cart.1,2) + pow(cart.2,2)),
        Angles(deg: acos(cart.2 / (sign*sqrt(pow(cart.0,2) + pow(cart.1,2) + pow(cart.2,2))))),
        Angles(deg: 0.0))
    }
    set(newVal) {
        cart = (newVal.0 * sin(newVal.1.deg) * cos(newVal.2.deg),
                newVal.0 * sin(newVal.1.deg) * sin(newVal.2.deg),
                newVal.0 * cos(newVal.1.deg))
    }
  }


  public static func cart(_ value: (Double,Double,Double)) -> Coord { Coord(cart: value) }

  public static func pol(_ value: (Double, Angles, Angles)) -> Coord { Coord(polar: value) }
}
