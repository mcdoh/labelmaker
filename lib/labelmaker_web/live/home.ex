defmodule LabelmakerWeb.Home do
  use LabelmakerWeb, :live_view

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
          <option value="Helvetica" selected={@font == "Helvetica"}>Helvetica</option>
          <option value="Courier" selected={@font == "Courier"}>Courier</option>
          <option value="Times" selected={@font == "Times"}>Times</option>
        </select>
        <select name="color" value={@color}>
          <option value="red" selected={@color == "red"}>red</option>
          <option value="orange" selected={@color == "orange"}>orange</option>
          <option value="yellow" selected={@color == "yellow"}>yellow</option>
          <option value="green" selected={@color == "green"}>green</option>
          <option value="blue" selected={@color == "blue"}>blue</option>
          <option value="indigo" selected={@color == "indigo"}>indigo</option>
          <option value="violet" selected={@color == "violet"}>violet</option>
        </select>
        <select name="size" value={@size}>
          <option value="8" selected={@size == "8"}>8</option>
          <option value="12" selected={@size == "12"}>12</option>
          <option value="16" selected={@size == "16"}>16</option>
          <option value="20" selected={@size == "20"}>20</option>
          <option value="24" selected={@size == "24"}>24</option>
          <option value="28" selected={@size == "28"}>28</option>
          <option value="32" selected={@size == "32"}>32</option>
        </select>
        <button type="submit">Create</button>
      </form>
    </div>
    """
  end
end
