defmodule LabelmakerWeb.Constants do
  @defaults %{
    label: "",
    link: "",
    font: "Helvetica",
    color: "black",
    outline: "none",
    size: "72"
  }

  @preview %{
    preview_bg: "r",
    preview_height: @defaults.size,
    preview_text: []
  }

  @permitted_keys @defaults
                  |> Map.merge(@preview)
                  |> Map.keys()
                  |> Enum.map(&Atom.to_string/1)

  @colors [
    "black",
    "blue",
    "brown",
    "gray",
    "green",
    "orange",
    "pink",
    "purple",
    "red",
    "white",
    "yellow"
  ]

  @danger "#FF6B6B"

  @font_map %{
    "cs" => "Comic-Sans-MS",
    "comic" => "Comic-Sans-MS",
    "comic sans" => "Comic-Sans-MS",
    "comic-sans" => "Comic-Sans-MS",
    "comic-sans-ms" => "Comic-Sans-MS",
    "cr" => "Courier",
    "courier" => "Courier",
    "g" => "Georgia",
    "georgia" => "Georgia",
    "h" => "Helvetica",
    "helvetica" => "Helvetica",
    "i" => "Impact",
    "impact" => "Impact",
    "v" => "Verdana",
    "verdana" => "Verdana"
  }

  @max_label_length 64
  @max_label_error "64-character maximum"

  @sizes 16..128
         |> Enum.to_list()
         |> Enum.take_every(8)
         |> Enum.map(&Integer.to_string/1)

  def colors, do: @colors
  def danger, do: @danger
  def defaults, do: @defaults

  def fonts,
    do:
      @font_map
      |> Map.values()
      |> Enum.uniq()
      |> Enum.map(fn color -> color |> String.replace("-MS", "") |> String.replace("-", " ") end)

  def font_map, do: @font_map
  def max_label_length, do: @max_label_length
  def max_label_error, do: @max_label_error
  def outlines, do: ["none" | @colors]
  def permitted_keys, do: @permitted_keys
  def preview, do: @preview
  def sizes, do: @sizes
end
