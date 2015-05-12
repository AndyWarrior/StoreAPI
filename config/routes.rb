Rails.application.routes.draw do
  namespace :api, path: '/api' do
    api_version(:module => "V1", :header => {:name => "Accept", :value => "application/vnd.list.com+json; version=1"}, :defaults => {:format => :json}, :default => true) do
      #resources :tasks, except: [:new, :edit]

      #Sessions handling
      #post "sing_in" => "sessions#create"
      #delete "sign_out" => "sessions#destroy"
    end
  end
end