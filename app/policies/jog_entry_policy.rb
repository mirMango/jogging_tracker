class JogEntryPolicy < ApplicationPolicy
  def show?
    true
  end

  def update?
    record.user_id == user.id || user.admin?
  end

  def destroy?
    record.user_id == user.id || user.manager? || user.admin?
  end

  def destroy
    @jog_entry = JogEntry.find(params[:id])

    authorize @jog_entry

    @jog_entry.destroy
    head :no_content
  end
end
