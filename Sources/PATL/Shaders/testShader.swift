import Rendery

public struct GLSLTestShader: GLSLProgramDelegate {

  public init() {
  }

  public let vertexSource = """
  #version 330 core
  layout (location = 0) in vec3 i_position;
  uniform mat4 u_modelViewProjMatrix;
  uniform mat3 normalMatrix;
  attribute vec3 normal;
  varying vec3 fNormal;

  void main()
  {
    fNormal = normalize(normalMatrix * normal);
    gl_Position = u_modelViewProjMatrix * vec4(i_position, 1.0);
  }
  """

  public let fragmentSource = """
  #version 330 core
  varying vec3 fNormal;

  void main()
  {
    gl_FragColor = vec4(fNormal, 1.0);
  }
  """

}
