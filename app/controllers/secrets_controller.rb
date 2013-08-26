class SecretsController < ApplicationController
  before_filter :require_current_user!

  def new
    @secret = Secret.new
    @secret.recipient_id = params[:user_id]

    render :new
  end

  def create
    tag_ids = params[:secret].delete(:tag_ids)

    @secret = Secret.new(params[:secret])
    @secret.author_id = current_user.id
    ActiveRecord::Base.transaction do
      @secret.save
      @secret_tags = []

      tag_ids.each do |tag_id|
        @secret_tags << SecretTagging.create(
          :secret_id => @secret.id,
          :tag_id => tag_id
        )
      end

      if ([@secret] + @secret_tags).all? { |obj| obj.valid? }
        redirect_to user_url(@secret.recipient_id)
      else
        render :new
      end
    end
  end
end
