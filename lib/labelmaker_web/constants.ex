defmodule LabelmakerWeb.Constants do
  @defaults %{
    "label" => "64 character maximum",
    "font" => "Helvetica",
    "color" => "black",
    "size" => "24"
  }

  @permitted_keys Map.keys(@defaults)

  @colors System.cmd("magick", ["-list", "color"])
          |> elem(0)
          |> String.split("\n")
          # drop header stuff
          |> Enum.drop(5)
          |> Enum.map(fn color_info -> color_info |> String.split() |> List.first() end)

  @fonts System.cmd("magick", ["-list", "font"])
         |> elem(0)
         |> String.split("\n")
         |> Enum.filter(&String.starts_with?(&1, "  Font:"))
         |> Enum.reject(&String.starts_with?(&1, "  Font: ."))
         |> Enum.map(&String.trim_leading(&1, "  Font: "))

  @max_label_length 64

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
  def permitted_keys, do: @permitted_keys
  def sizes, do: @sizes
end
