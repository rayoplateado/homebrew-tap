class Jurl < Formula
  desc "curl that reads the page for you: decision models pick the paragraphs, links, code and images that matter"
  homepage "https://jurl.dev"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/rayoplateado/jurl/releases/download/v0.1.0/jurl-aarch64-apple-darwin.tar.xz"
      sha256 "1851ed7db5c52b8694233903347498626579de28593d24506743781cc295fe9e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/rayoplateado/jurl/releases/download/v0.1.0/jurl-x86_64-apple-darwin.tar.xz"
      sha256 "8af5e35faab4a54c9775761407c6114275046f2f1003011944bc7e0a672e1202"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/rayoplateado/jurl/releases/download/v0.1.0/jurl-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "d6ebb852a700cf33fe9465a8aac14af105d4878b24c18fe122339520b6cde792"
    end
    if Hardware::CPU.intel?
      url "https://github.com/rayoplateado/jurl/releases/download/v0.1.0/jurl-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "b8cbb4022a57641b822e2a1ed2fbb819e2bfa249507daf3fa02125ff6617c036"
    end
  end
  license any_of: ["MIT", "Apache-2.0"]

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "jurl"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "jurl"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "jurl"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "jurl"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
