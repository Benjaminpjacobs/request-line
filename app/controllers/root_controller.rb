# class RootController < ApplicationController
#   before_action :root_redirect
  
#   def root_redirect
#     if current_user
#       redirect_to dashboard_index_path
#     else
#       redirect_to login_path
#     end
#   end
# end