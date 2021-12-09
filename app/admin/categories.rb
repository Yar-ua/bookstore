ActiveAdmin.register Category, as: 'CategoryBook' do
  # Dunno why, but nesessary to change name Catgory to CategoryBook to avoid ActiveAdmin pagination error
  permit_params :name

  index do
    selectable_column
    column :name do |category|
      link_to category.name, resource_path(category)
    end
    actions
  end
end
