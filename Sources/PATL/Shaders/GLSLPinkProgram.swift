import Rendery

public struct GLSLPinkShader: GLSLProgramDelegate {

  public init() {
  }

  public let vertexSource = """
  #version 330 core
  layout (location = 0) in vec3 i_position;
  uniform mat4 u_modelViewProjMatrix;
  out vec4 vertexColor;
  void main() {
    gl_Position = u_modelViewProjMatrix * vec4(i_position, 1.0);
    vertexColor = vec4(1.0, 0.75, 0.79, 1.0);
  }
  """

  public let fragmentSource = """
  #version 330 core
  out vec4 FragColor;
  in vec4 vertexColor;
  void main() {
    FragColor = vertexColor;
  }
  """

}
