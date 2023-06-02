// Please see documentation at https://docs.microsoft.com/aspnet/core/client-side/bundling-and-minification
// for details on configuring this project to bundle and minify static web assets.

// Write your JavaScript code.

function selectColor(selectElement)
{
    var selectedOption = selectElement.options[selectElement.selectedIndex];
    var selectedColor = selectedOption.className;

    selectElement.className = selectedColor;
}

function toggleDescription(itemId) {
    var descriptionElement = document.getElementById('item_' + itemId);
    var readMoreElement = descriptionElement.nextElementSibling;

    if (descriptionElement.classList.contains('collapsed')) {
        descriptionElement.classList.remove('collapsed');
        descriptionElement.style.maxHeight = 'none';
        readMoreElement.innerText = 'Read Less';
    } else {
        descriptionElement.classList.add('collapsed');
        descriptionElement.style.maxHeight = '100px';
        readMoreElement.innerText = 'Read More';
    }
}

function deleteUserModal(controllerName) {
    var modal = document.getElementById('confirmationModal');
    var confirmBtn = document.getElementById('confirmBtn');
    var cancelBtn = document.getElementById('cancelBtn');

    modal.style.display = 'flex';

    confirmBtn.addEventListener('click', function () {
        var url = '/' + controllerName + '/DeleteUser';
        fetch(url, { method: 'POST' })
            .then(function (response) {
                if (response.ok) {
                    location.reload();
                } else {
                    console.error('Error deleting', response.statusText);
                }
            })
            .catch(function (error) {
                console.error('Error deleting', error);
            });

        modal.style.display = 'none';
    });

    cancelBtn.addEventListener('click', function () {
        modal.style.display = 'none';
    });

    modal.addEventListener('click', function (event) {
        if (event.target === modal) {
            modal.style.display = 'none';
        }
    });
}