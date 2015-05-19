FactoryGirl.define do

    factory :product do
        name 'PlayStation 3'
        description 'Esta es la descripcion del producto'
        price 130.00
        image_url 'http://media.engadget.com/img/product/14/bca/playstation-3-slim-nj2-800.jpg'
        available 5
    end

    factory :user do
        email "mail@gmail.com"
        password "12345678"
        budget 1000
    end

    factory :order do
        user_id 1
        product_id 1
        amount 1
    end

end
