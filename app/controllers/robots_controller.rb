class RobotsController < ApplicationController

  include SessionHelper

  def index
    if !session_logged_in?
      redirect_to root_path
    else
      if admin?
        admin = User.find_by(admin: true)
        buyers = User.where(admin: false)
          @inventory_robots = admin.robots.where(inventory: true).order("created_at DESC")
          @ordered_robots = admin.robots.where(inventory: false).order("created_at DESC")
          @sold_robots = []
            buyers.each do |buyer|
              if buyer.robots != nil
                buyer.robots.each do |robot|
                  @sold_robots << robot
                end
              end
            end
      else
        redirect_to user_path(session_current_user)
      end
    end
  end

  def show
    if !session_logged_in?
      redirect_to root_path
    else
      if admin?
        if Robot.exists?(params[:id])
          @robot = Robot.find(params[:id])
        else
          @robot = nil
        end
      else
        redirect_to session_current_user
      end
    end
  end

  def create
    if admin?
      @robot = Robot.new(model_id: params[:model_id])
      if @robot.save
        redirect_to robot_path(@robot.id), notice: "New Robot Ordered"
      else
        redirect_to manufacturers_path, alert: "Robot Not Saved"
      end
    else
      redirect_to session_current_user
    end
  end

  def edit
    if !session_logged_in?
      redirect_to root_path
    else
      if admin?
        @robot = Robot.find(params[:id])
      else
        redirect_to session_current_user
      end
    end
  end

  def update
    if admin?
      @robot = Robot.find(params[:id])
      if @robot.update_attributes(bot_params)
        redirect_to robot_path(@robot.id), :notice => "Your robot's status has been updated"
      else
        redirect_to edit_robot_path(@robot.id), :alert => "You cannot designate a robot until it is moved to your inventory."
      end
    else
      redirect_to session_current_user
    end
  end

  def destroy
    if admin?
      robot = Robot.find(params[:id])
      Robot.destroy(robot)
      redirect_to robot_path(robot), :alert => "Robot has been destroyed"
    else
      redirect_to session_current_user
    end
  end

  private

    def bot_params
      params.require(:robot).permit(:inventory, :designation)
    end
end
