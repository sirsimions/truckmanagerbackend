class AuthorSerializer < ActiveModel::Serializer
  attributes :id, :name, :department, :email
end
