class ApiController < ApplicationController
  def update
    success = REDIS.set 'matrix:values', params[:value]
    if success
      render json: true, status: 200
    else
      render json: false, status: 400
    end
  end
  def show
    values = REDIS.get 'matrix:values'
    render json: values
  end

private
  def redis_key
    'matrix:values'
  end
end
