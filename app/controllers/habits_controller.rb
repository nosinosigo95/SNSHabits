class HabitsController < ApplicationController
  def new
    @habit = GoodHabit.new
  end
  def create
  end
end
