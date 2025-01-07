const pay = () => {
  const publicKey = gon.public_key;
  if (!publicKey) {
    console.error("PAY.JP公開鍵が設定されていません。");
    return;
  }

  const payjp = Payjp(publicKey); // PAY.JPテスト公開鍵
  const elements = payjp.elements();
  const numberElement = elements.create('cardNumber');
  const expiryElement = elements.create('cardExpiry');
  const cvcElement = elements.create('cardCvc');

  if (document.querySelector('#number-form')) numberElement.mount('#number-form');
  if (document.querySelector('#expiry-form')) expiryElement.mount('#expiry-form');
  if (document.querySelector('#cvc-form')) cvcElement.mount('#cvc-form');

  const form = document.getElementById('charge-form');
  if (!form) return;

  const handleFormSubmit = (e) => {
    e.preventDefault();

    payjp.createToken(numberElement).then((response) => {
      if (response.error) {
        console.error(response.error.message);
      } else {
        const token = response.id;
        const tokenObj = `<input value="${token}" name="token" type="hidden">`;
        form.insertAdjacentHTML("beforeend", tokenObj);
        form.submit();
      }
    });
  };

  form.removeEventListener("submit", handleFormSubmit); // 重複を防ぐ
  form.addEventListener("submit", handleFormSubmit);
};

document.addEventListener("DOMContentLoaded", pay);
window.addEventListener("turbo:load", pay);
window.addEventListener("turbo:render", pay);