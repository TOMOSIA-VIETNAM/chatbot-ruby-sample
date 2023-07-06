import bot from "./assets/bot.svg";
import user from "./assets/user.svg";
import MarkdownIt from 'markdown-it';

const md = new MarkdownIt();
const chatContainer = document.querySelector("#chat_container");
const form          = document.querySelector("form");
const btnSubmit     = form.querySelector("button");
const textarea      = form.querySelector("textarea");

let endpoint;
if (window.location.hostname === 'localhost' || window.location.hostname === '127.0.0.1') {
  endpoint = 'http://127.0.0.1:3000/chat';
} else {
  endpoint = 'http://openai-server.qlear.net/chat';
}

let loadInterval;

function loader(element) {
  element.textContent = "";

  loadInterval = setInterval(() => {
    // Update the text content of the loading indicator
    element.textContent += "◦";

    // If the loading indicator has reached three dots, reset it
    if (element.textContent === "◦◦◦◦") {
      element.textContent = "";
    }
  }, 300);
}

// function typeText(element, text) {
//   let index = 0;

//   let interval = setInterval(() => {
//     if (index < text.length) {
//       element.innerHTML += text.charAt(index);
//       index++;
//     } else {
//       clearInterval(interval);
//     }
//   }, 20);
// }


function typeText(element, text) {
  var aText = Array.isArray(text) ? text : [text];
  var iSpeed = 35; // time delay of print out
  var iIndex = 0; // start printing array at this position
  var iArrLength = aText[0].length; // the length of the text array
  var iScrollAt = 20; // start scrolling up at this many lines
  var iTextPos = 0; // initialize text position
  var sContents = ''; // initialize contents variable
  var iRow; // initialize current row

  function type() {
    sContents = '';
    iRow = Math.max(0, iIndex - iScrollAt);

    while (iRow < iIndex) {
      sContents += aText[iRow++] + '<br />';
    }
    // element.innerHTML = sContents + aText[iIndex].substring(0, iTextPos) + "_";
    element.innerHTML = sContents + aText[iIndex].substring(0, iTextPos);

    if (iTextPos++ === iArrLength) {
      iTextPos = 0;
      iIndex++;

      if (iIndex !== aText.length) {
        iArrLength = aText[iIndex].length;
        setTimeout(type, 500);
      }
    } else {
      setTimeout(type, iSpeed);
    }
  }

  type();
}

function disabledSubmit() {
  btnSubmit.classList.add('btn-disabled')
}

function enabledSubmit() {
  btnSubmit.classList.remove('btn-disabled')
}

// generate unique ID for each message div of bot
// necessary for typing text effect for that specific reply
// without unique ID, typing text will work on every element
function generateUniqueId() {
  const timestamp = Date.now();
  const randomNumber = Math.random();
  const hexadecimalString = randomNumber.toString(16);

  return `id-${timestamp}-${hexadecimalString}`;
}

function chatStripe(isAi, value, uniqueId) {
  return `
        <div class="wrapper ${isAi && "ai"}">
            <div class="chat">
                <div class="profile">
                    <img
                      src=${isAi ? bot : user}
                      alt="${isAi ? "bot" : "user"}"
                    />
                </div>
                <div class="message js-message markdown-body" id=${uniqueId}>${value}</div>
                <button class="btn btn-copy d-none js-copy-message">
                  <svg stroke="currentColor" fill="none" stroke-width="2" viewBox="0 0 24 24" stroke-linecap="round" stroke-linejoin="round" class="h-4 w-4" height="1em" width="1em" xmlns="http://www.w3.org/2000/svg"><path d="M16 4h2a2 2 0 0 1 2 2v14a2 2 0 0 1-2 2H6a2 2 0 0 1-2-2V6a2 2 0 0 1 2-2h2"></path><rect x="8" y="2" width="8" height="4" rx="1" ry="1"></rect></svg>
                </button>
            </div>
        </div>
    `;
}

