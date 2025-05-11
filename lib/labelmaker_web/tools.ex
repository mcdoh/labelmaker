defmodule LabelmakerWeb.Tools do
  alias LabelmakerWeb.Constants

  def process_parameters(parameters) do
    %{"label" => label, "size" => size} = parameters
    line_breaks = Regex.scan(~r/#{Regex.escape("\\n")}/, label) |> length()
    size = String.to_integer(size)

    parameters =
      parameters
      |> Map.take(Constants.permitted_keys())
      |> Map.new(fn {k, v} -> {String.to_atom(k), v} end)
      |> Enum.map(fn
        {:label, label} ->
          if String.length(label) > Constants.max_label_length(),
            do: {:label, String.slice(label, 0, Constants.max_label_length() + 1)},
            else: {:label, label}

        {:preview_height, _} ->
          {:preview_height, size + size * line_breaks}

        {:preview_text, _} ->
          {:preview_text, String.split(label, "\\n")}

        pair ->
          pair
      end)
      |> Enum.filter(fn
        {:color, color} -> color in Constants.colors()
        {:font, font} -> font in Constants.fonts()
        {:outline, outline} -> outline in Constants.outlines()
        {:size, size} -> size in Constants.sizes()
        _ -> true
      end)
      |> Map.new()

    Map.merge(Constants.defaults(), parameters)
  end
end
