# Labelmaker

[Labelmaker](https://labelmaker.xyz) is a simple web tool for generating text-based images, perfect for creating decals in [Tabletop Simulator](https://www.tabletopsimulator.com/). Just append your desired text to the URL and Labelmaker will return an image, no design tools required.

## ✨ Features

- 📦 Instant text-to-image conversion via URL
- 🎨 Customizable `color`, `outline`, `font`, and `size` via query string
- 🧩 Designed for ease of use with Tabletop Simulator
- 🧭 Interactive homepage to preview available options

## 🚀 Usage

### Basic Label

[https://labelmaker.xyz/Hello World](https://labelmaker.xyz/Hello%20World)

Generates an image of "Hello World" in the default style.

![Hello World](https://labelmaker.xyz/Hello%20World?outline=white)

### Set Text Color

[https://labelmaker.xyz/Hello?color=yellow](https://labelmaker.xyz/Hello?color=yellow)

Renders "Hello" in yellow text.

![Yellow Hello](https://labelmaker.xyz/Hello?color=yellow)

### Add Outline

[https://labelmaker.xyz/Hello?color=yellow&outline=black](https://labelmaker.xyz/Hello?color=yellow&outline=black)

Renders "Hello" in yellow with a black outline, perfect for contrast on similar backgrounds.

![Outlined yellow Hello](https://labelmaker.xyz/Hello?color=yellow&outline=black)

### Customize Font and Size

[https://labelmaker.xyz/Courier?font=Courier&size=96&color=CornFlowerBlue&outline=white](https://labelmaker.xyz/Courier?font=Courier&size=96&color=CornFlowerBlue&outline=white)

Uses the `Courier` font at 96px size.

![CornflowerBlue Courier](https://labelmaker.xyz/Courier?font=Courier&size=72&color=CornflowerBlue&outline=white)

### Multiple Lines

[https://labelmaker.xyz/Multiple\nLines?font=DejaVu-Sans-Oblique&color=orange](https://labelmaker.xyz/Multiple\nLines?font=DejaVu-Sans-Oblique&color=orange)

Use `\n` to insert line breaks.

![Multiple\nLines](https://labelmaker.xyz/Multiple\nLines?font=DejaVu-Sans-Oblique&size=72&color=orange)

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
