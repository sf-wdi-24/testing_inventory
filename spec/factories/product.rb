FactoryGirl.define do
  factory :product do
    wholesale_price = Random.new.rand(1.0..100.0).round(2)
    
    name { FFaker::Lorem.words(5).join(" ") }
    description { FFaker::Lorem.sentence }
    category { FFaker::Lorem.words(3).join }
    sku { FFaker::Lorem.words(2).join }
    wholesale { wholesale_price }
    retail { wholesale_price * 4 }
  end
end