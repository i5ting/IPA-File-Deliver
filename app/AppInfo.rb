#! /bin/env ruby
#encoding=UTF-8  

class AppInfo

	CFBUNDLENAME  = 'CFBundleName'#  = 球友群
	DTXCODE  = 'DTXcode'#  = 0511
	DTSDKNAME = 'DTSDKName'#  = iphoneos7.1
	DTSDKBUILD ='DTSDKBuild'#  = 11D167
	CFBUNDLEDEVELOPMENTREGION ='CFBundleDevelopmentRegion'#  = en
	CFBUNDLEVERSION ='CFBundleVersion'#  = 1.0.0.10
	BUILDMACHINEOSBUILD ='BuildMachineOSBuild'#  = 13C1021
	DTPLATFORMNAME ='DTPlatformName'#  = iphoneos
	CFBUNDLEPACKAGETYPE ='CFBundlePackageType'#  = APPL
	CFBUNDLESHORTVERSIONSTRING ='CFBundleShortVersionString'#  = 1.0.0
	CFBUNDLESUPPORTEDPLATFORMS ='CFBundleSupportedPlatforms'#
	CFBUNDLEINFODICTIONARYVERSION ='CFBundleInfoDictionaryVersion'#  = 6.0
	UIREQUIREDDEVICECAPABILITIES ='UIRequiredDeviceCapabilities'# 
	DTCOMPILER ='DTCompiler'#  = com.apple.compilers.llvm.clang.1_0
	CFBUNDLEEXECUTABLE ='CFBundleExecutable'#  = 球友群
	CFBUNDLEURLTYPES ='CFBundleURLTypes'#  
	CFBUNDLEIDENTIFIER ='CFBundleIdentifier'#  = im.qiuyouqun.cn
	CFBUNDLERESOURCESPECIFICATION ='CFBundleResourceSpecification'#  = ResourceRules.plist
	DTPLATFORMVERSION ='DTPlatformVersion'#  = 7.1
	LSREQUIRESIPHONEOS ='LSRequiresIPhoneOS'#  = true
	UISUPPORTEDINTERFACEORIENTATIONS ='UISupportedInterfaceOrientations'#
	CFBUNDLEDISPLAYNAME ='CFBundleDisplayName'#  = 友群
	CFBUNDLESIGNATURE ='CFBundleSignature'#  = ????
	DTXCODEBUILD ='DTXcodeBuild'#  = 5B1008
	MINIMUMOSVERSION ='MinimumOSVersion'#  = 6.0
	DTPLATFORMBUILD ='DTPlatformBuild'#  = 11D167
	
	
	attr_accessor :bundle_display_name
	
	
	def initialize(in_path,out_path='')
		@path = in_path
		@out_path = out_path
	end
	
	  
	def get_attr_by_name_with_chomp(name)
		get_attr_by_name(name).chomp
	end

	def get_attr_by_name(name)
		cmd = "/usr/libexec/PlistBuddy -c  'print #{name}' #{@path}"
		`#{cmd}`
	end
	
	def get_attr_by(path,name)
		cmd = "/usr/libexec/PlistBuddy -c  'print #{name}' #{path}"
		`#{cmd}`
	end
 
	def bundle_display_name
		get_attr_by_name_with_chomp(CFBUNDLEDISPLAYNAME)
	end
 
	def bundle_executable_name
		get_attr_by_name_with_chomp(CFBUNDLEEXECUTABLE)
	end
  
  def bundle_name
		get_attr_by_name_with_chomp(CFBUNDLENAME)
	end
	
  def bundle_version
		get_attr_by_name_with_chomp(CFBUNDLEVERSION)
	end
	
  def bundle_id
		get_attr_by_name_with_chomp(CFBUNDLEIDENTIFIER)
	end
	
  def plateform_name
		get_attr_by_name_with_chomp(DTPLATFORMNAME)
	end
	
  def plateform_version
		get_attr_by_name_with_chomp(DTPLATFORMVERSION)
	end
		
  def minimum_os_version
		get_attr_by_name_with_chomp(MINIMUMOSVERSION)
	end
	
  def dt_compiler
		get_attr_by_name_with_chomp(DTCOMPILER)
	end
	
	def create_plist
		hash = Hash.new
		hash = {
	 	  'bundle_display_name' => bundle_display_name,
	 	  'bundle_executable_name' => bundle_executable_name,
	    'bundle_name' => bundle_name,
	    'bundle_version' => bundle_version,
	    'bundle_id' => bundle_id,
	    'plateform_name' => plateform_name,
	    'plateform_version' => plateform_version,
	    'minimum_os_version' => minimum_os_version,
	    'dt_compiler' => dt_compiler
		}
		
		if @out_path.length > 0
			f=File.new(@out_path, "w+")
			f.puts(get_file_as_string(hash))
			f.close
		end
		
		# get_file_as_string
		
		hash.to_json
	end
	
	TEMPLATE_PLIST_FILE_PATH= 'public/templates/template.plist'
	
	
	# 获取plist替换后的string
	#
	def get_file_as_string(hash)
		# puts hash['bundle_executable_name']
		
	  data = ''
	  f = File.open(TEMPLATE_PLIST_FILE_PATH, "r") 
	  f.each_line do |line|

			if line =~ /template\.ipa/
				#puts "line = #{line}"
				
				ipa_name = "#{hash['bundle_executable_name']}.ipa"
				s = line.gsub(/template\.ipa/, ipa_name)
				
				data +=  s
				
			elsif line =~ /template-display-name/
				#puts "line = #{line}"
				display_name = hash['bundle_executable_name']
				
				s = line.gsub(/template-display-name/, display_name)
				
				data +=  s
			elsif line =~ /com.nationsky.template/
				#puts "line = #{line}"
				my_bundle_id = hash['bundle_id']
				
				s = line.gsub(/com.nationsky.template/, my_bundle_id)
				
				data +=  s
				 
			else
				
				data += line
			end
			
			# puts str
	  end
		
		# puts data
		
		data
	end
	
	 
end
