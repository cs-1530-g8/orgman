class QuickLinksController < ApplicationController

  username = 'pittdxc'
  api_key =  'R_d469a17c98cb6fb08631749d447bab82'

  def index
    @links = Link.active()
    @new_link = Link.new
  end

  def create
    @new_link = Link.new(link_params)
    @new_link.save
    redirect_to quick_links_path
  end

  private

  def link_params
    params.require(:link).permit(:name, :url, :expiration)
  end

end
