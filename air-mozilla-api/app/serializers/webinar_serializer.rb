class WebinarSerializer < ActiveModel::Serializer
  attributes :id, :title, :url, :favicon, :date
end
