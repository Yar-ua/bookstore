require 'pagy/extras/navs'
require 'pagy/extras/bootstrap'

Pagy::VARS[:items] = 12
Pagy::VARS[:link_extra] = 'data-remote="true"'
Pagy::I18n.load(locale: 'en')
