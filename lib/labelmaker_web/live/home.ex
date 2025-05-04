defmodule LabelmakerWeb.Home do
  use LabelmakerWeb, :live_view
  alias LabelmakerWeb.Constants

  def mount(_params, _session, socket) do
    {:ok,
     assign(socket,
       label: "",
       font: "Helvetica",
       color: "black",
       size: "24"
     )}
  end

  def handle_event("update_label", params, socket) do
    {:noreply,
     assign(socket,
       label: params["label"] || "",
       font: params["font"] || "Helvetica",
       color: params["color"] || "black",
       size: params["size"] || "24"
     )}
  end

  def handle_event("make_label", params, socket) do
    {:noreply, push_navigate(socket, to: ~p"/#{params["label"]}?#{Map.drop(params, ["label"])}")}
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
