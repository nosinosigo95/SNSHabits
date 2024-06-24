class ChatController < ApplicationController
  protect_from_forgery

  def create
    input = params[:input]
    client = OpenAI::Client.new(
      access_token: ENV["OPENAI_ACCESS_KEY"],
      request_timeout: 240
    )
    response = client.chat(
      parameters:{
        model: "gpt-3.5-turbo", # Required.
        messages:[
          {
            role: "system",
            content: "You are a helpful assistant. response to japanese"
          },
          {
            role: "user",
            content: input
          }
        ],# Required.
        max_tokens: 200,
        temperature: 0.7
      }
    )
    respond_to do |format|
      format.json { render json: {response: response.dig("choices", 0, "message", "content") } }
    end
  end
end
