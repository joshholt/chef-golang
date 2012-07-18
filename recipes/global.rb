include_recipe "build-essential"
package "mercurial"

bash "Fetch golang source" do
  cwd "/usr/local"
  code <<-EOC
    hg clone -u release #{node['golang']['repo']}
  EOC
  creates "/usr/local/go"
end

bash "Build golang" do
  cwd "/usr/local/go/src"
  code <<-EOC
    ./all.bash
  EOC
  creates "/usr/local/go/bin/go"
end

bash "Export ENV Vars" do
  code <<-EOC
    echo 'export GOBIN=#{node['golang']['gobin']}' >> /home/vagrant/.bash_golang
    echo 'export PATH=$PATH:$GOBIN' >> /home/vagrant/.bash_golang
    echo 'source /home/vagrant/.bash_golang' >> /home/vagrant/.bashrc
    source /home/vagrant/.bashrc
  EOC
  creates "/home/vagrant/.bash_golang"
end