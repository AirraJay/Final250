# frozen_string_literal: true
class User
  attr_accessor :admin
  attr_accessor :name
  attr_accessor :username
  attr_accessor :location
  attr_accessor :processes

  # Constructor
  def initialize
    @admin = ""
    @name = ""
    @username = ""
    @location = ""
    @processes = 0
  end


  # Method to print data on one Fed object
  def prt
    puts "#@name"
    puts "#@username"
    puts "#@location"
    puts "#@processes"
    puts "#@admin"
  end


end


id = File.new("id.txt", "r")
ps = File.new("ps.txt", "r")
pinky = File.new("pinky.txt", "r")
# List of Fed objects
users = []
while (line = pinky.gets)
  line.strip!
  words = line.split
  curUser = User.new
  users << curUser
  curUser.username = words[0]
  curUser.name = words[1]
  if !words[2].match("pts/" ||  "tty") && (curUser.name != "root")
    curUser.name = curUser.name + " " + words[2]
    curUser.location = words[words.length - 1]
  elsif curUser.name != "root"
    curUser.location = words[words.length - 1]
  else
    curUser.location = "n/a"
  end
  curUser.admin = "N"
end

while (line = id.gets)

  if line.match("wheel")
    line.strip!
    words = line.split
    users.each { |i|
      if i.username == words[0]
        i.admin = "Y"
      end
    }
  end
end

while (line = ps.gets)
  line.strip!
  words = line.split
  users.each { |i|
    if i.username == words[0]
      i.processes = i.processes + 1
    end
  }
end



=begin
# Read and process each line
while (line = file.gets)
  line.strip!            # Remove trailing white space
  words = line.split     # Split into array of words
  if words.length == 0 then
    next
  end
  if @num == 2 || @num == 3
    temp = line.downcase
  end


  # "FEDERALIST No. number" starts a new Fed object
  if words[0]=="FEDERALIST" then
    curFed = Fed.new    # Construct new Fed object
    feds << curFed      # Add it to the array
    curFed.fedno = words[2]
    @num = 1
    next
  end

  if(@num == 1) then
    curFed.title = line
    @num = @num + 1
    curFed.publisher = "N/A"
    curFed.date = "N/A"
    next
  end
  if (@num == 2 && temp.match(/(for the)|(from the)|(mclean's)/)) then
    if temp.match(/(1788)|(1787)/)
      split = line.split(". ", 2)
      puts split[0]
      curFed.publisher = split[0]
      curFed.date = split[1]
      next
    else
      curFed.publisher = line
      curFed.date = "N/A"
      @num = 0
      next
    end

  end
  if(@num == 3 && temp.match(/(for the)|(from the)|(mclean's)/)) then
    if temp.match(/(1788)|(1787)/)
      split = line.split(". ", 2)
      puts split[0]
      curFed.publisher = split[0]
      curFed.date = split[1]
      next
    else
      curFed.publisher = line
      curFed.date = "N/A"
      @num = 0
      next
    end
  end
  if line.match(/(JAY)|(MADISON)|(HAMILTON)/) then
    curFed.author = line
    @num = 0
    curFed = nil
    next
  end
  if(@num == 2)
    curFed.title = curFed.title + " " + line
    next
  end
  if words[0] == nil then
  end

end # End of reading
=end
id.close


users.each{|f| f.prt}
fileHtml = File.new("finalindex.html", "w+")
fileHtml.puts "<html>"
fileHtml.puts "<head><title>Users and Log ins</title></head>"
fileHtml.puts "<body>"
fileHtml.puts "<h3>Users and Log Ins</h3>"
fileHtml.puts "<table>"
fileHtml.puts "<tr><th>Name</th><th>Username</th><th>Logged In From</th><th>Processes</th><th>Admin</th></tr>"
users.each do |f|
  fileHtml.puts "<tr><td>"+ f.name + "</td><td>"+ f.username + "</td><td>"+ f.location + "</td><td>" + f.processes.to_s + "</td><td>" +  f.admin + "</td></tr>"
end
fileHtml.puts "</table>"
fileHtml.puts "</body>"
fileHtml.puts "</html>"
fileHtml.close