ActiveAdmin.register Author do  
  index do
    selectable_column
    column :first_name
    column :last_name
    column :biography
    actions
  end
  
  form do |f|
    f.inputs :first_name, :last_name, :biography
    actions
  end

  permit_params :first_name, :last_name, :biography
end
