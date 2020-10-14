## First download [Node.js](https://nodejs.org/en/download/)

## Table of Contents
- [Plugin](#)
  - [imagemin-webp](#imagemin-webp)
- [Usage](#usage)

# Imagemin-webp

* Install Plugin imagemin
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
You can experiment with even more settings at the [imagemin-webp plugin page](https://www.npmjs.com/package/imagemin-webp)

* Run the script :
```
node webp.js
```

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


Source [Click](https://css-tricks.com/using-webp-images/)
