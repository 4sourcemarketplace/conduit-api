# frozen_string_literal: true

json.author do |json|
  json.partial! 'authors/author', author: @author
end
