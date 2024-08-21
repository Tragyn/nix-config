let
  fg = "#5DE4C7";
  active = "#E4F0FB";
in /* kdl */ ''
  layout {
    pane split_direction="horizontal" {
      pane size=1 borderless=true {
        plugin location="file:$HOME/.config/zellij/plugins/zjstatus.wasm" {
          format_left   "{mode} #[fg=#E2E0DF,bold]{session}"
          format_center "{tabs}"
          format_right  "{command_git_branch} {datetime}"
          format_space  ""

          border_enabled  "false"
          border_char     "─"
          border_format   "#[fg=#6C7086]{char}"
          border_position "top"

          hide_frame_for_single_pane "true"

          mode_normal  "#[bg=blue] "
          mode_tmux    "#[bg=#ffc387] "

          tab_normal   "#[fg=#777777] {name} "
          tab_active   "#[fg=#E2E0DF,bold,italic] {name} "

          command_git_branch_command     "git rev-parse --abbrev-ref HEAD"
          command_git_branch_format      "#[fg=blue] {stdout} "
          command_git_branch_interval    "10"
          command_git_branch_rendermode  "static"

          datetime        "#[fg=#6C7086,bold] {format} "
          datetime_format "%A, %d %b %Y %H:%M"
          datetime_timezone "Europe/London"
        }
      }
      pane
      pane {
        borderless true
        size 7
        command "spotify_player"
      }
    }
  }''