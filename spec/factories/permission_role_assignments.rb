# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :permission_role_assignment, :class => 'PermissionRoleAssignments' do
    role_id 1
    permission_id 1
  end
end
