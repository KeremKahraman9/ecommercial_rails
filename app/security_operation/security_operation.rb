module SecurityOperation
  def check_user_roles(roles)
    if roles.kind_of?(Array)
      @user_roles = UserRole.where(user: current_user)
      @user_roles.each do |i|
        if role.include? i.role.name
          return;
        end
      end
    else
      raise Exception.new "You must give an array parameter (security_operation.rb)"
    end
    render json: {message: "You have no permission"}, status: 401
  end
end