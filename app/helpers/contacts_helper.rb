module ContactsHelper
  include ActsAsTaggableOn::TagsHelper

  def state_icon(state)
    case state.downcase
      when :pending
          "fa fa-flag-o"
      when :sent_letter
          "fa fa-paper-plane"
      when :setting_up_a_meeting
          "fa fa-coffee"
      when :presented_vision
          "fa fa-video-camera"
      when :following_up
        "fa fa-mail-reply"
      when :no_response
        "fa fa-exclamation-circle"
      when :cannot_give
        "fa fa-times"
      when :special_gift
        "fa fa-gift"
      when :monthly_supporter
        "fa fa-group"
      else
        "icon-star-empty"
    end
  end

end