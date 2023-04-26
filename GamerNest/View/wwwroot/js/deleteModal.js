function deleteModal(ItemId, controllerName) {

    var modal = document.getElementById('confirmationModal_' + ItemId);
    var confirmBtn = document.getElementById('confirmBtn_' + ItemId);
    var cancelBtn = document.getElementById('cancelBtn_' + ItemId);

    modal.style.display = 'flex';

    confirmBtn.addEventListener('click', function () {
        var url = '/' + controllerName + '/Delete/' + ItemId;
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
