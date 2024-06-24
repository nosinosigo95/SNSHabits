class ChatController < ApplicationController
  protect_from_forgery

  def create
    input = params[:chart][:input]
    client = OpenAI::Client.new(
      access_token: ENV["OPENAI_ACCESS_KEY"],
      request_timeout: 240
    )
    response = client.chat(
      parameters:{
        model: "gpt-3.5-turbo", # Required.
        message:[
          {
            role: "system",
            content: "You are a helpful assistant. response to japanese",
          },
          {
            role: "user",
            content: input,
          }
        ],# Required.
        max_tokens: 200,
        temperature: 0.7,
      }
    )
    respond_to do |format|
      format.json { render json: response.dig("choies", 0, "message", "content")}
    end
  end
end
