ActiveAdmin.register Book do
  decorate_with BookDecorator

  index do
    selectable_column
    column :category
    column :title
    column :book_authors
    column :short_description
    column :price_to_currency
    actions
  end
  
  show do
    attributes_table do
      row :category
      row :title
      row :book_authors
      row :description
      row :price_to_currency
      row :year
      row :material
      row :dimensions
      row :created_at
      row :updated_at
    end
  end
  
  form decorate: true do |f|
    f.inputs do
      f.input :category, collection: Category.order(:name).all
      f.input :title
      f.input :authors, collection: Author.order(:first_name, :last_name).all.decorate
      f.input :description
      f.input :price
      f.input :year #, as: :select, collection: [1980..1999] #Book::MAX_PUBLICATION_YEAR.downto(Book::MIN_PUBLICATION_YEAR)
      f.input :materials, as: :check_boxes, collection: Book.materials # :material.order(:name).all
    end

    f.inputs I18n.t('active_admin.books.dimensions') do
      f.input :height
      f.input :width
      f.input :depth
    end
    actions
  end
  
  permit_params :category_id, :title, :description, :price, :year, :quantity,
                :height, :width, :depth, :material, author_ids: []
end
