defmodule LabelmakerWeb.Home do
  use LabelmakerWeb, :live_view
  alias LabelmakerWeb.Constants
  alias LabelmakerWeb.Tools

  def mount(_params, _session, socket) do
    assigns =
      Constants.defaults()
      |> Map.replace(:label, "")
      |> Map.merge(Constants.preview())
      |> Enum.to_list()

    {
      :ok,
      assign(
        socket,
        assigns
      )
    }
  end

  def handle_event("update_label", params, socket) do
    assigns =
      params
      |> Map.merge(Constants.stringview())
      |> Tools.process_parameters()
      |> Enum.to_list()

    {:noreply, assign(socket, assigns)}
  end

  def handle_event("make_label", params, socket) do
    {:noreply, redirect(socket, to: ~p"/#{params["label"]}?#{Map.drop(params, ["label"])}")}
  end

  def render(assigns) do
    ~H"""
    <div class="max-w-xl mx-auto p-4 space-y-6">
      <h1 class="text-2xl font-bold text-center">Labelmaker</h1>

      <div
        class={[
          "flex justify-center items-center p-4 overflow-hidden whitespace-nowrap bg-gradient-to-r from-black to-white border rounded border-primary",
          @outline != "none" && "outline-#{@outline}"
        ]}
        style={"height: calc(2rem + #{@preview_height}px); color: #{@color}; font-family: #{@font}; font-size: #{@size}px; line-height: #{@size}px;"}
      >
        <%= for {str, i} <- Enum.with_index(@preview_text) do %>
          {str}
          {if i < length(@preview_text) - 1, do: raw("<br />")}
        <% end %>
      </div>

      <form phx-change="update_label" phx-submit="make_label" class="space-y-4">
        <div>
          <label for="label" class="block text-sm font-medium">Label</label>
          <input
            type="text"
            id="label"
            name="label"
            value={@label}
            placeholder="Enter text"
            class="mt-1 block w-full rounded border border-gray-300 px-3 py-2 bg-secondary-light text-fg-light dark:bg-secondary-dark dark:text-fg-dark dark:border-gray-600 focus:ring-primary dark:placeholder-gray-400/50"
          />
        </div>

        <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
          <div>
            <label for="font" class="block text-sm font-medium">Font</label>
            <select
              id="font"
              name="font"
              class="mt-1 block w-full rounded border border-gray-300 px-3 py-2 bg-secondary-light text-fg-light dark:bg-secondary-dark dark:text-fg-dark dark:border-gray-600 focus:ring-primary"
            >
              <%= for font <- Constants.fonts() do %>
                <option value={font} selected={@font == font}>{font}</option>
              <% end %>
            </select>
          </div>

          <div>
            <label for="color" class="block text-sm font-medium">Color</label>
            <select
              id="color"
              name="color"
              class="mt-1 block w-full rounded border border-gray-300 px-3 py-2 bg-secondary-light text-fg-light dark:bg-secondary-dark dark:text-fg-dark dark:border-gray-600 focus:ring-primary"
            >
              <%= for color <- Constants.colors() do %>
                <option value={color} selected={@color == color}>{color}</option>
              <% end %>
            </select>
          </div>

          <div>
            <label for="outline" class="block text-sm font-medium">Outline</label>
            <select
              id="outline"
              name="outline"
              class="mt-1 block w-full rounded border border-gray-300 px-3 py-2 bg-secondary-light text-fg-light dark:bg-secondary-dark dark:text-fg-dark dark:border-gray-600 focus:ring-primary"
            >
              <%= for outline <- Constants.outlines() do %>
                <option value={outline} selected={@outline == outline}>{outline}</option>
              <% end %>
            </select>
          </div>

          <div>
            <label for="size" class="block text-sm font-medium">Size</label>
            <select
              id="size"
              name="size"
              class="mt-1 block w-full rounded border border-gray-300 px-3 py-2 bg-secondary-light text-fg-light dark:bg-secondary-dark dark:text-fg-dark dark:border-gray-600 focus:ring-primary"
            >
              <%= for size <- Constants.sizes() do %>
                <option value={size} selected={@size == size}>{size}</option>
              <% end %>
            </select>
          </div>
        </div>

        <div class="text-center">
          <button
            type="submit"
            class="inline-block bg-primary text-fg-light dark:text-fg-dark px-4 py-2 rounded hover:bg-highlight focus:ring-fg-light focus:dark:ring-fg-dark"
          >
            Create
          </button>
        </div>
      </form>
    </div>
    """
  end
end
