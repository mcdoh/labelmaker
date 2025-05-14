defmodule Mix.Tasks.Labelmaker.Release do
  use Mix.Task

  @shortdoc "Builds and releases the labelmaker Docker image"

  def run(_args) do
    cmd = "docker"

    args = [
      "buildx",
      "build",
      "--network=host",
      "--no-cache",
      "-t",
      "192.168.0.2:5000/labelmaker",
      "--push",
      "."
    ]

    IO.puts("Running Docker build and push...")

    {_output, exit_code} =
      System.cmd(cmd, args, into: IO.stream(:stdio, :line), stderr_to_stdout: true)

    if exit_code != 0 do
      Mix.raise("Docker buildx failed with exit code #{exit_code}")
    end
  end
end
