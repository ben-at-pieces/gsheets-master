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


