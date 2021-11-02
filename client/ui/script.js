window.addEventListener("message", function(event) 
{
    if (event.data.type === "show") {
        if (event.data.show) 
            document.getElementsByTagName("body")[0].style.display = "block";
        else 
            document.getElementsByTagName("body")[0].style.display = "none";
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

var colorPicker;
window.addEventListener("load", function() {
    colorPicker = document.querySelector("#colorPicker");
    colorPicker.addEventListener("change", function(event) {
        fetch(`https://${GetParentResourceName()}/action`,
        {
            method: "POST",
            body: JSON.stringify({
                type: "wheelcolor",
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