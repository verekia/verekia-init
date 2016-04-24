# -*- mode: ruby -*-
# vi: set ft=ruby :

module OS
    def OS.windows?
        (/cygwin|mswin|mingw|bccwin|wince|emx/ =~ RUBY_PLATFORM) != nil
    end
    def OS.mac?
        (/darwin/ =~ RUBY_PLATFORM) != nil
    end
    def OS.unix?
        !OS.windows?
    end
    def OS.linux?
        OS.unix? and not OS.mac?
    end
end

Vagrant.configure(2) do |config|

  if OS.windows?
    config.vm.provider "virtualbox" do |v|
      v.customize ["setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate/v-root", "1"]
    end
    host_os = "Windows"
  elsif OS.mac?
    host_os = "Mac"
  elsif OS.unix?
    host_os = "UNIX"
  elsif OS.linux?
    host_os = "Linux"
  else
    host_os = "Unknown"
  end

  guest_port = 4567
  host_port = 5678

  config.vm.box = "ubuntu/trusty64"
  config.vm.provision :shell, path: "vagrant-provision.sh", env: { :host_os => host_os, :guest_port => guest_port, :host_port => host_port }
  config.vm.network :forwarded_port, guest: guest_port, host: host_port

end
