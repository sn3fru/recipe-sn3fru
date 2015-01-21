class Recipe < ActiveRecord::Base

  include PublicActivity::Model

  belongs_to :user
  belongs_to :category
  belongs_to :tree_recipe

  has_many :ingredients
  has_many :directions
  has_many :reviews, dependent: :destroy



  accepts_nested_attributes_for :ingredients,
                                reject_if: proc { |attributes| attributes['name'].blank? },
                                allow_destroy: true
  accepts_nested_attributes_for :directions,
                                reject_if: proc { |attributes| attributes['step'].blank? },
                                allow_destroy: true

  validates :title, :description, :image, presence: true

  has_attached_file :image, styles: { :medium => "300x300#", :MediumIndex => "200x200#>", :thumb => "100x100#>"  }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  acts_as_likeable

  def self.popular_recipes
    arr_recipes_likes = Hash.new
    recipes = []
    Recipe.all.each do |r|
      arr_recipes_likes[r.id] = r.likers(User).count
    end
    arr_recipes_likes.sort_by{ |k, v| v }.reverse.first(5)
    arr_recipes_likes.each do |item|
      recipes << item.first
    end
    Recipe.where(id: recipes)
  end
end
