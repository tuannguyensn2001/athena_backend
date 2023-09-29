module Api::V1
  class Newsfeed < Grape::API
    version 'v1', using: :path

    include Api::Authentication

    resources :newsfeed do
      before do
        authenticate!
      end
      resources :posts do
        desc "Create post"
        params do
          requires :workshop_id, type: Integer, desc: "Workshop id"
          requires :content, type: String, desc: "Content"
        end
        post do
          service = NewsfeedService::CreatePost.new(current_user, params)
          result = service.call
          if service.success?
            {
              message: "success",
              data: result
            }
          else
            error!({ message: service.errors }, 500)
          end
        end
      end
    end
  end

end
