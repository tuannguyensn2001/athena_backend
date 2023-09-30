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
          optional :is_pinned, type: Boolean, desc: 'Pinned', default: false
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

        desc "Pin post"
        params do
          requires :post_id, type: Integer
        end
        put 'pin' do
          service = NewsfeedService::PinPost.new(current_user, params)
          service.call
          if service.success?
            {
              message: "success"
            }
          else
            error!({ message: service.errors.first }, 500)
          end
        end

      end

      resources :comments do

        desc "Create comment"
        params do
          requires :content, type: String, desc: 'Content'
          requires :post_id, type: Integer, desc: 'Post id'
        end
        post do
          service = NewsfeedService::CreateComment.new(current_user, params)
          service.call
          if service.success?
            {
              message: "success"
            }
          else
            error!({ message: service.errors }, 500)
          end
        end

        desc "Get comments in post"
        params do
          requires :post_id, type: Integer, desc: 'Post id'
        end
        get 'posts/:post_id' do
          service = NewsfeedService::GetCommentInPost.new(current_user, params)
          result = service.call
          if service.success?
            {
              message: "success",
              data: ActiveModelSerializers::SerializableResource.new(result, each_serializer: CommentSerializer)
            }
          else

            error!({ message: service.errors }, 500)
          end
        end

        desc "Delete comment"
        params do
          requires :comment_id, type: Integer, desc: 'Comment id'
        end
        delete ':comment_id' do
          service = NewsfeedService::DeleteComment.new(current_user, params)
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
