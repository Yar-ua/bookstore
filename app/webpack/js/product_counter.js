const ELEMENTS = {
  el: '.product-counter',
  decrease: '.product-counter__decrease',
  increase: '.product-counter__increase',
  input: '.product-counter__input',
};

class ProductCounter {
  constructor(el) {
    this.el = el;
    this.el.productCounterInstance = this;
    this.init();
  }

  init() {
    this.quantity = parseInt(this.inputElement.value) || 1;
    this.decreaseElement.addEventListener('click', this.onDecreaseClick.bind(this));
    this.increaseElement.addEventListener('click', this.onIncreaseClick.bind(this));
    this.inputElement.addEventListener('change', this.onInputChange.bind(this));
    this.render();
  }

  onInputChange(e) {
    e.stopPropagation();
    const newQuantity = parseInt(e.currentTarget.value) || 1;
    this.updateQuantity(newQuantity);
  }

  isValidQuantity(quantity) {
    return quantity >= 1;
  }

  updateQuantity(newQuantity) {
    if (this.isValidQuantity(newQuantity) && this.quantity !== newQuantity) {
      this.quantity = newQuantity;
      this.dispatchChangeEvent();
    }
    this.render();
  }

  dispatchChangeEvent() {
    this.el.dispatchEvent(new Event('change', {
      bubbles: true,
    }));
  }

  onDecreaseClick(e) {
    e.preventDefault();
    this.updateQuantity(this.quantity - 1);
  }

  onIncreaseClick(e) {
    e.preventDefault();
    this.updateQuantity(this.quantity + 1);
  }

  render() {
    this.inputElement.value = this.quantity;

    if (this.quantity <= 1) {
      this.decreaseElement.classList.add('disabled');
    } else {
      this.decreaseElement.classList.remove('disabled');
    }
  }

  get decreaseElement() {
    return (this.$decreaseElement ||= this.el.querySelector(ELEMENTS.decrease));
  }

  get language() {
    return document.documentElement.lang || 'en';
  }

  get increaseElement() {
    return (this.$increaseElement ||= this.el.querySelector(ELEMENTS.increase));
  }

  get inputElement() {
    return (this.$inputElement ||= this.el.querySelector(ELEMENTS.input));
  }

  static create() {
    document.querySelectorAll(ELEMENTS.el).forEach((el) => {
      if (!el.productCounterInstance) new this(el);
    });
  }

  static start() {
    document.addEventListener('DOMContentLoaded', () => this.create());
  }
}

export default ProductCounter;