class ApiController < ApplicationController
  def update
    type = (params.keys & ['text', 'value']).first
    
    success   = REDIS.set 'matrix:type', type
    success &&= REDIS.set 'matrix:values', params[type].downcase
    
    if success
      render json: true, status: 200
    else
      render json: false, status: 400
    end
  end
  def show
    type   = REDIS.get 'matrix:type'
    values = REDIS.get 'matrix:values'
    
    if type == 'text'
      render json: {text: values}
    else
      render json: {value: JSON.parse(values)}
    end
  end
end
