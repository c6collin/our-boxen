class people::c6collin {
  include vim
  include ccleaner
  include chrome
  include dropbox
  include gimp
  include iterm2::stable
  include osx::dock::autohide
  include osx::global::expand_save_dialog
  include osx::global::expand_print_dialog
  include osx::finder::show_all_on_desktop
  include osx::disable_app_quarantine
  include osx::no_network_dsstores
  include python
  include rdio
  include sizeup
  include spotify
  include tmux
  include vlc

  class { 'intellij':
    edition => 'community',
  }

  $home     = "/Users/${::boxen_user}"
  $my       = "${home}/my"
  $dotfiles = "${my}/dotfiles"

  file { $my:
    ensure  => directory
  }

  repository { $dotfiles:
    source  => 'c6collin/dotfiles',
    require => File[$my]
  }

  repository { "${my}/solarized":
    source  => 'altercation/solarized',
    require => File[$my]
  }

  repository { "${my}/pasteboard":
    source  => 'ChrisJohnsen/tmux-MacOSX-pasteboard',
    require => File[$my]
  }

  file { "${vim::vimrc}":
    target  => "${dotfiles}/.vimrc",
    require => Repository["$dotfiles"]
  }

  file { "${home}/.bashrc":
    target  => "${dotfiles}/.bashrc",
    require => Repository["$dotfiles"]
  }

  file { "${home}/.tmux.conf":
    target  => "${dotfiles}/.tmux.conf",
    require => Repository["$dotfiles"]
  }

  class { 'ruby::global':
    version => '1.9.3'
  }

  ruby::gem { "teamocil for 1.9.3":
    gem     => "teamocil",
    ruby    => "1.9.3"
  }
  ruby::gem { "teamocil for 1.8.7":
    gem     => "teamocil",
    ruby    => "1.8.7"
  }
}
