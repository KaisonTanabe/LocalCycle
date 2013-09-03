module UsersHelper
  def parsed_params
    new_params = {}
    new_params[:name]=params[:name] unless params[:name].blank?
    new_params[:per_page]=params[:per_page] unless params[:per_page].blank?
    new_params
  end

  def full_params
    new_params = {}
    new_params[:name]=params[:name] unless params[:name].blank?

    new_params[:sort]=params[:sort] unless params[:sort].blank?
    new_params[:direction]=params[:direction] unless params[:direction].blank?

    new_params[:per_page]=params[:per_page] unless params[:per_page].blank?
    new_params
  end
  
  def link_to_add_user_network(name, f, association)
      new_object = f.object.send(association).klass.new
      id = new_object.object_id
      fields = f.fields_for(association, new_object, child_index: id) do |builder|
        render(association.to_s.singularize + "_fields", f: builder)
      end
      link_to(name, '#', class: "add_fields ", data: {id: id, fields: fields.gsub("\n", "")})
    end
  
  
end
