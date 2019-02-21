# frozen_string_literal: true

json.articles do |json|
  json.array! @authors, partial: 'authors/author', as: :author
end

json.articles_count @authors_count
