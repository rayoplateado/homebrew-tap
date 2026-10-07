class Jurl < Formula
  desc "curl that reads the page for you: decision models pick the paragraphs, links, code and images that matter"
  homepage "https://jurl.dev"
  version "0.1.7"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/rayoplateado/jurl/releases/download/v0.1.7/jurl-aarch64-apple-darwin.tar.xz"
      sha256 "d0d0819c09ed292c5e427a5f35b4d34c83f24eac9eea32416f53c1e61c9d1d79"
    end
    if Hardware::CPU.intel?
      url "https://github.com/rayoplateado/jurl/releases/download/v0.1.7/jurl-x86_64-apple-darwin.tar.xz"
      sha256 "45b93eee0bda424c6da67fb811447137859d9c94a7dcb323844147d8adb073a5"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/rayoplateado/jurl/releases/download/v0.1.7/jurl-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "33fa251c5da9c59f50333e14f44dee8a76824d70fc3b2f511202c26323ab777f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/rayoplateado/jurl/releases/download/v0.1.7/jurl-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "3a2a13f2ecbb2e9c1494ac96954fed8a780d4fc3bc3ea3a2f2a388be9d8c2494"
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
