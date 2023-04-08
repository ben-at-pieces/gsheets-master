chrome.contextMenus.create({
    id: "copy-image",
    title: "Copy image (Extension)",
    contexts: ["image"]
});

chrome.contextMenus.onClicked.addListener(function(info, tab) {
    if (info.menuItemId === "copy-image") {
        if (info.mediaType === "image") {
            const imageUrl = info.srcUrl;
            const img = new Image();
            img.crossOrigin = "anonymous";
            img.onload = function() {
                const canvas = document.createElement("canvas");
                canvas.width = img.width;
                canvas.height = img.height;
                const ctx = canvas.getContext("2d");
                ctx.drawImage(img, 0, 0);
                canvas.toBlob(function(blob) {
                    const item = new ClipboardItem({ "image/png": blob });
                    navigator.clipboard
                        .write([item])
                        .then(function() {
                            console.log("Image copied to clipboard");
                        })
                        .catch(function(err) {
                            console.error("Failed to copy image to clipboard: " + err);
                        });
                }, "image/png");
            };
            img.src = imageUrl;
        }
    }
});
