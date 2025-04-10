const date = new Date();

const renderCalendar = () => {
    date.setDate(1); // Đặt ngày đầu tháng là ngày 1

    const monthDays = document.querySelector(".ngay");

    const lastDay = new Date(
        date.getFullYear(),
        date.getMonth() + 1,
        0
    ).getDate(); // Số ngày của tháng hiện tại

    const prevLastDay = new Date(
        date.getFullYear(),
        date.getMonth(),
        0
    ).getDate(); // Số ngày của tháng trước

    const firstDayIndex = date.getDay(); // Thứ của ngày 1 trong tháng (0: Chủ nhật, 1: Thứ 2, ...)
    const lastDayIndex = new Date(
        date.getFullYear(),
        date.getMonth() + 1,
        0
    ).getDay(); // Thứ của ngày cuối cùng trong tháng

    const nextDays = 7 - lastDayIndex - 1; // Số ngày cần phải hiển thị từ tháng sau

    const months = [
        "Tháng 1", "Tháng 2", "Tháng 3", "Tháng 4", "Tháng 5", "Tháng 6",
        "Tháng 7", "Tháng 8", "Tháng 9", "Tháng 10", "Tháng 11", "Tháng 12"
    ];

    const datenow = new Date();
    document.querySelector('.nd h1').innerHTML = months[date.getMonth()];
    document.querySelector('.nd p').innerHTML = "Bây giờ " + datenow.getDate() + "/" + (datenow.getMonth() + 1) + "/" + date.getFullYear();

    let ngay = "";
    // Hiển thị các ngày của tháng trước
    for (let x = firstDayIndex - 1; x >= 0; x--) {
        ngay += `<div class="previous-day">${prevLastDay - x}</div>`;
    }

    // Hiển thị các ngày trong tháng hiện tại
    for (let i = 1; i <= lastDay; i++) {
        if (i === new Date().getDate() && date.getMonth() === new Date().getMonth()) {
            ngay += `<div class="today1">${i}</div>`
        } else if (i === 1 && date.getMonth() === 11) {
            ngay += `<div class="today">${i}</div>`
        } else {
            ngay += `<div class="">${i}</div>`
        }
    }

    // Hiển thị các ngày của tháng sau (nếu cần)
    for (let j = 1; j <= nextDays; j++) {
        ngay += `<div class="next-ngay">${j}</div>`;
    }

    monthDays.innerHTML = ngay;
};

document.querySelector('.prev').addEventListener('click', () => {
    date.setMonth(date.getMonth() - 1);
    renderCalendar();
});

document.querySelector('.next').addEventListener('click', () => {
    date.setMonth(date.getMonth() + 1);
    renderCalendar();
});

renderCalendar();
