#require 'gettext/utils'

#task :update_po do
#  system 'cmd /c rmdir /s /q po'
#  GetText.update_pofiles('otaku',
#      Dir.glob('{app,components}/**/*.{rb,rhtml}'), 'otaku 1.0.0')
#end

#task :make_mo do
#  GetText.create_mofiles(true, 'po', 'locale')
#end

desc "Update pot/po files."
task :updatepo do
  require 'gettext_rails/tools'
  GetText.update_pofiles("otaku", #テキストドメイン名(init_gettextで使用した名前)
                         Dir.glob("{app,config,components,lib}/**/*.{rb,erb,rjs,rhtml}"),  #ターゲットとなるファイル
                         "otaku 1.0.0"  #アプリケーションのバージョン
                         )
end

desc "Create mo-files"
task :makemo do
  require 'gettext_rails/tools'
  GetText.create_mofiles
end