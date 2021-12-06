import $ from 'jquery';
import Rails from "@rails/ujs"
import 'bootstrap-sass/assets/javascripts/bootstrap';
import '@client-side-validations/client-side-validations'
import '@client-side-validations/simple-form'

window.$ = $;
window.jQuery = $;
Rails.start()

import '../js/book';
