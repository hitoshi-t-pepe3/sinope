require 'spec_helper'

describe 'top page' do
  specify 'disp hello world!' do
    visit root_path
    expect(page).to have_css('p', text: 'Hello World!')
  end
end

