module ApplicationHelper

  def has_permission?(permission)

    permission = Permission.where(value: permission).first
    # intersection of both arrays
    valid_role = permission.roles & @active_user.roles
    valid_role.any?

  end
end
