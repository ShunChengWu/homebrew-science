require "formula"

class Flann < Formula
  homepage "http://www.cs.ubc.ca/~mariusm/index.php/FLANN/FLANN"
  url "http://people.cs.ubc.ca/~mariusm/uploads/FLANN/flann-1.8.4-src.zip"
  sha256 "dfbb9321b0d687626a644c70872a2c540b16200e7f4c7bd72f91ae032f445c08"

  deprecated_option "enable-matlab" => "with-octave"
  deprecated_option "enable-python" => "with-python"

  option "with-octave", "Enable Matlab/Octave bindings"
  option "with-examples", "Build and install example binaries"

  depends_on "cmake" => :build
  depends_on "hdf5"
  depends_on "python" => :optional
  depends_on "octave" => :optional
  depends_on "numpy" => :python if build.with? "python"

  def install
    args = std_cmake_args
    args << "-DBUILD_MATLAB_BINDINGS:BOOL=" + (build.with?("octave") ? "ON" : "OFF")
    args << "-DBUILD_PYTHON_BINDINGS:BOOL=" + (build.with?("python") ? "ON" : "OFF")

    inreplace "CMakeLists.txt", "add_subdirectory( examples )", "" if build.without? "examples"

    mkdir "build" do
      system "cmake", "..", *args
      system "make", "install"
    end
  end
end
