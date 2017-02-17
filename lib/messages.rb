module Messages

  def get_messages(page = nil)
    if page.nil?
      response = self.class.get("https://www.bloc.io/api/v1/message_threads", headers: { "authorization" => @auth_token })
      @message_threads = JSON.parse(response.body)
    else
      response = self.class.get("https://www.bloc.io/api/v1/message_threads", headers: { "authorization" => @auth_token }, body: { "page" => page })
      @message_threads = JSON.parse(response.body)
    end
  end

  def create_message(subject, text, recipient_id, options = {})
    get_me if @current_user_hash.nil?
    body = { "sender" => @current_user_hash["email"], "recipient_id" => recipient_id, "subject" => subject, "stripped-text" => text }
    body["token"] = options[:token] if options[:token]
    response = self.class.post("https://www.bloc.io/api/v1/messages", headers: { "authorization" => @auth_token }, body: body)
    if response.body
      puts "Your message was sent."
    else
      puts "There was an error sending your message."
    end
  end

end
