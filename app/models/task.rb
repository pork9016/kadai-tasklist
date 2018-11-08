class Task < ApplicationRecord
 validates :content, presence: true, length: { maximum: 255 }
  validates :status, presence: true, length: { maximum: 10,
  too_long: "最大10文字まで使用できます" }

end
