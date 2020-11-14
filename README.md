# Msc_Project

The idea of this project is to facilitate the creation of graphics programs (shaders) using a Swift oriented DSL and type abstraction, then using an encoder to translate these Swift shaders into GLSL shaders.

## Getting Started

### Prerequisites

To use this project you will need some prerequisites:

	* [Swift version 5.3](https://swift.org/download/#releases)
	
	* More soon

### Installing

First of all, you need to clone the repository:

```bash
git clone https://github.com/sardinhapatrick/Msc_Project.git

```

### Usage

To run the Swift program:

```bash
swift \[name_file\].swift

```

To run the main GLSL program you must use g++ as below:

```bash
g++ -pthread -o \[name\_file\] \[name\_file.c\] glad.c -lglfw -lGLU -lGL -lXrandr -lXxf86vm -lXi -lXinerama -lX11 -lrt -ldl

```

And then run the executable:

```bash
./\[name\_file\]

```

## License

This project does not have a license yet.
