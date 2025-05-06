defmodule LabelmakerWeb.Home do
  use LabelmakerWeb, :live_view
  alias LabelmakerWeb.Constants
  alias LabelmakerWeb.Tools

  def mount(_params, _session, socket) do
    {
      :ok,
      assign(
        socket,
        Enum.to_list(%{Constants.defaults() | label: ""})
      )
    }
  end

  def handle_event("update_label", params, socket) do
    {:noreply, assign(socket, Tools.process_parameters(params))}
  end

  def handle_event("make_label", params, socket) do
    {:noreply, redirect(socket, to: ~p"/#{params["label"]}?#{Map.drop(params, ["label"])}")}
  end

  def render(assigns) do
    ~H"""
    <div>
      <h1>Label Maker</h1>
      <form phx-change="update_label" phx-submit="make_label">
        <input type="text" name="label" value={@label} placeholder="Enter text" />
        <div style={
          "color: #{@color}; font-family: #{@font}; font-size: #{@size}px;"
        }>
          {@label}
        </div>
        <select name="font" value={@font}>
          <%= for font <- Constants.fonts() do %>
            <option value={font} selected={@font == font}>{font}</option>
          <% end %>
        </select>
        <select name="color" value={@color}>
          <%= for color <- Constants.colors() do %>
            <option value={color} selected={@color == color}>{color}</option>
          <% end %>
        </select>
        <select name="outline" value={@outline}>
          <%= for outline <- Constants.outlines() do %>
            <option value={outline} selected={@outline == outline}>{outline}</option>
          <% end %>
        </select>
        <select name="size" value={@size}>
          <%= for size <- Constants.sizes() do %>
            <option value={size} selected={@size == size}>{size}</option>
          <% end %>
        </select>
        <button type="submit">Create</button>
      </form>
    </div>
    """
  end
end
