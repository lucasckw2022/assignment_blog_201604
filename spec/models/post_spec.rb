require 'rails_helper'

RSpec.describe Post, type: :model do
  describe ".body_snippet" do
    it "return 100 chatacter with ... if its more than a 100 characters" do
      c = Post.new(body:"aa"*100)
      expect(c.body_snippet).to eq("a"*100+"...")
    end
    it "return body if less than 100 "
  end
end
