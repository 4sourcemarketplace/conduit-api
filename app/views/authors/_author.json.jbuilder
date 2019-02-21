# frozen_string_literal: true

json.call(author, :name,:user_id)
json.author author.user, partial: 'profiles/profile', as: :user
