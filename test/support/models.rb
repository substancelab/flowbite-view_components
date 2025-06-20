# frozen_string_literal: true

# This file defines some example ActiveModel objects for use in tests.

class Article
  include ActiveModel::Model

  attr_accessor :category_id, :title, :content, :summary

  validates :category_id, presence: true
  validates :content, presence: true
  validates :title, presence: true
end

class Book
  include ActiveModel::Model

  attr_accessor :title, :author, :published_at, :state

  validates :title, presence: true
  validates :author, presence: true
end

class Category
  attr_reader :id, :name

  def initialize(id, name)
    @id = id
    @name = name
  end
end

class Product
  include ActiveModel::Model

  attr_accessor :name, :price, :quantity

  validates :name, presence: true
  validates :price, presence: true
end

class User
  include ActiveModel::Model

  attr_accessor :name, :email, :phone, :password, :subscribed

  validates :email, presence: true
  validates :name, presence: true
  validates :password, presence: true
  validates :phone, presence: true
end
