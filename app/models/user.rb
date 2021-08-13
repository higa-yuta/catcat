class User < ApplicationRecord

  attr_accessor :remember_token

  before_save { self.email = email.downcase }

  validates :name, presence: true, length: { maximum: 50 }
  
  VALID_EMAIL_REGEX = /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 191 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

  # 渡された文字列をハッシュ値で返す
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
  
  # ランダムな値を返す
  def User.new_token
    s = [SecureRandom.random_bytes].pack("m0")
    s.tr!("+/", "-_")
    s.delete!("=")
    s
  end

  # 永続セッションを記憶する
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # remember_digestを認証する
  def authenticate?(token)
    return false if token.nil?
    BCrypt::Password.new(remember_digest).is_password?(token)
  end

  # ログイン情報を破棄する
  def forget
    update_attribute(:remember_digest, nil)
  end
end
