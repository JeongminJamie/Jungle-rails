require 'rails_helper'
 # :name, presence: true
 # :price, presence: true
 # :quantity, presence: true
 # :category, presence: true

RSpec.describe Product, type: :model do
  describe 'Validations' do

    it 'has all four fields set to save' do
    @category = Category.create(name:'Women')
    @product = Product.new(
      name: 'Wide pants',
      price: 42.00,
      quantity: 20,
      category_id: @category.id
    )
    expect(@product).to be_valid
  end

  it 'cannot be saved without name' do
    @category = Category.create(name: 'Men')
    @product = Product.new(
      price: 55.00,
      quantity: 10,
      category_id: @category.id
    )
    expect(@product).to_not be_valid
    expect(@product.errors.messages[:name]).to include('can\'t be blank')
  end

  it 'cannot be saved without price' do
  @category = Category.create(name: 'Kids')
  @product = Product.new(
    name: 'Spiderman T-shirts',
    quantity: 20,
    category_id: @category.id
  )
  expect(@product).to_not be_valid
  expect(@product.errors.messages[:price]).to include('can\'t be blank')
  end

  it 'cannot be saved without quantity' do
    @category = Category.create(name: 'Babies')
    @product = Product.new(
      name: 'warm winter socks',
      price: 15,
      category_id: @category.id
    )
    expect(@product).to_not be_valid
    expect(@product.errors.messages[:quantity]).to include('can\'t be blank')
    end

  it 'cannot be saved without category' do
    @category = Category.create(name: 'Skirts')
    @product = Product.new(
      name: 'Summer flower skirt',
      price: 15,
      quantity: 20,
      )
      expect(@product).to_not be_valid
      end
  end
end