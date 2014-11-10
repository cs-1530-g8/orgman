class QuickLinksController < ApplicationController

  before_filter :authenticate_user!

  def index
    @links = Link.active()
    @links = @links.decorate
    @new_link = Link.new
  end

  def create
    username = 'pittdxc'
    api_key =  'R_d469a17c98cb6fb08631749d447bab82'

    @new_link = Link.new(link_params)
    @new_link.user_id = current_user.id

    Bitly.use_api_version_3
    bitly = Bitly.new(username, api_key)
    short = bitly.shorten(@new_link.url)
    @new_link.url = short.short_url

    @new_link.save
    redirect_to quick_links_path
  end

  def deactivate
    link = Link.find(params[:id])
    if link && link.user_id == current_user.id
      link.update_attribute(:expiration, Date.today - 1)
    end
    redirect_to quick_links_path
  end

  private

  def link_params
    params.require(:link).permit(:name, :url, :expiration)
  end

end
