 /// This code listens for a command called "inject-script" and if it is received, it enables the extension, sets the popup to "index.html", and logs a message saying the extension has been activated.
chrome.commands.onCommand.addListener(function(command) {
    if (command === "inject-script") {
        chrome.action.enable().then(() => {
            chrome.windows.getCurrent((currentWindow) => {
                chrome.windows.update(currentWindow.id, { focused: true });
            });
            chrome.browserAction.setPopup({ popup: "index.html" });
        }).catch((error) => {
            console.error(`Error enabling extension: ${error}`);
        });
        console.log("The extension has been activated!");
    }
});


