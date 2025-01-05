document.addEventListener("DOMContentLoaded", () => {
  const payjp = Payjp('pk_test_e2db4aa074b2e384b505e671'); // 公開鍵を設定
  const elements = payjp.elements();

  const numberElement = elements.create('cardNumber');
  const expiryElement = elements.create('cardExpiry');
  const cvcElement = elements.create('cardCvc');

  numberElement.mount('#number-form');
  expiryElement.mount('#expiry-form');
  cvcElement.mount('#cvc-form');

  const form = document.getElementById('charge-form');
  form.addEventListener("submit", (e) => {
    e.preventDefault(); // フォームのデフォルト送信を止める

    payjp.createToken(numberElement).then((response) => {
      if (response.error) {
        console.error(response.error.message); // トークン生成エラー
      } else {
        const token = response.id; // トークン取得
        const tokenObj = `<input value="${token}" name="token" type="hidden">`;
        form.insertAdjacentHTML("beforeend", tokenObj); // フォームにトークン追加
        form.submit(); // フォーム送信
      }
    });
  });
});