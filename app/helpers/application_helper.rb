module ApplicationHelper

  # Returns the full title on a per-page basis.
  def full_title(page_title = '')
    base_title = "Ruby on Rails Tutorial Sample App"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  def list_category
    @categories = Category.order('level')
  end

  def list_user_chat
    @users = User.all
    hash = { :A => Array.new, :B => Array.new, :C => Array.new, :D => Array.new,
             :E => Array.new, :F => Array.new, :G => Array.new, :H => Array.new,
             :I => Array.new, :J => Array.new, :K => Array.new, :L => Array.new,
             :M => Array.new, :N => Array.new, :O => Array.new, :P => Array.new,
             :Q => Array.new, :R => Array.new, :S => Array.new, :T => Array.new,
             :U => Array.new, :V => Array.new, :W => Array.new, :X => Array.new,
             :Y => Array.new, :Z => Array.new }
    @users.each do |item|
      case item.name[0].upcase
      when "A"
        hash[:A].push(item)
      when "B"
        hash[:B].push(item)
      when "C"
        hash[:C].push(item)
      when "D"
        hash[:D].push(item)
      when "E"
        hash[:E].push(item)
      when "F"
        hash[:F].push(item)
      when "G"
        hash[:G].push(item)
      when "H"
        hash[:H].push(item)
      when "I"
        hash[:I].push(item)
      when "J"
        hash[:J].push(item)
      when "K"
        hash[:K].push(item)
      when "L"
        hash[:L].push(item)
      when "M"
        hash[:M].push(item)
      when "N"
        hash[:N].push(item)
      when "O"
        hash[:O].push(item)
      when "P"
        hash[:P].push(item)
      when "Q"
        hash[:Q].push(item)
      when "R"
        hash[:R].push(item)
      when "S"
        hash[:S].push(item)
      when "T"
        hash[:T].push(item)
      when "U"
        hash[:U].push(item)
      when "V"
        hash[:V].push(item)
      when "W"
        hash[:W].push(item)
      when "X"
        hash[:X].push(item)
      when "Y"
        hash[:Y].push(item)
      when "Z"
        hash[:Z].push(item)
      end
    end
    return hash
  end
end
