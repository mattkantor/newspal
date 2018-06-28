ActiveAdmin.register Category do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params :name, :alias_tags, :cat_type, :status

index do
  selectable_column
  column :name
  column :status
  column :cat_type
  column :alias_tags do |d|
    d.alias_tags.join(", ")
  end

  actions
end

form do |f|
   f.inputs 'Details' do
     f.input :name
     f.input :cat_type, label: "Category Type", as: :select, :collection =>Category.cat_types


      
  end
end
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

end