function handleCopyMessageAi() {
  var copyButtons = document.querySelectorAll('.js-copy-message');
  copyButtons.forEach(function(button) {
    button.addEventListener('click', function() {
      // Tìm phạm vi gần nhất (.wrapper) chứa nút copyButton được click
      var wrapper = button.closest('.wrapper');

      // Tìm đối tượng chứa nội dung cần copy trong phạm vi wrapper
      var message = wrapper.querySelector('.chat .js-message');

      // Tạo một thẻ textarea tạm thời để chứa nội dung cần copy
      var tempTextarea = document.createElement('textarea');
      tempTextarea.value = message.textContent;

      // Thêm thẻ textarea vào body và chọn toàn bộ nội dung
      document.body.appendChild(tempTextarea);
      tempTextarea.select();

      // Copy nội dung vào clipboard
      document.execCommand('copy');

      // Xóa thẻ textarea tạm thời
      document.body.removeChild(tempTextarea);

      // Thêm lớp CSS tạm thời để thay đổi icon
      button.classList.add('copied');

      // Đặt thời gian chờ 2 giây
      setTimeout(function() {
        // Xóa lớp CSS tạm thời để trở về icon ban đầu
        button.classList.remove('copied');
      }, 1000);
    });
  });
}

const handleSubmit = async (e) => {
  e.preventDefault();

  const data = new FormData(form);
  const prompt_text = data.get('prompt')

  if(prompt_text.trim().length === 0) return false

  // user's chatstripe
  chatContainer.innerHTML += chatStripe(false, prompt_text);

  // to clear the textarea input
  form.reset();

  // bot's chatstripe
  const uniqueId = generateUniqueId();
  chatContainer.innerHTML += chatStripe(true, " ", uniqueId);

  // to focus scroll to the bottom
  chatContainer.scrollTop = chatContainer.scrollHeight;

  // specific message div
  const messageDiv = document.getElementById(uniqueId);

  // messageDiv.innerHTML = "..."
  loader(messageDiv);

  const formData = new FormData();
  formData.append('prompt', data.get('prompt'));

  const response = await fetch(endpoint, {
    method: 'POST',
    body: formData,
  });

  clearInterval(loadInterval);
  messageDiv.innerHTML = " ";

  if (response.ok) {
    const data = await response.json();
    const parsedData = data.bot.trim(); // trims any trailing spaces/'\n'

    disabledSubmit();
    typeText(messageDiv, md.render(parsedData));

    handleCopyMessageAi();
    // Show button copy messagr
    messageDiv.closest('.chat').querySelector('.js-copy-message').classList.remove('d-none')
  } else {
    const err = await response.text();

    messageDiv.innerHTML = "Something went wrong";
    // alert(err);
    typeText(messageDiv, err)
  }
};

// Handle submit form or press Enter
form.addEventListener("submit", handleSubmit);
form.addEventListener("keydown", (e) => {
  if (e.key === 'Enter' && !e.shiftKey) {
    e.preventDefault();
    handleSubmit(e);
  }
});

// Handle button submit
form.addEventListener("keyup", (e) => {
  if (textarea.value.length) {
    enabledSubmit()
  } else {
    disabledSubmit()
  }
});

// Handle keypress textarea
textarea.addEventListener('input', function() {
  // Đặt chiều cao của textarea thành scrollHeight (chiều cao toàn bộ nội dung)
  this.style.height = 'auto';
  this.style.height = this.scrollHeight + 'px';
});

textarea.addEventListener('keydown', function(event) {
  if (event.key === 'Enter' && event.shiftKey) {
    // Ngăn sự kiện mặc định của phím Enter khi nhấn Shift
    event.preventDefault();

    // Thêm xuống hàng bằng cách thêm '\n' vào vị trí con trỏ
    const start = this.selectionStart;
    const end = this.selectionEnd;
    this.value = this.value.substring(0, start) + '\n' + this.value.substring(end);

    // Tự động co giãn chiều cao theo nội dung mới
    this.style.height = 'auto';
    this.style.height = this.scrollHeight + 'px';
  } else if (event.key === 'Enter') {
    this.style.height = 'auto';
  }
});


handleCopyMessageAi()
