class User < ActiveRecord::Base
  include BCrypt
  validates :email, :format => { :with => /\A[a-zA-Z]+\z/,
    :message => "only letters allowed" }
  validates :email, :uniqueness => true

  has_one :token
  has_many :rounds
  has_many :decks, :through => :rounds
  has_many :guesses, :through => :rounds

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

  def self.authenticate(email, password) # authenticates user on login
    @user = User.find_by_email(email)
    if @user == nil
      false
    elsif @user.password == password
      @user
    else
      false
    end
  end
end
