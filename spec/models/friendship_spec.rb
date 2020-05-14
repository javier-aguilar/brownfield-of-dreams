require 'rails_helper'

RSpec.describe Friendship do
  it {should belong_to :user}
  it {should belong_to(:friend).class_name(:User) }
end
