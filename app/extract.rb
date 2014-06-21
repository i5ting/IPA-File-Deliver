#! /bin/env ruby
#encoding=UTF-8  

require 'json'
require './app/appinfo'

DIST_PATH = 'public/dist'
IPA_PATH = 'public/dist/ipa'
EXTRACT_PATH = 'public/dist/extract'
PLIST_PATH = 'public/dist/plist'


Dir.mkdir(DIST_PATH) if File.directory?(DIST_PATH) == false
Dir.mkdir(IPA_PATH) if File.directory?(IPA_PATH) == false
Dir.mkdir(EXTRACT_PATH) if File.directory?(EXTRACT_PATH) == false
Dir.mkdir(PLIST_PATH) if File.directory?(PLIST_PATH) == false

class Extract

	def self.clear_all
		`rm -rf #{IPA_PATH}`
		`rm -rf #{EXTRACT_PATH}`
		`rm -rf #{PLIST_PATH}`
	
		Dir.mkdir(IPA_PATH) if File.directory?(IPA_PATH) == false
		Dir.mkdir(EXTRACT_PATH) if File.directory?(EXTRACT_PATH) == false
		Dir.mkdir(PLIST_PATH) if File.directory?(PLIST_PATH) == false
	
	end

	def self.do_all_in_one(upload_ipa_path,exec=false)
		# extract ipa to folder
		extract_zip(upload_ipa_path,exec)
	
		# parse plist info now
		parse_plist_info(upload_ipa_path)

		# copy ipa file
		copy_ipa_to_dist(upload_ipa_path)
	end

	def self.extract_zip(upload_ipa_path,exec=false)
		folder_name = upload_ipa_path.split('/').last.split('.').first
		puts "folder_name = #{folder_name}"
	
		path = "#{EXTRACT_PATH}/#{folder_name}"
	
	
		if File.directory?(path) == true
			puts 'remove ipa existed fold'
			`rm -rf #{path}`
		end
	
		Dir.mkdir(path) if File.directory?(path) == false
	
		cmd = "unzip #{upload_ipa_path} -d #{path}"
	
		# sleep 3
	
		puts cmd
		if exec
			`#{cmd}`
		end
	end


	def self.parse_plist_info(upload_ipa_path)
		folder_name = upload_ipa_path.split('/').last.split('.').first
		ipa_path = "#{IPA_PATH}/#{folder_name}"
	
		info_plist_path = `find "#{EXTRACT_PATH}/#{folder_name}" -name 'Info.plist'`

		puts "info_plist_path = #{info_plist_path}"


		plist_path = "#{PLIST_PATH}/#{folder_name}.plist"
		
		if File.exist?(plist_path) == true
			puts 'remove plist existed file'
			`rm -rf #{plist_path}`
		
		end
	
		app = AppInfo.new(info_plist_path,"#{PLIST_PATH}/#{folder_name}.plist")
		puts app.create_plist
	end


	def self.copy_ipa_to_dist(upload_ipa_path)
		folder_name = upload_ipa_path.split('/').last.split('.').first
	
		cmd = "cp -rf #{upload_ipa_path} #{IPA_PATH}/"
	
		`#{cmd}`
	end
	
	def self.create_plist_html(dir)
		puts dir
		path = "#{PLIST_PATH}/index.html"
	
		f=File.new(path, "w+")
		
		dir.each do |file|
			f.puts("<a href='#{File.basename(file)}'>#{File.basename(file)}</a><br>") if File.basename(file)!='index.html'
		end
		
		f.close
	end

end

# path = "#{ARGV[0]}"
#
# path = 'test/ddd'
#
#
# clear_all
# mdmpath = do_all_in_one('test/mdm_mc.ipa',true)
