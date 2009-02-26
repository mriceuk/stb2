# x’(n) = (ax(n-1) + bx(n) + cx(n+1))/(a+b+c)

@positions = BullPosition.find_all_for_today

@position_string = ""
@last_position = nil

@positions.each do |position|

    if distance(@lastposition,position) < 10
      # ignore position
    end

    @last_position = position

end