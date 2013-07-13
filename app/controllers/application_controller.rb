class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to new_user_session_path, alert: exception.message
  end

  def after_sign_in_path_for(resource)
    resource.complete ? goods_path : edit_user_path(resource)
  end

  def import_records(file, model)
    infile = file.read
    n, errs = 0, []
    
    CSV.parse(infile) do |row|
      n += 1
      # SKIP: header i.e. first row OR blank row
      next if n == 1 or row.join.blank?
      # build_from_csv method will map attributes & 
      # build new record
      record = model.capitalize.constantize.build_from_csv(row) 
      # Save upon valid 
      # otherwise collect error records to export 
      if record.valid? 
        record.save
      else
        row << record.errors.full_messages.join("\n")
        errs << row 
      end      
    end
    return errs
  end
end
