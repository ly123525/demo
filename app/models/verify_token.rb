class VerifyToken < ApplicationRecord

  def self.upsert cellphone, token
    cond = { cellphone: cellphone }
    record = self.find_by(cond)
    unless record
      record = self.create cond.merge(token: token, expired_at: Time.now + 10.minutes)
    else
      record.update_attributes token: token, expired_at: Time.now + 10.minutes
    end

    record
  end
end
