Rails.application.routes.draw do
  resources :empresa_choferes do
    get :search, on: :collection
  end
  resources :matriculas do
    get :search, on: :collection
  end
  resources :choferes
  resources :empresas
  resources :vehiculos
  resources :matriculas_log
  resources :tarifas
  resources :liquidacion_de_viajes
end
