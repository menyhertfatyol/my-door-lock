module DoorlockHelper

  def lock_state(last_lock_state)
    if last_lock_state.created_at < 2.minutes.ago
      "No data received since #{last_lock_state.created_at}"
    else
      last_lock_state.state
    end
  end
end
