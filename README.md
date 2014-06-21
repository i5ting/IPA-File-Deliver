# IPA-File-Deliver下载助手

iOS在7.1之后安装ipa必须走https，这就意味着你必须要有https证书，但未必每个人都需要这样做，于是有了这个开源项目（ IPA-File-Deliver）

它主要解决了从ipa生成下载的plist的过程，并把plist通过配置文件上传到指定的https内容提供商，目前计划支持

- upyun
- git pages
- dropbox(国内最近被墙了)

## Setup using [Bundler](http://gembundler.com/ "Bundler")

    $ bundle install

## Starting

    $ ./start.sh
	
then access address [http://127.0.0.1:9292/](http://127.0.0.1:9292/)

## gitpage 上传

	./ghp_generate.sh 
	
首次，可能需要等几分钟才能访问的。	

## Features

- 上传ipa
- 解析生成plist文件
- 生成app首页
- 配置ip地址，一键生成所有plist，每次换ip都要重新生成
- 自动提交到某git pages
- 生成api


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request


## 版本历史

- v0.1.0 初始化版本 

## License

this gem is released under the [MIT License](http://www.opensource.org/licenses/MIT).
