# === DEBUG STUFF ===
debug = true
harmless = true
testrun = true

# === INITS ===
dir_list = Hash.new


unless testrun
  # === USER INPUT ===
  # Make parent dummy directory
  puts "Let's make a dummy directory structure."
  puts "What should we call our new parent directory?"
  while true
    new_parent = gets.chomp
      if Dir.exists?(new_parent)
        puts "\nThat directory already exists! Try a different name."
      else
        puts "\nExcellent. I'll create that directory now and put our dummy files in there."
        Dir.mkdir(new_parent) unless harmless
        break
      end
    end

  # Find and validate parent model directory
    puts "\nAlright. At which model directory do you want me to start when making this dummy directory structure?"
    while true
      mod_parent = gets.chomp
        if Dir.exists?(mod_parent)
          puts "\nExcellent. That seems like a good starting place.\n"
          break
        else
          puts "I can't find that directory. Make sure to give me the correct path (no escapes necessary):"
        end
      end

  # Find out how many recursive iterations to do
  puts "\nHow many recursive levels should I go through?"
  while true
    max_iter = gets.chomp
    if max_iter.to_i.to_s == max_iter and max_iter.to_i > 0 and max_iter.to_i < 25
      puts "\nExcellent. I'll go through #{max_iter} levels of directory, recursively."
      max_iter = max_iter.to_i
      break
    else
      puts "\nPlease give me a positive integer that is less than 25."
    end
  end
else
  new_parent = "testrundir"
  mod_parent = "/media/jebrii/MAC OS Storage/Vengeance copy/"
  max_iter = 24
end

puts new_parent if debug
puts mod_parent if debug
puts max_iter if debug
puts "" if debug

# === EXECUTION ===
current_dir = mod_parent
level = 1
done = false

until done
  puts "level #{level}" if debug
  puts current_dir if debug
  puts dir_list if debug

  Dir.each_child(current_dir) do |x|
    puts x
  end

  done = true
end

  # while dir_list.length() > 0
    # set current_dir equal to last directory in dir_list (DEBUG current_dir)
    # Dir.chdir to current_dir
    # Dir.each_child(current_dir) { |x|
      # DEBUG x
      # IF directory? {
        # !DEBUG Dir.mkdir(x)
        # dir_list.push(x)
      # IF file? {
        # !DEBUG File.open(x, "w")
    # remove current_dir from dir_list
    # Dir.chdir("..")
