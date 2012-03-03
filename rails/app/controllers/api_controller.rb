class ApiController < ApplicationController
  def update
    success = redis.set 'matrix:values'
    if (success)
      render json: true, status: '200'
    else
      render json: false, status: '400'
    end
  end
  def show
    values = redis.get 'matrix:values'
    render json: values
  end

private
  def redis
    Redis.new
  end
  def redis_key
    'matrix:values'
  end
end
