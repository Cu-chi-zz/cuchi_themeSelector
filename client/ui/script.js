var wheelColorPicker;
var pauseColorPicker;

window.addEventListener("message", function(event) 
{
    if (event.data.type === "show") {
        if (event.data.show) 
            document.getElementsByTagName("body")[0].style.display = "block";
        else 
            document.getElementsByTagName("body")[0].style.display = "none";
    }
    else if (event.data.type === "fetch") {
        wheelColorPicker.value = FormattedRgbToHex(event.data.wheelr, event.data.wheelg, event.data.wheelb);
        pauseColorPicker.value = FormattedRgbToHex(event.data.pauser, event.data.pauseg, event.data.pauseb);
    }
});

window.addEventListener("keyup", function(event) 
{
    if (event.key === "Escape") {
        fetch(`https://${GetParentResourceName()}/action`,
        {
            method: "POST",
            body: JSON.stringify({
                type: "close",
            })
        }).then(() => {
            document.getElementsByTagName("body")[0].style.display = "none";
        })
    }
});

window.addEventListener("load", function() {
    wheelColorPicker = document.querySelector("#colorPickerWheel");
    wheelColorPicker.addEventListener("change", function(event) {
        fetch(`https://${GetParentResourceName()}/action`,
        {
            method: "POST",
            body: JSON.stringify({
                type: "wheelcolor",
                color: HexToRgb(event.target.value)
            })
        })
    }, false);

    pauseColorPicker = document.querySelector("#colorPickerPause");
    pauseColorPicker.addEventListener("change", function(event) {
        fetch(`https://${GetParentResourceName()}/action`,
        {
            method: "POST",
            body: JSON.stringify({
                type: "pausecolor",
                color: HexToRgb(event.target.value)
            })
        })
    }, false);
}, false);

function HexToRgb(hex) {
    return [
        '0x' + hex[1] + hex[2] | 0, 
        '0x' + hex[3] + hex[4] | 0, 
        '0x' + hex[5] + hex[6] | 0
    ];
}

function RgbToHex(rgb) { 
    var hex = Number(rgb).toString(16);
    if (hex.length < 2)
        hex = "0" + hex;
    return hex;
};

function FormattedRgbToHex(r, g, b) { 
    var red = RgbToHex(r);
    var green = RgbToHex(g);
    var blue = RgbToHex(b);
    return "#" + red + green + blue
}