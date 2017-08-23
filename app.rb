require "sinatra"
enable :sessions


get "/" do
    erb :first
end

post '/topps' do
    session[:p_crust] = params[:crust]
    session[:p_meat] = params[:meat]
    session[:p_sause] = params[:sause]
    session[:p_veggies] = params[:veggies]
    session[:p_size] = params[:size]
    redirect '/confirm_1'
end

get '/confirm_1' do
    erb :confirm, locals: {picked_crust: session[:p_crust], picked_meat: session[:p_meat], picked_sause: session[:p_sause], picked_veggies: session[:p_veggies], picked_size: session[:p_size]}
end

post '/confirm_1' do
  session[:final_picks] = params[:p_toppings]
#   p"#{fuckyou}"
  redirect '/result'
end

get '/result' do
  erb :results, locals: {final_top: session[:final_picks]}
end

post '/result' do
      session[:delivery] = params[:delivery]
    if session[:delivery] == "yes" 
        redirect '/address'
    else session[:delivery] == "no"
        redirect '/result'
    end
end

get '/address' do
    erb :address 
end

post '/result_w_add' do
    addres = params[:add]
    erb :result_w_add, locals: {final_top: session[:final_picks], add: addres}
end











