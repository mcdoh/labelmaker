defmodule LabelmakerWeb.Label do
  use LabelmakerWeb, :live_view

  @label_dir Path.join(:code.priv_dir(:labelmaker), "static/labels")
  File.mkdir_p!(@label_dir)

  @defaults %{
    "label" => "Labelmaker",
    "font" => "Helvetica",
    "color" => "black",
    "size" => "24"
  }

  @permitted_keys Map.keys(@defaults)

  def mount(params, _session, socket) do
    options =
      @defaults
      |> Map.merge(params)
      |> Map.take(@permitted_keys)

    IO.inspect(options)
    filename = "#{options["label"]}.png"
    filepath = Path.join(@label_dir, filename)

    unless File.exists?(filepath) do
      generate_label_image(options, filepath)
    end

    {:ok,
     assign(socket,
       label: options["label"],
       image_path: ~p"/labels/#{filename}"
     )}
  end

  def render(assigns) do
    ~H"""
    <div>
      <h1>Label: {@label}</h1>
      <img src={@image_path} alt="" />
    </div>
    """
  end

  defp generate_label_image(options, filepath) do
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
      filepath
    ]

    {_, 0} = System.cmd("magick", args)

    IO.puts(filepath)
    # png_binary = File.read!(filepath)
    # File.rm(tmp_file)
    # Base.encode64(png_binary)
  end

  # defp get_image_settings(socket) do
  #
  # end
end
