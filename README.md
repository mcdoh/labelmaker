# Labelmaker

**Labelmaker** is a simple web tool for generating text-based images, perfect for creating decals in [Tabletop Simulator](https://www.tabletopsimulator.com/). Just append your desired text to the URL and Labelmaker will return an image—no design tools required.

## ✨ Features

- 📦 Instant text-to-image conversion via URL
- 🎨 Customizable `color`, `outline`, `font`, and `size` via query string
- 🧩 Designed for ease of use with Tabletop Simulator
- 🧭 Interactive homepage to preview available options

## 🚀 Usage

### Basic Label

https://labelmaker.xyz/Hello World
Generates an image of "Hello World" in the default style.

### Set Text Color

https://labelmaker.xyz/Hello?color=yellow
Renders "Hello" in yellow text.

### Add Outline

https://labelmaker.xyz/Hello?color=yellow&outline=black
Renders "Hello" in yellow with a black outline—perfect for contrast on similar backgrounds.

### Customize Font and Size

https://labelmaker.xyz/Hello?font=Courier&size=48
Uses the `Courier` font at 48px size.

## ⚙️ Query Parameters

| Parameter | Description         | Example Value           |
| --------- | ------------------- | ----------------------- |
| `color`   | Text color          | `red`, `CornFlowerBlue` |
| `outline` | Outline color       | `black`, `white`        |
| `font`    | Font name           | `Courier`, `Helvetica`  |
| `size`    | Font size in pixels | `24`, `48`              |

## 🧪 Try It Live

Visit the [Labelmaker homepage](https://labelmaker.xyz/) to:

- Preview fonts and colors
- Test out combinations
- Copy generated URLs for use in Tabletop Simulator or elsewhere

## 🧰 Development

This project is powered by Elixir + Phoenix, employs ImageMagick to create the images, and uses Docker for deployment.

### Build & Run Locally

```sh
mix setup
mix phx.server
```

Or use Docker:

```sh
docker build -t labelmaker .
docker run -p 4000:4000 labelmaker
```

```

```
