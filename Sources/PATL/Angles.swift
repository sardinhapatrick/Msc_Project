import Rendery
import Foundation
import Glibc

public struct Angles {

  public init(deg: Double) {
    self.deg = deg
  }

  public init(rad: Double) {
    self.deg = rad * (180/Double.pi)
  }

  public var deg: Double

  public var rad: Double {
    get { deg * (Double.pi/180) }
    set { deg = newValue * (180/Double.pi) }
  }

  public static func rad(_ value: Double) -> Angles { Angles(rad: value) }

  public static func deg(_ value: Double) -> Angles { Angles(deg: value) }

}
