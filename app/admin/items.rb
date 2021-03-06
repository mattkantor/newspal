ActiveAdmin.register Item do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params :title, :image, :description, :source_id

index do
  selectable_column
  column :title
  column :source
  column :sentiment
  column :entities do |d|
    d.entities.collect{|e| e.name}.join(", ")
  end
  actions
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
