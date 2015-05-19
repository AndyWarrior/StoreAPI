FactoryGirl.define do

    factory :products do
        name 'PlayStation 3'
        description 'Esta es la descripcion del producto'
        price 130.00
        image_url 'http://media.engadget.com/img/product/14/bca/playstation-3-slim-nj2-800.jpg'
        available true
    end

    factory :user do
        email "mail@gmail.com"
        password "12345678"
        name "Don Mail"
        budget 1000
    end

end
