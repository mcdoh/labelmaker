# Labelmaker

[Labelmaker](https://labelmaker.xyz) is a simple web tool for generating text-based images, perfect for creating [decals](https://kb.tabletopsimulator.com/game-tools/decal-tool/) in [Tabletop Simulator](https://www.tabletopsimulator.com/). Just append your desired text to the `labelmaker.xyz/` and Labelmaker will return an image, no design tools required! A few options are available via query string parameters: font, color, outline, and size. The homepage offers a form to make things a bit easier.

![Risky business](/priv/static/images/ukraine_1024x512.png)

![Table flip](https://labelmaker.xyz/%28%E2%95%AF%C2%B0%E2%96%A1%C2%B0%29%E2%95%AF%EF%B8%B5%20%7C%5F%5f%7C?color=orange&font=Helvetica&outline=green&size=72)

## ✨ Features

- 📦 Instant text-to-image conversion via URL
- 🎨 Customizable `color`, `outline`, `font`, and `size` via query string
- 🧩 Designed for ease of use with Tabletop Simulator
- 🧭 Interactive homepage to preview available options

## 🚀 Usage

### Basic Label

[https://labelmaker.xyz/Hello World](https://labelmaker.xyz/Hello%20World)

(I'm actually cheating here and appended `?outline=white` so that the image is visible on dark backgrounds)

![Hello World](https://labelmaker.xyz/Hello%20World?outline=white)

### Set Text Color

[https://labelmaker.xyz/Hello?color=yellow](https://labelmaker.xyz/Hello?color=yellow)

![Yellow Hello](https://labelmaker.xyz/Hello?color=yellow)

### Add Outline

[https://labelmaker.xyz/Hello?color=yellow&outline=black](https://labelmaker.xyz/Hello?color=yellow&outline=black)

![Outlined yellow Hello](https://labelmaker.xyz/Hello?color=yellow&outline=black)

### Customize Font and Size

[https://labelmaker.xyz/Comic Sans?font=cs&size=96&color=orange&outline=blue](https://labelmaker.xyz/Comic%20Sans?font=cs&size=96&color=orange&outline=blue)

![Comic Sans](https://labelmaker.xyz/Comic%20Sans?font=cs&size=96&color=orange&outline=blue)

### Multiple Lines

[https://labelmaker.xyz/Multiple\nLines?font=Impact&color=orange](https://labelmaker.xyz/Multiple\nLines?font=Impact&color=orange)

Use `\n` to insert line breaks.

![Multiple\nLines](https://labelmaker.xyz/Multiple\nLines?font=Impact&size=72&color=orange)

## 🧪 Try It Live

Visit the [Labelmaker homepage](https://labelmaker.xyz/) to:

- Preview fonts and colors
- Test out combinations
- Copy generated URLs for use in Tabletop Simulator or elsewhere

## ⚙️ Query Parameters

| Parameter | Description         | Values            |
| --------- | ------------------- | ----------------- |
| `color`   | Text color          | `black`           |
|           |                     | `blue`            |
|           |                     | `brown`           |
|           |                     | `gray`            |
|           |                     | `green`           |
|           |                     | `orange`          |
|           |                     | `pink`            |
|           |                     | `purple`          |
|           |                     | `red`             |
|           |                     | `white`           |
|           |                     | `yellow`          |
| `outline` | Outline color       | `none`            |
|           |                     | `blue`            |
|           |                     | `brown`           |
|           |                     | `gray`            |
|           |                     | `green`           |
|           |                     | `orange`          |
|           |                     | `pink`            |
|           |                     | `purple`          |
|           |                     | `red`             |
|           |                     | `white`           |
|           |                     | `yellow`          |
| `font`    | Font name           | `Comic Sans (cs)` |
|           |                     | `Courier (cr)`    |
|           |                     | `Georgia (g)`     |
|           |                     | `Helvetica (h)`   |
|           |                     | `Impact (i)`      |
|           |                     | `Verdana (v)`     |
| `size`    | Font size in pixels | `16`              |
|           |                     | `24`              |
|           |                     | `32`              |
|           |                     | `...`             |
|           |                     | `120`             |
|           |                     | `128`             |

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
