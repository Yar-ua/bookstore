class CreditCardDecorator < Draper::Decorator
  delegate_all

  def last_four_numbers
    "** ** ** #{number.last(4)}"
  end
end
