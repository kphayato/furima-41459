const price = () => {
  // 販売価格入力欄を取得
  const priceInput = document.getElementById("item-price");
  // 販売手数料を表示する要素を取得
  const addTaxDom = document.getElementById("add-tax-price");
  // 販売利益を表示する要素を取得
  const profitDom = document.getElementById("profit");

  if (priceInput) {
    priceInput.addEventListener("input", () => {
      // 入力値を取得
      const inputValue = priceInput.value;

      // 数値のチェックと販売手数料・利益の計算
      const inputPrice = parseFloat(inputValue);
      if (!isNaN(inputPrice) && inputPrice >= 300 && inputPrice <= 9999999) {
        const tax = Math.floor(inputPrice * 0.1); // 販売手数料を計算
        const profit = inputPrice - tax; // 販売利益を計算

        // 販売手数料と利益をHTMLに反映
        if (addTaxDom) {
          addTaxDom.innerHTML = `${tax}`; // 販売手数料に円を追加
        }
        if (profitDom) {
          profitDom.innerHTML = `${profit}`; // 販売利益に円を追加
        }
      } else {
        // 無効な入力値の場合は初期化
        if (addTaxDom) {
          addTaxDom.innerHTML = "0"; // 無効な場合0円を表示
        }
        if (profitDom) {
          profitDom.innerHTML = "0"; // 無効な場合0円を表示
        }
      }
    });
  }
};

// Turboイベントに対応
window.addEventListener("turbo:load", price);
window.addEventListener("turbo:render", price);