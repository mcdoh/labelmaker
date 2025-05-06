defmodule LabelmakerWeb.Tools do
  alias LabelmakerWeb.Constants

  def process_parameters(parameters) do
    parameters =
      parameters
      |> Map.take(Constants.permitted_keys())
      |> Map.new(fn {k, v} -> {String.to_atom(k), v} end)
      |> Enum.filter(fn {k, v} ->
        case k do
          :color -> v in Constants.colors()
          :font -> v in Constants.fonts()
          :label -> String.length(v) <= Constants.max_label_length()
          :size -> v in Constants.sizes()
          _ -> true
        end
      end)
      |> Map.new()

    Map.merge(Constants.defaults(), parameters)
  end
end
