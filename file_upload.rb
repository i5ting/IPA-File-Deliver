# encoding: utf-8

require 'sinatra/base'
require 'slim'

require 'rubygems'
require './app/extract'

class FileUpload < Sinatra::Base
  configure do
    enable :static
    enable :sessions
    
    
    Dir.mkdir('public/dist') if File.directory?('public/dist') == false

    set :views, File.join(File.dirname(__FILE__), 'views')
    set :public_folder, File.join(File.dirname(__FILE__), 'public')
    set :files, File.join(settings.public_folder, 'files')
		set :plistfiles, File.join(settings.public_folder, 'dist/plist')
		set :ipafiles, File.join(settings.public_folder, 'dist/ipa')
    set :unallowed_paths, ['.', '..','dist/plist/']
  end

  helpers do
    def flash(message = '')
      session[:flash] = message
    end
  end

  before do
    @flash = session.delete(:flash)
  end

  not_found do
    slim 'h1 404'
  end

  error do
    slim "Error (#{request.env['sinatra.error']})"
  end

  get '/' do
    @plistfiles = Dir.entries(settings.plistfiles) - settings.unallowed_paths
		@ipafiles = Dir.entries(settings.ipafiles) - settings.unallowed_paths
		
    slim :index
  end
	
	get '/clear' do
		Extract.clear_all
		
		redirect '/'
	end
  
  post '/upload' do
    if params[:file]
      filename = params[:file][:filename]
      file = params[:file][:tempfile]
			
			puts filename.split('.').last
			
			
			if filename.split('.').last != 'ipa'
				flash '不支持非ipa文件，请重新上传'
				''
			end
			
			path = File.join(settings.files, filename)
			
			File.open(File.join(settings.files, filename), 'wb') do |f|
        f.write file.read
				
				Extract.do_all_in_one(path,true)
      end
			
			plistfiles = Dir.entries(settings.plistfiles) - settings.unallowed_paths
			
			Extract.create_plist_html(plistfiles)
			
			
      flash 'Upload successful'
    else
      flash 'You have to choose a file'
    end

    redirect '/'
  end
end
