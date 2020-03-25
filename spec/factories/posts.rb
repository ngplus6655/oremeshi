FactoryBot.define do
  factory :post do
    title { 'テスト用ポスト' }
    body { 'おいしいですおいしいですおいしいですおいしいです' }
    price { 3500 }
    review { 4.5 }
  end
    
end