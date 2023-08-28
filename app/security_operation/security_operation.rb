module SecurityOperation
  def check_user_roles(roles)
    @user_roles = UserRole.where(user: current_user)

    if roles.kind_of?(Array)
      puts "Roles parameter: #{roles.inspect}"
      @user_roles = UserRole.where(user: current_user)
      puts "User roles: #{@user_roles.inspect}"
      @user_roles.each do |i|
        byebug
        if roles.include?(i.role.name)
          byebug
          return;
        end
      end
    else
      raise Exception.new "You must give an array parameter (security_operation.rb)"
    end
    byebug
    render json: { message: "You have no permission,(security_operation.rb)" }, status: 401
  end  
end