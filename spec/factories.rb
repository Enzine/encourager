FactoryGirl.define do
  factory :user do
    username "Pekka"
    password "Passwor1"
    password_confirmation "Passwor1"
  end

  factory :goal do
    name "goal"
    score 2
  end

  factory :goal2, class: Goal do
    name "goal2"
    score 5
  end

  factory :tag do
    name "tag"
  end

  factory :tag2, class: Tag do
    name "tag2"
  end


end
