class Jurl < Formula
  desc "curl that reads the page for you: decision models pick the paragraphs, links, code and images that matter"
  homepage "https://jurl.dev"
  version "0.1.10"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/rayoplateado/jurl/releases/download/v0.1.10/jurl-aarch64-apple-darwin.tar.xz"
      sha256 "b55c3a4eb7c0c4a3247d657c15e576f930aeb4c946e5f3475793ed524c1cce2f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/rayoplateado/jurl/releases/download/v0.1.10/jurl-x86_64-apple-darwin.tar.xz"
      sha256 "ecf713027b7c3e54ea1263aa585fe94a6bb2a68d99da9041cf3987663d87c557"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/rayoplateado/jurl/releases/download/v0.1.10/jurl-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "34ff94d765165eeb932611f778b1fd344dcb768d4001083c036eadbde9d5d13d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/rayoplateado/jurl/releases/download/v0.1.10/jurl-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "99ef5c48eb70e28edf2f57bc5b1cd7d47eaaee559ba5d2da5757ae7830cd2888"
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
