class OrgChartController < ApplicationController
  before_action -> { user_has_position("Secretary") }, only: [:create, :destroy]
  before_action :authenticate_user!

  def index
    @charts = []
    division_names = User.uniq.pluck(:division).reject(&:nil?)
    division_names.each do |name|
      data_table = GoogleVisualr::DataTable.new
      data_table.new_column("string", "Name")
      data_table.new_column("string", "Manager")
      data_table.new_column("string", "ToolTip")
      data_table.add_rows(get_array_for_division(name))
      options = { allowHtml: true }

      chart = GoogleVisualr::Interactive::OrgChart.new(data_table, options)
      @charts.push(chart)
    end
  end

  def admin
    @divisions = User.uniq.pluck(:division).reject(&:nil?)
  end

  def create
    user = User.find_by(id: params[:user][:existing_id])
    if params[:user][:division].blank?
      params[:user][:division] = params[:user][:existing_division]
    end

    success = false
    if user
      success = user.update(user_params)
    else
      user = User.new(user_params_with_name)
      user.status = "org_chart_dummy"
      user.email = ("a".."z").to_a.shuffle[0, 15].join
      success = user.save(validate: false)
    end

    if success
      flash[:notice] = "Adding #{user.name} to the chart succeeded."
    else
      flash[:alert] = "Adding #{user.name} to the chart failed."
    end
    redirect_to org_chart_admin_path
  end

  def remove
    user = User.find(params[:user][:id])

    success = false
    if user.status == "org_chart_dummy"
      success = user.destroy
    else
      success = user.update(division: nil, parent_id: nil, extra_info: nil)
    end

    if success
      flash[:notice] = "Removing #{user.name} from the chart succeeded."
    else
      flash[:alert] = "Removing #{user.name} from the chart failed."
    end
    redirect_to org_chart_admin_path
  end

  private

  def user_params
    params.require(:user).permit(:division, :extra_info, :parent_id)
  end

  def user_params_with_name
    params.require(:user).permit(:first_name, :division, :extra_info, :parent_id)
  end

  def get_array_for_division(division)
    users = User.where(division: division)
    user_array = []
    users.each do |user|
      user_array.push([{ v: "#{user.id}", f: "#{user.name}" +
                         "<div style='color:red;font-style: italic'>" +
                         "#{user.extra_info}</div>" }, user.parent_id.to_s, ""])
    end
    user_array
  end
end
