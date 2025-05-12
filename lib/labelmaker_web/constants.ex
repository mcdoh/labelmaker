defmodule LabelmakerWeb.Constants do
  @defaults %{
    label: "",
    font: "Helvetica",
    color: "black",
    outline: "white",
    size: "32"
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

  @colors System.cmd("magick", ["-list", "color"])
          |> elem(0)
          |> String.split("\n")
          # drop header stuff
          |> Enum.drop(5)
          |> Enum.map(fn color_info -> color_info |> String.split() |> List.first() end)
          |> Enum.reject(&is_nil/1)
          # filter out colors that end in a number (no CSS equivalent)
          |> Enum.reject(fn color -> String.match?(color, ~r/\d+$/) end)
          |> Enum.uniq()

  @fonts System.cmd("magick", ["-list", "font"])
         |> elem(0)
         |> String.split("\n")
         |> Enum.filter(&String.starts_with?(&1, "  Font:"))
         |> Enum.reject(&String.starts_with?(&1, "  Font: ."))
         |> Enum.map(&String.trim_leading(&1, "  Font: "))

  @max_label_length 64
  @max_label_error "64-character maximum"

  @outlines ~w(none white black gray)

  @sizes 8..72
         |> Enum.to_list()
         |> Enum.take_every(4)
         |> Enum.map(&Integer.to_string/1)

  def colors, do: @colors
  def color_count, do: @colors |> length()
  def defaults, do: @defaults
  def fonts, do: @fonts
  def font_count, do: @fonts |> length()
  def max_label_length, do: @max_label_length
  def max_label_error, do: @max_label_error
  def outlines, do: @outlines
  def permitted_keys, do: @permitted_keys
  def preview, do: @preview
  def sizes, do: @sizes
end
