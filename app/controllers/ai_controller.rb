class AiController < ApplicationController
  before_action :authenticate_user!
  before_action :set_location

  def agrobot
    @messages = @location.agrobot_messages.order(created_at: :asc)
    @new_message = AgrobotMessage.new
  end

  def ask
    # Guardar pregunta del usuario
    user_message = @location.agrobot_messages.create(role: "user", content: params[:question])

    # Crear conversación completa
    messages = @location.agrobot_messages.order(created_at: :asc).map do |msg|
      { role: msg.role, content: msg.content }
    end

    # Insertar system prompt
    messages.unshift({ role: "system", content: "Eres un experto en agricultura y ganadería." })

    begin
      response = OPENAI_CLIENT.chat(
        parameters: {
          model: "gpt-3.5-turbo",
          messages: messages,
          temperature: 0.7
        }
      )
      ai_reply = response.dig("choices", 0, "message", "content")
      @location.agrobot_messages.create(role: "assistant", content: ai_reply)
    rescue => e
      ai_reply = "Hubo un error al procesar tu pregunta. Intenta de nuevo más tarde."
      @location.agrobot_messages.create(role: "assistant", content: ai_reply)
    end

    redirect_to location_agrobot_path(@location)
  end

  def clear
    @location.agrobot_messages.destroy_all
    flash[:notice] = "El historial del chat ha sido reiniciado."
    redirect_to location_agrobot_path(@location)
  end

  private

  def set_location
    @location = Location.find(params[:location_id])
  end
end
