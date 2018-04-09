# === USER INPUT ===
  # Get desired directory to start at
    # > test whether directory exists
  # Get number of levels you want to recursively copy
    # > test positive integer

# === PARSING ===
  # Add home directory (absolute path) to dir_list (array of directories)
  # set current_dir equal to home directory
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
