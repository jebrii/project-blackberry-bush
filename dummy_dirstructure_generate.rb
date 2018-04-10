# === DEBUG STUFF ===
debug = true
harmless = false
testrun = false
attached = true
short = false

# === INITS ===
dir_list = Hash.new

class String
  def cut_trailing_slash
    if self[-1] == "/"
      self.slice!(-1)
    end
  end
end

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
      new_parent.cut_trailing_slash
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
        mod_parent.cut_trailing_slash
        break
      else
        puts "I can't find that directory. Make sure to give me the correct absolute path (no escapes necessary):"
      end
    end

  # Find out how many recursive iterations to do
  puts "\nHow many recursive levels should I go through?"
  while true
    max_iter = gets.chomp
    if max_iter.to_i.to_s == max_iter && max_iter.to_i > 0 && max_iter.to_i < 25
      puts "\nExcellent. I'll go through #{max_iter} levels of directory, recursively."
      max_iter = max_iter.to_i
      break
    else
      puts "\nPlease give me a positive integer that is less than 25."
    end
  end
else
  new_parent = "/home/jebrii/jdev/projects/project-blackberry-bush/testdir"
  if attached
    mod_parent = "/media/jebrii/MAC OS Storage/Vengeance copy"
  else
    mod_parent = "../.."
  end
  max_iter = 24
end

# === EXECUTION ===

current_dir = mod_parent
new_dir = new_parent
dir_stem = ""
level = 0
count = 0
done = false

until done
  count += 1
  Dir.foreach(current_dir) do |x|
    if x[0] == "."
      puts "Skipping #{x}"
      next
    end
    if File.directory?("#{current_dir}/#{x}")
      puts "#{x} is a directory at level #{level + 1}"
      puts "Making new directory: #{new_dir}/#{x}"
      Dir.mkdir("#{new_dir}/#{x}") unless harmless
      if level + 1 < max_iter
        dir_list["#{current_dir}/#{x}"] = level + 1
      else
        puts "Reached max recursive iteration. Will not add children of #{current_dir}/#{x}"
      end
    elsif File.file?("#{current_dir}/#{x}")
      puts "#{x} is a file."
      f = File.open("#{new_dir}/#{x}","w") unless harmless
      f.close unless harmless

    else
      puts "I don't know what to make of #{x}"
    end
  end

  puts "\ncount: #{count}" if debug
  puts "\nlevel #{level}" if debug
  puts "\ndir_list:" if debug
  puts "\n#{dir_list}" if debug
  puts ""

  dir_list.delete(current_dir)
  if dir_list.empty?
    done = true
  else
    current_dir = dir_list.keys[0]
    puts "Changing current_dir to #{current_dir}" if debug
    level = dir_list.values[0]
    puts "Changing level to #{level}" if debug
    dir_stem = current_dir.slice(mod_parent.length..-1)
    new_dir = "#{new_parent}#{dir_stem}"
    puts "Changing new_dir to #{new_dir}" if debug
    puts ""
  end

  if short && count > 4
    break
  end
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
