const ELEMENTS = {
  el: '.star-rating',
};

const CLASS_NAMES = {
  active: 'fa fa-star rate-star',
  inactive: 'fa fa-star rate-empty',
};

class StarRating {
  constructor(el) {
    this.el = el;
    this.el.hidden = 'true';
    this.value = parseInt(this.el.value);
    this.from = parseInt(this.el.min);
    this.to = parseInt(this.el.max);
    this.stars = [];
    this.init();
  }

  init() {
    const wrapper = this.createWrapper();
    const starsWrapper = this.createStars();
    wrapper.appendChild(starsWrapper);
    this.render();
  }

  createWrapper() {
    const wrapper = document.createElement('div');
    this.el.parentNode.insertBefore(wrapper, this.el);
    wrapper.appendChild(this.el);
    return wrapper;
  }

  createStars() {
    const starsWrapper = document.createElement('div');
    for (let i = this.from; i <= this.to; i++) {
      const starElement = document.createElement('i');
      starElement.addEventListener('click', () => {
        this.value = i;
        this.el.value = i;
        this.render();
      });
      starElement.addEventListener('mouseenter', () => {
        this.value = i;
        this.render();
      }, false);
      this.stars.push(starElement);
      starsWrapper.appendChild(starElement);
    }
    starsWrapper.addEventListener('mouseleave', () => {
      this.value = parseInt(this.el.value);
      this.render();
    }, false);
    return starsWrapper;
  }

  isActive(starElement) {
    const index = this.stars.indexOf(starElement);
    return this.value >= index + this.from;
  }

  render() {
    for (let i = 0; i < this.stars.length; i++) {
      this.stars[i].className = this.isActive(this.stars[i])
        ? CLASS_NAMES.active : CLASS_NAMES.inactive;
    }
  }

  static start() {
    document.addEventListener('DOMContentLoaded', () => {
      document.querySelectorAll(ELEMENTS.el).forEach((el) => new this(el));
    });
  }
}

export default StarRating;