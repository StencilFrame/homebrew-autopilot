class Autopilot < Formula
  desc "AutoPilot allows you to execute runbooks with minimal setup and maximum flexibility. A system for gradual runbook automation."
  homepage "https://github.com/StencilFrame/autopilot"
  url "https://github.com/StencilFrame/autopilot/archive/refs/tags/v0.5.0.tar.gz"
  sha256 "d518af81c98e4ab3046f11646ecc6be5a76788dc3c3b9b44f3fca17bd8924ced"
  license "Apache-2.0"
  head "https://github.com/StencilFrame/autopilot.git", branch: "main"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  depends_on "go" => :build

  def install
    ldflags = "-s -w -X main.versionInfo=#{version}"
    system "go", "build", *std_go_args(ldflags:), "./pkg/cmd/autopilot"
    generate_completions_from_executable bin/"autopilot", "completion"
  end

  test do
    run_output = shell_output("#{bin}/autopilot version")
    assert_match "AutoPilot version: #{version}", run_output
  end
end