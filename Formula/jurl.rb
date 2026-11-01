class Jurl < Formula
  desc "curl that reads the page for you: decision models pick the paragraphs, links, code and images that matter"
  homepage "https://jurl.dev"
  version "0.2.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/rayoplateado/jurl/releases/download/v0.2.1/jurl-aarch64-apple-darwin.tar.xz"
      sha256 "27f6db3ef068ae91497650aac0d8e177924153690ed871577d67d91b396167a4"
    end
    if Hardware::CPU.intel?
      url "https://github.com/rayoplateado/jurl/releases/download/v0.2.1/jurl-x86_64-apple-darwin.tar.xz"
      sha256 "294e2a1d7c4f0b07521b1c073d4e5d0fb56d511f8e96890528f38e6b794a32a9"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/rayoplateado/jurl/releases/download/v0.2.1/jurl-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "ca9c72204d381b8d8cc7e5efca116bd1fa354df5dfabdf324a80c9df8819c5c7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/rayoplateado/jurl/releases/download/v0.2.1/jurl-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "77bd16322c26e8a7521548fcb36fe3aa7c859799783cd163da38d5180314440b"
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
