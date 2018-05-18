class TweetsController < ApplicationController
  get '/tweets' do
    if logged_in?
      @user = current_user
      @tweets = Tweet.all
      erb :"/tweets/tweets"
    else
      redirect "/login"
    end
  end

  get '/tweets/new' do
    erb :'/tweets/create_tweet'
  end

  post '/tweets' do
    if logged_in? && params[:content] != ""
      user = User.find_by_id(session[:user_id])
      @tweet = Tweet.create(:content => params[:content], :user_id => user.id)
      redirect "/tweets/#{@tweet.id}"
    elsif params[:content] == ""
      redirect to "/tweets/new"
    end
  end

end
