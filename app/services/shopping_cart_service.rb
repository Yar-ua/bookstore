class ShoppingCartService
  CART_SESSION_KEY = :cart_id

  attr_reader :session, :current_user

  delegate :update, :update!, :amount, :empty?, :checkout, to: :current_cart

  def initialize(session, current_user)
    @session = session
    @current_user = current_user
  end

  def current_cart
    @current_cart ||= current_user&.cart || Cart.find_by(id: session[CART_SESSION_KEY]) || Cart.new(user: current_user)
  end

  def empty
    session.delete(CART_SESSION_KEY)
    current_cart.destroy if current_cart.persisted?
  end

  def add_book(book, quantity: 1)
    line_item = current_cart.line_items.find { |item| item.book == book }
    if line_item
      line_item.update(quantity: line_item.quantity + quantity)
    else
      current_cart.line_items.build(book: book, price: book.price, quantity: quantity)
    end
    save_current_cart!
  end

  private

  def save_current_cart!
    current_cart.save!
    session[CART_SESSION_KEY] = current_cart.id
  end
end
