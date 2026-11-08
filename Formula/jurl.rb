class Jurl < Formula
  desc "curl that reads the page for you: decision models pick the paragraphs, links, code and images that matter"
  homepage "https://jurl.dev"
  version "0.2.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/rayoplateado/jurl/releases/download/v0.2.2/jurl-aarch64-apple-darwin.tar.xz"
      sha256 "6ffd1c5539282b375045ae4eec600a92ab28328e59c8db7a398262f557a2f0c2"
    end
    if Hardware::CPU.intel?
      url "https://github.com/rayoplateado/jurl/releases/download/v0.2.2/jurl-x86_64-apple-darwin.tar.xz"
      sha256 "d4c6cacf1252a5361d37da07b2a0de20fc5c15f2e0c9aed4fd397cddfaf0e634"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/rayoplateado/jurl/releases/download/v0.2.2/jurl-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "874fb719ac5da210692c8d119ce6399ea4f87b8a4e685d5f50e07d91b766dc1b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/rayoplateado/jurl/releases/download/v0.2.2/jurl-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "81baec44ab7f5e3700cdcd8c506fa6ca7f51337f4a62d16ae7b82246115e0f5d"
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
