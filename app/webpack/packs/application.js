import $ from 'jquery';
import Rails from "@rails/ujs"
import 'bootstrap-sass/assets/javascripts/bootstrap';
import '@client-side-validations/client-side-validations'
import '@client-side-validations/simple-form'
import '../js/book';
import '../js/star_rating';
import StarRating from '../js/star_rating';
import ProductGallery from '../js/product_gallery'

window.$ = $;
window.jQuery = $;
Rails.start()
StarRating.start()
ProductGallery.start();
