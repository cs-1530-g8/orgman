class LinksController < ApplicationController
  before_filter :authenticate_user!

  def index
    @links = Link.active
    @links = @links.decorate
    @new_link = Link.new
  end

  def create
    username = 'pittdxc'
    api_key =  'R_d469a17c98cb6fb08631749d447bab82'

    link = Link.new(link_params)

    if link.expiration.nil?
      link.expiration = Date.today + 36500
    end

    Bitly.use_api_version_3
    bitly = Bitly.new(username, api_key)
    short = bitly.shorten(link.url)
    link.url = short.short_url

    link.save
    redirect_to links_path
  end

  def deactivate
    link = Link.find(params[:id])
    if link && link.user == current_user ||
       current_user.position == Position.find_by(name: User::SECRETARY)
      link.update(expiration: Date.today - 1)
    end
    redirect_to links_path
  end

  private

  def link_params
    params.require(:link).permit(:name, :url, :expiration, :user_id)
  end
end
