import { debounce } from 'lodash-es';

const ELEMENTS = {
  el: '.cart_items',
};
const DEBOUNCE_DELAY = 300;

class Cart {
  constructor(el) {
    this.el = el;
    this.el.cartItemInstance = this;
    this.init();
  }

  init() {
    this.el.addEventListener(
      'change',
      debounce(this.dispatchSubmit.bind(this), DEBOUNCE_DELAY),
    );
  }

  dispatchSubmit() {
    this.el.dispatchEvent(new Event('submit', { bubbles: true, cancelable: true }));
  }

  static create() {
    document.querySelectorAll(ELEMENTS.el).forEach((el) => {
      if (!el.cartItemInstance) new this(el);
    });
  }

  static start() {
    document.addEventListener('DOMContentLoaded', () => {
      document.querySelectorAll(ELEMENTS.el).forEach(() => this.create());
    });
  }
}

export default Cart;