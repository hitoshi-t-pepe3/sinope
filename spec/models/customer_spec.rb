# -*- encoding: utf-8 -*-
require 'spec_helper'

describe Customer do
  let(:customer) { FactoryGirl.build(:customer) }
  let(:customer) do
    Customer.new(
      family_name: '山田', given_name: '太郎',
      family_name_kana: 'ヤマダ', given_name_kana: 'タロウ'
    )
  end

  specify "妥当なオブジェクト" do
    expect(customer).to be_valid
  end

  %w{family_name given_name family_name_kana given_name_kana}.each do |column_name|
    specify "#{column_name} は空であってはならない" do
      customer[column_name] = ''
      expect(customer).not_to be_valid
      expect(customer.errors[column_name]).to be_present
    end

    specify "#{column_name} は40文字以内" do
      customer[column_name] = 'ア' * 41
      expect(customer).not_to be_valid
      expect(customer.errors[column_name]).to be_present
    end
  end
end
