defmodule LabelmakerWeb.Label do
  use LabelmakerWeb, :live_view

  @label_dir Path.join(:code.priv_dir(:labelmaker), "static/labels")

  def mount(%{"label" => label}, _session, socket) do
    File.mkdir_p!(@label_dir)

    filename = "#{label}.png"
    filepath = Path.join(@label_dir, filename)

    unless File.exists?(filepath) do
      generate_label_image(label, filepath)
    end

    {:ok,
     assign(socket,
       label: label,
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

  defp generate_label_image(label, filepath) do
    args = [
      "-background",
      "none",
      "-fill",
      "black",
      "-pointsize",
      "24",
      "-font",
      "Comic-Sans-MS",
      "label:#{label}",
      filepath
    ]

    {_, 0} = System.cmd("magick", args)

    IO.puts(filepath)
    # png_binary = File.read!(filepath)
    # File.rm(tmp_file)
    # Base.encode64(png_binary)
  end
end
