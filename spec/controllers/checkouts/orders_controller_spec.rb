# RSpec.describe Checkouts::OrdersController, :step_ten do
#   let(:user) { create(:user) }

#   before do
#     stub_cart(:filled, user: user)
#     stub_checkout(user: user)
#     sign_in user
#   end

#   describe '#create' do
#     before do
#       allow(Order).to receive(:create!).and_call_original
#       post :create
#     end

#     it 'creates an order' do
#       expect(Order).to have_received(:create!)
#     end

#     it 'clean cart session' do
#       expect(session[ShoppingCartService::CART_SESSION_KEY]).to be_nil
#     end

#     it 'clean checkout session' do
#       expect(session[Checkouts::MasterController::CHECKOUT_SESSION_ID]).to be_nil
#     end

#     it 'redirects to the next step' do
#       expect(response).to redirect_to(checkouts_complete_path)
#     end
#   end
# end