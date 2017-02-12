require 'httparty'
require 'json'

class Kele

  include HTTParty
  base_uri "https://www.bloc.io/api/v1"

  def initialize(email, password)
    response = self.class.post("https://www.bloc.io/api/v1/sessions", body: { email: email, password: password })
    @auth_token = response['auth_token']

    if response.nil? || response['auth_token'].nil?
      raise ArgumentError.new("The system was unable to authorize you.")
    end
  end

  def get_me
    response = self.class.get("https://www.bloc.io/api/v1/users/me", headers: { "authorization" => @auth_token })
    @current_user_hash = JSON.parse(response.body)
  end

  def get_mentor_availability(mentor_id)
    response = self.class.get("https://www.bloc.io/api/v1/mentors/#{mentor_id}/student_availability", headers: { "authorization" => @auth_token })
    @mentor_schedule = JSON.parse(response.body)
  end
end
