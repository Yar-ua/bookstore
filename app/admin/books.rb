ActiveAdmin.register Book do
  decorate_with BookDecorator
  includes :category, :authors # , :material

  index do
    selectable_column
    column :admin_general_image
    column :category
    column :title
    column :book_authors
    column :short_description
    column :quantity
    column :price_to_currency
    actions
  end

  show do
    attributes_table do
      row :admin_images
      row :category
      row :title
      row :book_authors
      row :description
      row :price_to_currency
      row :year
      row :quantity
      row :material
      row :dimensions
      row :created_at
      row :updated_at
    end
  end

  form decorate: true do |f|
    f.inputs do
      f.input :images, as: :file, input_html: { multiple: true, accept: '.jpg, .jpeg, .png' }, hint: book.admin_images
      f.input :category, collection: Category.order(:name).all
      f.input :title
      f.input :authors, collection: Author.order(:first_name, :last_name).all.decorate
      f.input :description
      f.input :quantity
      f.input :price
      f.input :year
      f.input :materials, as: :check_boxes, collection: Book.materials
    end

    f.inputs I18n.t('active_admin.books.dimensions') do
      f.input :height
      f.input :width
      f.input :depth
    end
    actions
  end

  permit_params :category_id, :title, :description, :price, :year, :quantity,
                :height, :width, :depth, :material, author_ids: [], images: []
end
