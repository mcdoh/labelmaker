defmodule LabelmakerWeb.LabelController do
  use LabelmakerWeb, :controller
  alias LabelmakerWeb.Tools

  @label_dir Path.join(:code.priv_dir(:labelmaker), "static/labels")
  File.mkdir_p!(@label_dir)

  def show(conn, params) do
    options = Tools.process_parameters(params)

    filename =
      options
      |> inspect()
      |> (fn str -> :crypto.hash(:sha256, str) end).()
      |> Base.encode16(case: :lower)

    filename = filename <> ".png"
    filepath = Path.join(@label_dir, filename)

    unless File.exists?(filepath) do
      generate_image(options, filepath)
    end

    conn
    |> put_resp_content_type("image/png")
    |> send_file(200, filepath)
  end

  defp generate_image(options, filepath) do
    args = [
      "-background",
      "none",
      "-fill",
      options.color,
      "-pointsize",
      options.size,
      "-font",
      options.font,
      "label:#{options.label}",
      "-set",
      "comment",
      inspect(Jason.encode!(options)),
      filepath
    ]

    {_, 0} = System.cmd("magick", args)
  end
end
