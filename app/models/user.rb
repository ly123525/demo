class User < ApplicationRecord
  authenticates_with_sorcery!
  validates :password, length: { minimum: 6, message:'密码最少为6位' }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: {message:'密码不一致'}, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: {message: '密码确认不能空'}, if: -> { (new_record? || changes[:crypted_password]) and !password.blank?  }


  attr_accessor :token
  validate :validate_email_or_cellphone

  CELLPHONE_RE = /\A(\+86|86)?1\d{10}\z/
  EMAIL_RE = /\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*/

  def username
    self.email.blank? ? self.cellphone : self.email.split('@').first
  end

  before_create :set_access_token

  private
  def set_access_token
    self.access_token = RandomCode.generate_utoken(32)
  end

  def validate_email_or_cellphone
    if[self.email, self.cellphone].all?{|attr| attr.nil?}
      self.errors.add :base, "邮箱和手机号其中之一不能为空"
      return false
    end

    if self.cellphone.nil?
      if self.email.blank?
        self.errors.add :base, '邮箱不能为空'
        return false
      else
        unless self.email=~ EMAIL_RE
          self.errors.add :base,'邮箱格式不正确'
          return false
        end
        user = User.find_by(:email=>self.email)
        if user
          self.errors.add :base, '邮箱已经存在'
        end
      end
    else
      unless self.cellphone =~ CELLPHONE_RE
        self.errors.add :cellphone, '手机号格式不正确'
        return false
      end
      user = User.find_by(:cellphone=> self.cellphone)
      if user
        self.errors.add :base, '手机号已经存在'
        return false
      end
    end
    return true
  end
end
