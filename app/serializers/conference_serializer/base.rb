module ConferenceSerializer
  class Base < ActiveModel::Serializer
    attributes :id, :name, :created_at, :updated_at
  end
end
