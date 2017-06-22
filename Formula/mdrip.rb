# Documentation: http://docs.brew.sh/Formula-Cookbook.html
#                http://www.rubydoc.info/github/Homebrew/brew/master/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!

require "language/go"
class Mdrip < Formula
  desc "mdrip rips labeled command blocks from markdown files for execution."
  homepage "https://github.com/monopole/mdrip"
  head "https://github.com/monopole/mdrip.git"

  depends_on "go" => :build
  depends_on "tmux"


  
  go_resource "github.com/golang/glog" do
    url "https://github.com/golang/glog.git",
      :revision => "23def4e6c14b4da8ac2ed8007337bc5eb5007998"
  end
  
  def install
    ENV["GOPATH"] = buildpath
    mkdir_p "src/github.com/monopole"
    ln_s buildpath, "src/github.com/monopole/mdrip"
    Language::Go.stage_deps resources, buildpath/"src"
    inreplace "tmux/tmux.go", "/usr/bin/tmux", "/usr/local/bin/tmux"
 
    system "go", "build", "-o", bin/"mdrip"
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! It's enough to just replace
    # "false" with the main program this formula installs, but it'd be nice if you
    # were more thorough. Run the test with `brew test mdrip`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "go", "test", "." 
  end
end
