defmodule LabelmakerWeb.Home do
  use LabelmakerWeb, :live_view
  alias LabelmakerWeb.Constants
  alias LabelmakerWeb.Tools

  def mount(_params, _session, socket) do
    assigns =
      Constants.defaults()
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

  def handle_event("update_preview", %{"bg" => bg}, socket) do
    {:noreply, assign(socket, :preview_bg, bg)}
  end

  def handle_event("update_label", params, socket) do
    assigns =
      socket.assigns
      |> Enum.map(fn {k, v} -> {Atom.to_string(k), v} end)
      |> Map.new()
      |> Map.merge(params)
      |> Tools.process_parameters()
      |> Enum.to_list()

    {:noreply, assign(socket, assigns)}
  end

  def handle_event("make_label", params, socket) do
    {:noreply, redirect(socket, to: ~p"/#{params["label"]}?#{Map.drop(params, ["label"])}")}
  end

  def render(assigns) do
    preview_background =
      case assigns.preview_bg do
        "r" -> "bg-[linear-gradient(to_right,_black_33%,_white_67%)]"
        "b" -> "bg-[linear-gradient(to_bottom,_black_33%,_white_67%)]"
        "c" -> ""
        _ -> "bg-[linear-gradient(to_right,_black_33%,_white_67%)]"
      end

    assigns =
      assign(
        assigns,
        label_too_long: String.length(assigns.label) > Constants.max_label_length(),
        preview_background: preview_background
      )

    ~H"""
    <div class="max-w-xl mx-auto p-3 space-y-5">
      <h1 class="text-5xl font-bold text-center text-primary">Labelmaker</h1>
      <p class="text-l text-center w-[350px] m-auto">
        Easily create text-based images. Perfect for quickly creating decals in Tabletop Simulator.
      </p>

      <div
        class={
          "flex justify-center items-center p-4 overflow-hidden whitespace-nowrap border rounded transition duration-300 #{@preview_background} #{if @label_too_long, do: "border-danger", else: "border-primary"} #{if @label_too_long, do: "outline-danger", else: @outline != "none" && "outline-#{@outline}"}"}
        style={"height: calc(2rem + #{@preview_height}px); color: #{if @label_too_long, do: "white", else: @color}; #{Tools.outline(@outline, @label_too_long)} font-family: #{@font}; font-size: #{@size}px; line-height: #{@size}px; background-color: #{if @preview_bg == "c", do: @color, else: ""}"}
      >
        <%= if @label_too_long do %>
          {Constants.max_label_error()}
        <% else %>
          <%= for {str, i} <- Enum.with_index(@preview_text) do %>
            {str}
            {if i < length(@preview_text) - 1, do: raw("<br />")}
          <% end %>
        <% end %>
      </div>
      <div class="flex flex-row justify-between" style="margin-top: 5px;">
        <p class="text-xs text-gray-600 dark:text-gray-400 m-0 ml-1">
          Note: not all fonts are available for preview.
        </p>
        <div class="flex flex-row gap-1">
          <div
            phx-click="update_preview"
            phx-value-bg="r"
            class="w-[12px] h-[12px] bg-gradient-to-r from-black to-white cursor-pointer"
          >
          </div>
          <div
            phx-click="update_preview"
            phx-value-bg="b"
            class="w-[12px] h-[12px] bg-gradient-to-b from-black to-white cursor-pointer"
          >
          </div>
          <div
            phx-click="update_preview"
            phx-value-bg="c"
            class="w-[12px] h-[12px] cursor-pointer"
            style={"background-color: #{@color}"}
          >
          </div>
        </div>
      </div>

      <form
        id="labelmaker"
        phx-hook="PersistData"
        phx-change="update_label"
        phx-submit="make_label"
        class="space-y-4"
      >
        <div>
          <label for="label" class="block text-sm font-medium">Label</label>
          <input
            phx-hook="EnterToNewline"
            type="text"
            id="label"
            name="label"
            value={@label}
            placeholder="Enter text"
            class={"mt-1 block w-full rounded border border-gray-300 px-3 py-2 text-fg-light dark:text-fg-dark dark:border-gray-600 focus:ring-primary dark:placeholder-gray-400/50 transition duration-300 #{if @label_too_long, do: "bg-danger", else: "bg-secondary-light dark:bg-secondary-dark"}"}
          />
          <p class="text-xs text-gray-600 dark:text-gray-400 m-0 ml-1">
            <code>\n</code> or &LT;Enter&GT; for newlines
          </p>
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
      </form>

      <div class="text-center">
        <a href={@link}>
          <button class="inline-block bg-primary text-fg-light dark:text-fg-dark px-4 py-2 rounded hover:bg-highlight focus:ring-fg-light focus:dark:ring-fg-dark">
            Create
          </button>
        </a>
      </div>
    </div>
    """
  end
end
