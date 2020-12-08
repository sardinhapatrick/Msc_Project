

let m1 = ConsDecl(location : 1,
                  cons_type: mat4,
                  cons_name: "modelToWorldMatrix")

let v = ConsDecl(cons_type: vec3,
                 cons_name: "uniformVect")


let v1 = VarDecl(location: 0,
                infix_keyword: "in",
                var_type: vec3,
                var_name: aVec)

let v2 = VarDecl(infix_keyword: "out",
                 var_type: vec3,
                 var_name: ourColor)

let v3 = VarDecl(var_type: int,
                 var_name: foo)

let f1 = FunDecl(fun_name: "main",
                 parameters: [],
                 return_type: "void",
                 block: // Code
                )

let p = ParamDecl(param_name: "v",
                  param_type: vec3)



let s = StrucDecl(struc_name: "aStruct",
                  field: [v1, v2],
                  fun: [])

let aE = AssignExpr(expr: "FragColor",
                    value: "vertexColor")

let bE = BinaryExpr(lhs: 1,
                    op: "+"
                    rhs: 2)


let ifB = IfBranch(expr: condition,
                   ifBlock: // Block instructions
                   elseBlock: // Block else inst.
                  )

let v3 = VarDecl(var_type: int,
                 var_name: foo)

let f1 = FunDecl(fun_name: "main",
                 parameters: [],
                 return_type: "void",
                 block: v3
                )

                
