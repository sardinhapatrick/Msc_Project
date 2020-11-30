import Foundation

//infix operator + : AssignmentPrecedence

struct Parameter {
    let retour: String
    let name: Name
    let body: String
}

// inheritting from AST
class FunDecl: AST {
    let parameters: Parameter

    init(parameters: Parameter) {
        self.parameters = parameters
    }

    func build() {
      switch self.parameters.name {
      case .ident(let name):
        print("""
        \n#version 330 core\n\n
        \(self.parameters.retour) \(name)() {\n
        \(self.parameters.body)\n\n}
        """)
      case .ope(let name):
        print("""
        \n#version 330 core\n\n
        \(self.parameters.retour) \(name)() {\n
        \(self.parameters.body)\n\n}
        """)
      }

    }
}

// function name is: identifier | operator
enum Name {
    case ident(String)
    case ope(Ope)
}

// Here need to redefine +,-,*,/, etc?
enum Ope {
    case plus
    case minus
    case mult
    case div
}
