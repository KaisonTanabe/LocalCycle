module ApplicationHelper

  def my_agreements_path(time="")    
    current_user.producer? ? agreements_path(producer_id: current_user.id, status: time) : agreements_path(buyer_id: current_user.id, status: time)
  end

  def sortable(column, title = nil, addition_params=nil)
    title ||= column.titleize
    caret = ""
    if column == sort_column
      caret = sort_direction == "ASC" ? " <span class='caret'></span>" : " <span class='dropup'><span class='caret'></span></span>"
    end
    css_class = (column == sort_column) ? "current" : nil
    direction = (column == sort_column && sort_direction == "ASC") ? "DESC" : "ASC"
    link_to raw(title + caret), (addition_params).merge(sort: column, direction: direction, page: nil), {:class => css_class}
  end


  # Form Helpers (coupled with JS) to add/remove has_many associated model forms
  def remove_child_link(name, f)
    link_to(name, "javascript:void(0)", :class => "remove_child")
  end

  def add_child_link(name, association)
    link_to(raw('<span class="icon icon-plus"></span> ' + name), "javascript:void(0)", :class => "add_child btn", :"data-association" => association)
  end

  def new_child_fields_template(form_builder, association, options = {})
    options[:object] ||= form_builder.object.class.reflect_on_association(association).klass.new
    options[:partial] ||= association.to_s.singularize
    options[:form_builder_local] ||= :f

    content_tag(:div, :id => "#{association}_fields_template", :style => "display: none") do
      form_builder.fields_for(association, options[:object], :child_index => "new_#{association}") do |f|
        render(:partial => options[:partial], :locals => {options[:form_builder_local] => f})
      end
    end
  end

end
