## First download [Node.js](https://nodejs.org/en/download/)

## Table of Contents
- [Plugin](#)
  - [Imagemin-webp](#imagemin-webp)
  - [Compress-images](#compress-images)
- [how to use it on the website](#usage)

# Imagemin-webp

* Install Plugin Imagemin
```
npm install imagemin imagemin-webp
```

* Open text editor and create a new file named webp.js

```
var imagemin = require("imagemin"),    // The imagemin module.
  webp = require("imagemin-webp"),   // imagemin's WebP plugin.
  outputFolder = "./img",            // Output folder
  PNGImages = "./img/*.png",         // PNG images
  JPEGImages = "./img/*.jpg";        // JPEG images

imagemin([PNGImages], outputFolder, {
  plugins: [webp({
      lossless: true // Losslessly encode images
  })]
});

imagemin([JPEGImages], outputFolder, {
  plugins: [webp({
    quality: 65 // Quality setting from 0 to 100
  })]
});
```
more settings at the [imagemin-webp plugin page](https://www.npmjs.com/package/imagemin-webp)

* Run the script :
```
node webp.js
```
Source [css-tricks](https://css-tricks.com/using-webp-images/)

## Compress-images

* Install Plugin Compress-images
```
npm install compress-images --save-dev
```

```
const compress_images = require("compress-images");
 
function MyFun() {
  compress_images(
    "src/img/**/*.{jpg,JPG,jpeg,JPEG,png,svg,gif}",
    "build/img/",
    { compress_force: false, statistic: true, autoupdate: true },
    false,
    { jpg: { engine: "webp", command: ["-quality", "85"] } },
    { png: { engine: "webp", command: ["--quality=85", "-o"] } },
    { svg: { engine: "svgo", command: "--multipass" } },
    {
      gif: { engine: "gifsicle", command: ["--colors", "64", "--use-col=web"] },
    },
    function (err, completed) {
      if (completed === true) {
        // Doing something.
      }
    }
  );
}
```
More settings at the [Compress-images](https://www.npmjs.com/package/compress-images)



------------------------------------------------------------------------------------------------------

## Usage
* Using WebP in HTML
```
<!-- Nothing possibly can go wrong with this, right? -->
<img src="img/myAwesomeWebPImage.webp" alt="WebP rules." />
```

* Using WebP Images in CSS

```
.no-webp .elementWithBackgroundImage {
  background-image: url("image.jpg");
}

.webp .elementWithBackgroundImage{
  background-image: url("image.webp");
}
```
