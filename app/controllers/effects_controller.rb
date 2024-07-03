class EffectsController < ApplicationController
  def show
    effect = Effect.find_by(id: params[:id])
    redirect_to controller: "habits", action: "index", habit_index_form: {effect_item: effect.effect_item}
  end
end
