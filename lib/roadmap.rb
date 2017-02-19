module Roadmap

  def get_roadmap(roadmap_id)
    response = self.class.get("https://www.bloc.io/api/v1/roadmaps/#{roadmap_id}", headers: {"authorization" => @auth_token })
    @roadmap = JSON.parse(response.body)
  end

  def get_checkpoint(checkpoint_id)
    response = self.class.get("https://www.bloc.io/api/v1/checkpoints/#{checkpoint_id}", headers: {"authorization" => @auth_token })
    @checkpoint = JSON.parse(response.body)
  end

  def create_submission(checkpoint_id, assignment_branch, assignment_commit_link, comment)
    get_me if @current_user_hash.nil?
    body = { "enrollment_id" => @current_user_hash["enrollment_id"],
            "checkpoint_id" => checkpoint_id, "assignment_branch" => assignment_branch, "assignment_commit_link" => assignment_commit_link, "comment" => comment }
    response = self.class.post("https://www.bloc.io/api/v1/checkpoint_submissions", headers: { "authorization" => @auth_token }, body: body)
  end

end
