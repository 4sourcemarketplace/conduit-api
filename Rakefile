# frozen_string_literal: true

# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)
require 'net/http'

# checking if the authors I am sending up to the UI are correct 

namespace "author" do
  desc "Call the package endpoint"
  task "all" => [:environment] do
    uri = URI('http://localhost:3000/api/authors')
    res = Net::HTTP.get_response(uri)
    if res.is_a?(Net::HTTPSuccess)
      all = []
      caller = JSON.parse(res.body.to_s)
      caller["articles"].each do |t|
        all.push(t["userId"])
      end
      all.each do |f|
      article = Article.find_by(user_id: f)
      if article
        puts "true"
      else
        return puts "test failed"
        end
      end
    end
  end
end


# inputting of non-author


namespace "author" do
  desc "Call the package endpoint"
  task "error" => [:environment] do
    uri = URI('http://localhost:3000/api/authors')
    res = Net::HTTP.get_response(uri)
    if res.is_a?(Net::HTTPSuccess)
      all = []
      caller = JSON.parse(res.body.to_s)
      caller["articles"].each do |t|
        all.push(t["userId"])
        all.push(2)
      end
      all.each do |f|
      article = Article.find_by(user_id: f)
      if article
        puts "true"
      else
       puts "TEST FAILED"
       break;
        end
      end
    end
  end
end



Rails.application.load_tasks
