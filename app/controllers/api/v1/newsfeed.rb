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

        desc "Get posts in workshop"
        params do
          requires :workshop_id, type: Integer, desc: "Workshop id"
          optional :cursor, type: Integer, desc: 'Cursor', default: 0
          optional :limit, type: Integer, desc: 'Limit', default: 3
        end
        get "workshops/:workshop_id" do
          service = NewsfeedService::GetPostInWorkshop.new(current_user, params)
          result = service.call
          if service.success?
            {
              message: "success",
              data: ActiveModelSerializers::SerializableResource.new(result[:data], each_serializer: PostSerializer),
              meta: result[:meta]
            }
          else
            error!({ message: service.errors }, 500)
          end
        end

        desc "Delete post"
        params do
          requires :post_id, type: Integer, desc: "Post id"
        end
        delete ':post_id' do
          service = NewsfeedService::DeletePost.new(current_user, params)
          service.call
          if service.success?
            {
              message: "success"
            }
          else
            error!({ message: service.errors }, 500)
          end
        end
      end

    end
  end

end
