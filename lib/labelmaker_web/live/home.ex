defmodule LabelmakerWeb.Home do
  use LabelmakerWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, :label, "")}
  end

  def handle_event("update_label", %{"label" => label}, socket) do
    {:noreply, assign(socket, :label, label)}
  end

  def render(assigns) do
    ~H"""
    <div>
      <h1>|{@label}|</h1>
      <form phx-change="update_label">
        <input type="text" name="label" value={@label} placeholder="Enter your label" />
      </form>
    </div>
    """
  end
end
