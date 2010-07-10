# Adopted from Tate Johnsons's Rakefile
# http://github.com/tatey/tatey.com/blob/master/Rakefile

task :default => :server
 
desc 'Build site with Jekyll.'
task :build do
  jekyll
end
 
desc 'Start server with --auto.'
task :server do
  jekyll('--server --auto')
end

desc 'Remove all built files.'
task :clean do
  sh 'rm -rf _site'
end

desc 'Build, deploy, then clean.'
task :deploy => :build do
  sh 'rsync -rtzh --progress --delete _site/ opt6@opt-6.com:~/new.opt-6.com/'
  Rake::Task['clean'].execute
end

def jekyll(opts = '')
  Rake::Task['clean'].execute
  sh 'jekyll ' + opts
end