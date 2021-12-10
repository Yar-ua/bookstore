const ELEMENTS = {
  el: '.product-gallery',
  image: '.product-gallery__image',
  links: '.product-gallery__thumbs a',
  rest: '.read-more__rest',
};

class ProductGallery {
  constructor(el) {
    this.el = el;
    this.linksElements.forEach((linkElement) => {
      linkElement.addEventListener('click', this.onThumbClick.bind(this));
    });
  }

  onThumbClick(e) {
    e.preventDefault();
    this.imageElement.src = e.currentTarget.href;
  }

  get imageElement() {
    return this.el.querySelector(ELEMENTS.image);
  }

  get linksElements() {
    return this.el.querySelectorAll(ELEMENTS.links);
  }

  static start() {
    document.addEventListener('DOMContentLoaded', () => {
      document.querySelectorAll(ELEMENTS.el).forEach((el) => new this(el));
    });
  }
}

export default ProductGallery;
