defmodule LabelmakerWeb.LabelController do
  use LabelmakerWeb, :controller
  alias LabelmakerWeb.Constants
  alias LabelmakerWeb.Tools

  @label_dir Path.join(:code.priv_dir(:labelmaker), "static/labels")

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
    File.mkdir_p!(@label_dir)

    args = [
      "-background",
      "none",
      "-fill",
      options.color,
      "-pointsize",
      options.size,
      "-font",
      options.font,
      "label:#{String.slice(options.label, 0, Constants.max_label_length())}",
      "-set",
      "comment",
      inspect(Jason.encode!(Map.drop(options, [:link]))),
      filepath
    ]

    args =
      if options.outline != "none" do
        [
          "-stroke",
          options.outline,
          "-strokewidth",
          "1"
        ] ++ args
      else
        args
      end

    {_, 0} = System.cmd("magick", args)
  end
end
