
let retourFunc = "void"
//let nameFunc = Name.ope(Ope.plus)
let nameFunc = Name.ident("main")
let bodyFunc = "FragColor = vec4(ourColor, 1.0f);"

let param: Parameter = Parameter(retour: retourFunc, name: nameFunc, body: bodyFunc)
let function = FunDecl(parameters: param)

function.build()
