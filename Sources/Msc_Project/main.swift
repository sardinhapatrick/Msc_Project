import PATL
import Foundation
import Glibc

// To run the application: swift run Msc_Project [arg]

let arguments = CommandLine.arguments

if (arguments[1] == "tutorial") {
  entry_point_tutorial()
} else {
  entry_point_system_solar()
}
