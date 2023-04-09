document.addEventListener('DOMContentLoaded', function () {

    var deleteAction = document.getElementById('deleteAction');

    var modal = document.getElementById('confirmationModal');
    var confirmBtn = document.getElementById('confirmBtn');
    var cancelBtn = document.getElementById('cancelBtn');

    deleteAction.addEventListener('click', function () {

        modal.style.display = 'flex';

        confirmBtn.addEventListener('click', function () {
            modal.style.display = 'none';
        });

        cancelBtn.addEventListener('click', function () {
            modal.style.display = 'none';
        });
    });

    modal.addEventListener('click', function (event) {
        if (event.target === modal) {
            modal.style.display = 'none';
        }
    });
});
