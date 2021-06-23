class ApplicationRecord < ActiveRecord::Base
  def after_sign_in_path_for(resource)
    root_path
  end

  def after_sign_up_path_for(resource)
    root_path 
   end
  
  self.abstract_class = true
end
