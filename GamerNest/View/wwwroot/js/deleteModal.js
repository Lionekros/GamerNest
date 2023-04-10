function deleteModal(ItemId)
{
    var deleteAction = document.getElementById('deleteAction_' + ItemId);

    var modal = document.getElementById('confirmationModal_' + ItemId);
    var confirmBtn = document.getElementById('confirmBtn_' + ItemId);
    var cancelBtn = document.getElementById('cancelBtn_' + ItemId);

    modal.style.display = 'flex';

    confirmBtn.addEventListener('click', function () {
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