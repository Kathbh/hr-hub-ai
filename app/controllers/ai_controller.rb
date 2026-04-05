class AiController < ApplicationController
  skip_before_action :verify_authenticity_token #dont require CSRF token to this controller
  def chat
    # Read the prompt from frontend
    prompt = params[:prompt]
    #ask AI and send it to the model
    answer = AiService.ask(prompt)
    #return JSON so frontend can use
    render json: { answer: }
  end
end
