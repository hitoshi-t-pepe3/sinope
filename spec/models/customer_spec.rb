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
    
    specify "#{column_name} は半角カナを含んでもよい" do
      customer[column_name] = 'ｱｲｳ'
      expect(customer).to be_valid
      expect(customer[column_name]).to eq('アイウ')
    end
  end

  %w{family_name given_name}.each do |column_name|
    specify "#{column_name} は、漢字、ひらがな、カタカナを含んでもよい" do
      customer[column_name] = '亜あア'
      expect(customer).to be_valid
    end

    specify "#{column_name}は漢字、ひらがな、カタカナ以外の文字を含まない" do
      ['A', '1', '@'].each do |value|
        customer[column_name] = value
        expect(customer).not_to be_valid
        expect(customer.errors[column_name]).to be_present
      end
    end
  end

  %w{family_name_kana given_name_kana}.each do |column_name|
    specify "#{column_name}はカタカナを含んでもよい" do
      customer[column_name] = 'ア'
      expect(customer).to be_valid
    end

    specify "#{column_name}はひらがなを含んでもよい" do
      customer[column_name] = 'あいう'
      expect(customer).to be_valid
      expect(customer[column_name]).to eq('アイウ')
    end
    
    specify "#{column_name}はカタカナ以外の文字を含まない" do
      ['A', '1', '@', '亜'].each do |value|
        customer[column_name] = value
        expect(customer).not_to be_valid
        expect(customer.errors[column_name]).to be_present
      end
    end
  end
end
