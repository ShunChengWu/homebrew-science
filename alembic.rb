
class Alembic < Formula
  homepage "http://alembic.io"
  url "https://github.com/alembic/alembic/archive/1.5.8.zip"
  sha256 "1f347a0e310d096370fe2afd3a83674e9a00776f1ab74ec601fddbf8657ed568"
  version "1.5.8"
  head "https://github.com/alembic/alembic.git", :using => :git

  needs :cxx11
  depends_on "cmake"    => :build
  depends_on "hdf5"     => :recommended
  depends_on "openexr"  => :recommended
  depends_on "ilmbase"
  depends_on "boost"

  def install
    cmake_args = std_cmake_args + %W[
      -DUSE_PYILMBASE=OFF
      -DUSE_PRMAN=OFF
      -DUSE_ARNOLD=OFF
      -DUSE_MAYA=OFF
      -DUSE_PYALEMBIC=OFF
      -DCMAKE_CXX_FLAGS='-std=c++11\ -stdlib=libc++'
    ]
    system "cmake", ".", *cmake_args
    system "make", "install"

    # move everything upwards
    lib.install_symlink Dir[prefix/"alembic-#{version}/lib/static/*"]
    include.install_symlink Dir[prefix/"alembic-#{version}/include/*"]
    bin.install_symlink Dir[prefix/"alembic-#{version}/bin/*"]
  end
end
