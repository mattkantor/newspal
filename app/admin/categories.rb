ActiveAdmin.register Category do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params :name, :cat_type, :status

batch_action  :merge_into, form: { merge_to: :text } do |ids, inputs|
    if inputs[:merge_to]!=""
      Category.merge(inputs[:merge_to], ids)
    end
  
  redirect_to collection_path, alert: "The categories have been merged."
end

batch_action  :flag do |ids|
  batch_action_collection.find(ids).each do |cat|
    cat.update_attributes({status:1})
  end
  redirect_to collection_path, alert: "The categories have been flagged."
end


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
     f.input :status, label: "Status", as: :select, :collection =>Category.statuses
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
