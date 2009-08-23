module ItemsHelper
  def distance_phrase_for(item)
    distance = item.user.distance_from current_user
    case Math.log10(distance).floor
    when 0
      "walking distance"
    when 1
      "driving distance"
    else
      "probably too far"
    end
  rescue
    "an unknown distance"
  end
end
