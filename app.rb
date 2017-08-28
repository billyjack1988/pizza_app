require "sinatra"
enable :sessions


get "/" do
    session[:final_picks] = nil 
    p "#{session[:final_picks]}after nil"
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
    erb :confirm, locals: {picked_crust: session[:p_crust], picked_meat: session[:p_meat], picked_sause: session[:p_sause], picked_veggies: session[:p_veggies], picked_size: session[:p_size], pizzas: session[:pizzas]}
end

post '/confirm_1' do
  final = params[:p_toppings]
  session[:final_picks] = final.values
#   p"#{fuckyou}"
  redirect '/result'
end

get '/result' do
    p session[:pizzas]
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

post '/amount_of_pizza' do
 picked_again = params[:yes_no]
 session[:pizzas] = params[:pizzas].to_i
 session[:all_pizza] = session[:all_pizza] || []
    session[:pizzas].times do 
        session[:all_pizza] << session[:final_picks]
     #  p "#{session[:all_pizza]}yooo loo herr "
    end
     p "#{session[:all_pizza]}yooo loo herr "
     if picked_again == "yes"
        redirect '/' 
    else 
        redirect '/checkout'
    end
end

get '/checkout' do 
    session[:all_pizza]
    erb :checkout, locals:{all_pizza: session[:all_pizza] }
    # p "#{session[:all_pizza]} the final total!!!!!"
end















