Dir.glob(Dir.pwd+'/*').sort.each do |f|
  filename = File.basename(f, File.extname(f))
  File.rename(f, filename.downcase + File.extname(f).downcase)
  puts "Renamed #{filename}" 
end
