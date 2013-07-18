class Url < ActiveRecord::Base
  belongs_to :user
  validates :original, presence: true
  validates :original, format: {with: /^http[s]?/, message: "must start with http"}
  before_save :generate_short_url

  def add_click
    self.clicks += 1
    self.save
  end

  def generate_short_url
    characters = "0123456789abcdefghijklmnopqrstuvwxyz".split(//)
    if Url.last
      id = Url.last.id + 1
    else
      id = 1
    end
    self.short_url ||= characters.sample(2).join + (id + 1).to_s + characters.sample(2).join
  end

end