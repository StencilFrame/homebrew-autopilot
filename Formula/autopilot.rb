class Autopilot < Formula
  desc "AutoPilot allows you to execute runbooks with minimal setup and maximum flexibility. A system for gradual runbook automation."
  homepage "https://github.com/StencilFrame/autopilot"
  url "https://github.com/StencilFrame/autopilot/archive/refs/tags/v0.6.1.tar.gz"
  sha256 "b93c7b3476a9952a11c001849bb8e91786a0ce7346fd38a01d4044efe6a2a1a8"
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