document.addEventListener('DOMContentLoaded', () => {
  const priceInput = document.getElementById('item-price');
  const taxDisplay = document.getElementById('add-tax-price');
  const profitDisplay = document.getElementById('profit');

  if (priceInput) {
    priceInput.addEventListener('input', () => {
      const price = parseInt(priceInput.value, 10);
      if (!isNaN(price)) {
        const tax = Math.floor(price * 0.1);
        const profit = price - tax;
        taxDisplay.textContent = tax;
        profitDisplay.textContent = profit;
      } else {
        taxDisplay.textContent = '';
        profitDisplay.textContent = '';
      }
    });
  }
});