module UsersHelper

  # ユーザーが存在していない場合、ラベル横に必須の文字を表示する
  def display_requirement(user)
    "必須" unless User.exists?(user.id)
  end
  
end
