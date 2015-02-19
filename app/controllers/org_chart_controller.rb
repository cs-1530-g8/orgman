class OrgChartController < ApplicationController
  before_action -> { user_has_position("Secretary") }, only: [:create, :destroy]
  before_action :authenticate_user!

  def index
    @charts = []
    division_names = User.uniq.pluck(:division).reject(&:nil?)
    division_names.each do |name|
      data_table = GoogleVisualr::DataTable.new
      data_table.new_column('string', 'Name'   )
      data_table.new_column('string', 'Manager')
      data_table.new_column('string', 'ToolTip')
      data_table.add_rows(get_array_for_division(name))
      options = { allowHtml: true }

      chart = GoogleVisualr::Interactive::OrgChart.new(data_table, options)
      brk
      @charts.push(chart)
    end
  end

  def show
  end

  def edit
  end

  def new
  end

  def create
  end

  def destroy
  end

  private

  def user_params
    params.require(:user).permit(:id, :division, :extra_info, :parent_id)
  end

  def get_array_for_division(division)
    users = User.where(division: division)
    user_array = []
    users.each do |user|
      user_array.push([{v: "#{user.id}", f: "#{user.name}<div style='color:red;font-style: italic'>#{user.extra_info} </div>"}, user.parent_id.to_s, ''])
    end
    user_array
  end
end
