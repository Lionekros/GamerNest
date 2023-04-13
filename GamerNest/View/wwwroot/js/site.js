// Please see documentation at https://docs.microsoft.com/aspnet/core/client-side/bundling-and-minification
// for details on configuring this project to bundle and minify static web assets.

// Write your JavaScript code.

function selectColor(selectElement)
{
    var selectedOption = selectElement.options[selectElement.selectedIndex];
    var selectedColor = selectedOption.className;

    // Update the class of the <select> element
    selectElement.className = selectedColor;
}

