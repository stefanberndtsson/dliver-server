class V1::ConfigController < V1::ApiController

  resource_description do
    short 'Config manager - Data specified in application configuration'
  end

  def index
  end

  # Returns a list of assignable roles on format {roles: ["ROLE1", "ROLE2", ...]}
  api :GET, '/config/roles', 'Returns a list of assignable roles for users'
  def role_list
    role_list = []
    # Select role name from config list of roles
    roles = APP_CONFIG["user_roles"].select{|role| !role["unassignable"]}
    roles.each {|role| role_list << {name: role["name"]}}

    # Set response
    if role_list.empty?
      error_msg(ErrorCodes::ERROR, "No User Roles are defined")
    else
      @response[:roles] = role_list
    end
    render_json
  end
end
