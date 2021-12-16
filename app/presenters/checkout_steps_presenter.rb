class CheckoutStepsPresenter
  attr_reader :current_step, :steps

  def initialize(steps, current_step)
    @steps = steps
    @current_step = current_step
  end

  def call
    steps.each_with_index.map do |step, index|
      { name: I18n.t("checkouts.steps.#{step}"), done: done?(step),
        active: active?(step), index: index.next, first: index.zero? }
    end
  end

  private

  def done?(step)
    step_index(step) < step_index(current_step)
  end

  def active?(step)
    step == current_step
  end

  def step_index(step)
    steps.index(step)
  end
end
