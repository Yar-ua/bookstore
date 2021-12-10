import $ from 'jquery';
import Rails from "@rails/ujs"
import 'bootstrap-sass/assets/javascripts/bootstrap';
import '@client-side-validations/client-side-validations'
import '@client-side-validations/simple-form'
import '../js/book';
import '../js/star_rating';
import StarRating from '../js/star_rating';
import ProductCounter from '../js/product_counter'
import ProductGallery from '../js/product_gallery'
import Cart from '../js/cart'

window.$ = $;
window.jQuery = $;
Rails.start()
ProductCounter.start()
StarRating.start()
ProductGallery.start();
Cart.start()

window.ProductCounter = ProductCounter;
window.Cart = Cart;