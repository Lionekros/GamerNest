const sidebar = document.querySelector(".sidebar");
const closeBtn = document.querySelector("#btn");

const menuState = localStorage.getItem('menuState');
sidebar.classList.toggle('open', menuState === 'open');

closeBtn.addEventListener("click", () => {
    sidebar.classList.toggle("open");
    localStorage.setItem('menuState', sidebar.classList.contains('open') ? 'open' : 'closed');
});