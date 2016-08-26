Rails.application.routes.draw do   
  resources :empresa_choferes  
  resources :matriculas
  resources :choferes
  resources :empresas
  resources :vehiculos
  resources :matriculas_log
  resources :tarifas
end
