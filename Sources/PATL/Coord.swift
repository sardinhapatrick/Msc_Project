import Rendery
import Foundation
import Glibc

public struct Coord {

  // public init(cart: (Double, Double, Double)) {
  //   self.cart = cart
  // }
  //
  // public init(polar: (Double, Angles, Angles)) {
  //   self.cart = (polar.0 * sin(polar.1.deg) * cos(polar.2.deg),
  //                polar.0 * sin(polar.1.deg) * sin(polar.2.deg),
  //                polar.0 * cos(polar.1.deg))
  // }
  //
  // public var cart: (Double, Double, Double)
  //
  // public var polar: (Double, Angles, Angles) {
  //   get {
  //         (sqrt(pow(cart.0,2) + pow(cart.1,2) + pow(cart.2,2)),
  //          Angles(deg: atan2(cart.1, cart.0)),
  //          Angles(deg: acos(cart.2 / (sqrt(pow(cart.0,2) + pow(cart.1,2) + pow(cart.2,2))))))
  //       }
  //
  // }

  // public static func polar(_ value: (Double, Angles, Angles)) -> Coord { Coord(polar: value) }
  //
  // public static func cart(_ value: (Double, Double, Double)) -> Coord { Coord(cart: value) }

  public var polar: (Double, Angles, Angles) = (0.0, Angles(deg: 0.0), Angles(deg: 0.0))
  public var cart: (Double, Double, Double) = (0.0, 0.0, 0.0)

  public init(polar: (Double, Angles, Angles)) {
    self.polar = polar
  }

  public init(cart: (Double, Double, Double)) {
    self.cart = cart
  }

  public func polarToCart() -> (Double, Double, Double) {
    let x = polar.0 * sin(polar.1.deg) * cos(polar.2.deg)
    let y = polar.0 * sin(polar.1.deg) * sin(polar.2.deg)
    let z = polar.0 * cos(polar.1.deg)
    return (x,y,z)
  }

}
