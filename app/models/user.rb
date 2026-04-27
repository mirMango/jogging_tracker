class User < ApplicationRecord
  # Include strategy for JWT Revocation
  include Devise::JWT::RevocationStrategies::JTIMatcher

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self

  enum :role, regular: 0, manager: 1, admin: 2
end
