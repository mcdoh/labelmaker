defmodule LabelmakerWeb.LabelController do
  use LabelmakerWeb, :controller
  alias LabelmakerWeb.Constants

  @label_dir Path.join(:code.priv_dir(:labelmaker), "static/labels")
  File.mkdir_p!(@label_dir)

  def show(conn, params) do
    params =
      params
      |> Map.take(Constants.permitted_keys())
      |> Enum.filter(fn {k, v} ->
        case k do
          "color" -> v in Constants.colors()
          "font" -> v in Constants.fonts()
          "label" -> String.length(v) <= Constants.max_label_length()
          "size" -> v in Constants.sizes()
          _ -> true
        end
      end)
      |> Map.new()

    options =
      Constants.defaults()
      |> Map.merge(params)

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
      options["color"],
      "-pointsize",
      options["size"],
      "-font",
      options["font"],
      "label:#{options["label"]}",
      "-set",
      "comment",
      inspect(options),
      filepath
    ]

    {_, 0} = System.cmd("magick", args)
  end
end
