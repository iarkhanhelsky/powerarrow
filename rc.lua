require("awful")
require("awful.autofocus")
require("awful.rules")
require("beautiful")
require("naughty")
require("vicious")
require("helpers")
require("calendar")


-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.add_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = err })
        in_error = false
    end)
end
-- }}}

--{{---| Theme |------------------------------------------------------------------------------------

config_dir = ("/home/dm/.config/awesome/")
themes_dir = (config_dir .. "/themes")
beautiful.init(themes_dir .. "/powerarrow/theme.lua")

--{{---| Variables |--------------------------------------------------------------------------------

modkey        = "Mod4"
terminal      = 'sakura'
editor        = os.getenv("EDITOR") or "vim"
editor_cmd    = terminal .. " -e " .. editor

terminalr     = "sudo terminal --default-working-directory=/root/ --geometry=200x49+80+36"
configuration = "TERM=screen-256color lilyterm -T 'Awesome Configuration' -g 228x62+0+16 -x ~/.gem/ruby/1.9.1/bin/mux start configuration"
rttmux        = "sudo gnome-terminal --geometry=220x59+20+36 --default-working-directory=/root/ -x tmux -2"
ttmux         = "lilyterm -T tmux -g 221x60+20+36 -e tmux -2"
tetmux        = "terminal --geometry=189x54+20+36 -x tmux -2"
sakura        = "sakura -c 222 -r 60 --geometry=+15+30"
lilyterm      = "lilyterm -g 221x60+20+36"
musicplr      = "lilyterm -T Music -g 130x34-320+16 -e ncmpcpp"
iptraf        = "lilyterm -T 'IP traffic monitor' -g 180x54-20+34 -e sudo iptraf-ng -i all"
mailmutt      = "lilyterm -T 'Mutt' -g 140x44-20+34 -e mutt"
chat          = "TERM=screen-256color lilyterm -T 'Chat' -g 228x62+0+16 -x ~/.gem/ruby/1.9.1/bin/mux start chat"
browser       = "google-chrome"
fm            = "nautilus"

local sys = {}
function sys.suspend()
    exec('dbus-send --system --print-reply --dest="org.freedesktop.UPower" /org/freedesktop/UPower org.freedesktop.UPower.Suspend')
end
function sys.hibernate()
    exec('dbus-send --system --print-reply --dest="org.freedesktop.UPower" /org/freedesktop/UPower org.freedesktop.UPower.Hibernate')
end
function sys.reboot()
    exec('dbus-send --system --print-reply --dest="org.freedesktop.ConsoleKit" /org/freedesktop/ConsoleKit/Manager org.freedesktop.ConsoleKit.Manager.Restart')
end
function sys.shutdown()
    exec('dbus-send --system --print-reply --dest="org.freedesktop.ConsoleKit" /org/freedesktop/ConsoleKit/Manager org.freedesktop.ConsoleKit.Manager.Stop')
end
function sys.logout()
    exec('gnome-session-quit')
end
function sys.lock()
    exec('xscreensaver-command -lock')
end

-- {{{ Function definition

function show_window_info(c)
  local geom = c:geometry()

  local t = ""
  if c.class    then t = t .. setFg("green", "<b>Class</b>: ")    .. c.class    .. "\n" end
  if c.instance then t = t .. setFg("green", "<b>Instance</b>: ") .. c.instance .. "\n" end
  if c.role     then t = t .. setFg("green", "<b>Role</b>: ")     .. c.role     .. "\n" end
  if c.name     then t = t .. setFg("green", "<b>Name</b>: ")     .. c.name     .. "\n" end
  if c.type     then t = t .. setFg("green", "<b>Type</b>: ")     .. c.type     .. "\n" end
  if geom.width and geom.height and geom.x and geom.y then
    t = t .. setFg("green", "<b>Dimensions</b>: ") .. "<b>x</b>:" .. geom.x .. "<b> y</b>:" .. geom.y .. "<b> w</b>:" .. geom.width .. "<b> h</b>:" .. geom.height
  end

  naughty.notify({
    text = t,
    timeout = 30
  })
end
  
-- }}}

--{{---| Couth Alsa volume applet |-----------------------------------------------------------------

--couth.CONFIG.ALSA_CONTROLS = { 'Master', 'PCM', 'Headphone' }

--{{---| Table of layouts |-------------------------------------------------------------------------

layouts =
{
    awful.layout.suit.floating,
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.spiral,
    awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    awful.layout.suit.max.fullscreen,
    awful.layout.suit.magnifier
}
--{{---| Naughty theme |----------------------------------------------------------------------------

naughty.config.default_preset.font         = beautiful.notify_font
naughty.config.default_preset.fg           = beautiful.notify_fg
naughty.config.default_preset.bg           = beautiful.notify_bg
naughty.config.presets.normal.border_color = beautiful.notify_border
naughty.config.presets.normal.opacity      = 0.7
naughty.config.presets.low.opacity         = 0.7
naughty.config.presets.critical.opacity    = 0.7

-- {{{ Tags
 -- Define a tag table which will hold all screen tags.
-- tags = {
--   names  = { "α", "β", "γ", "δ", "φ", "χ", "ψ", "ω" },
--   layout = { layouts[4], layouts[1], layouts[1], layouts[1], layouts[2], layouts[1],
--              layouts[1], layouts[2]
-- }}
-- for s = 1, screen.count() do
     -- Each screen has its own tag table.
--     tags[s] = awful.tag(tags.names, s, tags.layout)
-- end

tags = {}
for s = 1, screen.count() do
    -- Each screen has its own tag table.
    tags[s] = awful.tag({ "ʬ", "ʭ", "ʍ", "ʂ", "ɷ", "ɱ", "Ȭ", "ƾ", "«" }, s, layouts[2])
end
 -- }}}

--{{---| Menu |-------------------------------------------------------------------------------------

myawesomemenu = {
  {"edit config",           "sublime_text /home/apavlov/.config/awesome/rc.lua"},
  {"edit theme",            "sublime_text /home/apavlov/.config/awesome/themes/powerarrow/theme.lua"},
  {"hibernate",             "sudo pm-hibernate"},
  {"restart",               awesome.restart },
  {"reboot",                "sudo reboot"},
  {"quit",                  awesome.quit }
}

docsmenu = {
  {" C",                    "/home/rom/Tools/doc_c", beautiful.c_icon},
  {" JavaScript",           "/home/rom/Tools/doc_js", beautiful.js_icon},
  {" Ruby",                 "/home/rom/Tools/doc_ruby", beautiful.ruby_icon} 
}

learningmenu = {
  {" C",                    "/home/rom/Books/C.sh", beautiful.c_icon},
  {" JavaScript",           "/home/rom/Books/JavaScrip.sh", beautiful.js_icon},
  {" Ruby On Rails",        "/home/rom/Books/RubyOnRails.sh", beautiful.ruby_icon}
}

mybooksmenu = {
  {" Documentation",        docsmenu, beautiful.docsmenu_icon},
  {" Learning",             learningmenu, beautiful.learning_icon},
  {"                                                            "}, 
  {" Assembler",            fm .. " ~/Books/Assembler/", beautiful.assembler_icon},
  {" C",                    fm .. " ~/Books/C/", beautiful.c_icon},
  {" C++",                  fm .. " ~/Books/C++/", beautiful.cpp_icon},
  {" D",                    fm .. " ~/Books/D/", beautiful.dlang_icon},
  {" Databases",            fm .. " ~/Books/Databases/", beautiful.databases_icon},
  {" Erlang",               fm .. " ~/Books/Erlang/", beautiful.erlang_icon},
  {" Java",                 fm .. " ~/Books/Java/", beautiful.java_icon},
  {" JavaScript",           fm .. " ~/Books/JavaScript/", beautiful.js_icon},
  {" Linux",                fm .. " ~/Books/Linux/", beautiful.linux_icon},
  {" Markup",               fm .. " ~/Books/HTML-CSS-XML/", beautiful.markup_icon},
  {" Misc",                 fm .. " ~/Books/Misc/"},
  {" Mobile Apps",          fm .. " ~/Books/Mobile-Apps/", beautiful.androidmobile_icon},
  {" Objective-C",          fm .. " ~/Books/Objective-C/"},
  {" Python",               fm .. " ~/Books/Python/", beautiful.py_icon},
  {" Regexp",               fm .. " ~/Books/Regexp/"},
  {" Ruby",                 fm .. " ~/Books/Ruby/", beautiful.ruby_icon},
  {" VCS",                  fm .. " ~/Books/VCS"}
}

myedumenu = {
  {" Anki",                 "anki", beautiful.anki_icon},
  -- {" Celestia",             "celestia", beautiful.celestia_icon},
  -- {" Geogebra",             "geogebra", beautiful.geogebra_icon},
  --{" CherryTree",           "cherrytree", beautiful.cherrytree_icon},
  --{" Free42dec",            "/home/rom/Tools/Free42Linux/gtk/free42dec", beautiful.free42_icon},
  {" GoldenDict",           "goldendict", beautiful.goldendict_icon},
  {" Qalculate",            "qalculate-gtk", beautiful.qalculate_icon},
  --{" Stellarium",           "stellarium", beautiful.stellarium_icon},
  --{" Vym",                  "vym", beautiful.vym_icon},
  --{" Wolfram Mathematica",  "/home/rom/Tools/Wolfram/Mathematica", beautiful.mathematica_icon},
  --{" XMind",                "xmind", beautiful.xmind_icon}
}

mydevmenu = {
--  {" Android SDK Updater",  "android", beautiful.android_icon},
--  {" Eclipse",              "/home/rom/Tools/eclipse/eclipse", beautiful.eclipse_icon},
--  {" Emacs",                "emacs", beautiful.emacs_icon},
--  {" GHex",                 "ghex", beautiful.ghex_icon},	
  {" IntellijIDEA",         "/usr/lib/idea/bin/idea.sh", beautiful.ideaUE_icon},
--  {" Kdiff3",               "kdiff3", beautiful.kdiff3_icon},
  {" Meld",                 "meld", beautiful.meld_icon},
--  {" pgAdmin",              "pgadmin3", beautiful.pgadmin3_icon},
--  {" Qt Creator",           "qtcreator", beautiful.qtcreator_icon},
--  {" RubyMine",             "/home/rom/Tools/rubymine.run", beautiful.rubymine_icon},
  {" SublimeText",          "sublime_text", beautiful.sublime_icon},
--  {" Tkdiff",               "tkdiff", beautiful.tkdiff_icon}
}

mygraphicsmenu = {
  {" Character Map",        "gucharmap", beautiful.gucharmap_icon},
  {" Fonty Python",         "fontypython", beautiful.fontypython_icon},
  {" gcolor2",              "gcolor2", beautiful.gcolor_icon},
  {" Gpick",                "gpick", beautiful.gpick_icon},
  {" Gimp",                 "gimp", beautiful.gimp_icon},
--  {" Inkscape",             "inkscape", beautiful.inkscape_icon},
--  {" recordMyDesktop",      "gtk-recordMyDesktop", beautiful.recordmydesktop_icon},
--  {" Screengrab",           "screengrab", beautiful.screengrab_icon},
--  {" Xmag",                 "xmag", beautiful.xmag_icon},
--  {" XnView",               "/home/rom/Tools/XnView/xnview.sh", beautiful.xnview_icon}
}

mymultimediamenu = {
--  {" Audacious",            "audacious", beautiful.audacious_icon},
  {" DeadBeef",             "deadbeef", beautiful.deadbeef_icon},
--  {" UMPlayer",             "umplayer", beautiful.umplayer_icon},
  {" VLC",                  "vlc", beautiful.vlc_icon}
}

myofficemenu = {
  {" Acrobat Reader",       "acroread", beautiful.acroread_icon},
  {" DjView",               "djview", beautiful.djview_icon},
--  {" KChmViewer",           "kchmviewer", beautiful.kchmviewer_icon},
 -- {" Leafpad",              "leafpad", beautiful.leafpad_icon},
  {" LibreOffice Base",     "libreoffice --base", beautiful.librebase_icon},
  {" LibreOffice Calc",     "libreoffice --calc", beautiful.librecalc_icon},
  {" LibreOffice Draw",     "libreoffice --draw", beautiful.libredraw_icon},
  {" LibreOffice Impress",  "libreoffice --impress", beautiful.libreimpress_icon},
  {" LibreOffice Math",     "libreoffice --math", beautiful.libremath_icon},	
  {" LibreOffice Writer",   "libreoffice --writer", beautiful.librewriter_icon},
--  {" Qpdfview",             "qpdfview", beautiful.qpdfview_icon},
--  {" ScanTailor",           "scantailor", beautiful.scantailor_icon},
--  {" Sigil",                "sigil", beautiful.sigil_icon}, 
--  {" TeXworks",             "texworks", beautiful.texworks_icon}
}

mywebmenu = {
  {" Chrome",               "google-chrome", beautiful.chromium_icon},
  {" Droppox",              "dropbox", beautiful.dropbox_icon},
  --{" Dwb",                  "dwb", beautiful.dwb_icon},
  --{" Filezilla",            "filezilla", beautiful.filezilla_icon},
  {" Firefox",              "firefox", beautiful.firefox_icon},
  --{" Gajim",                "gajim", beautiful.gajim_icon},
  --{" QuiteRSS",             "quiterss", beautiful.quiterss_icon},
  {" Luakit",               "luakit", beautiful.luakit_icon},
  --{" Opera",                "opera", beautiful.opera_icon},
  --{" Qbittorrent",          "qbittorrent", beautiful.qbittorrent_icon},
  {" Skype",                "skype", beautiful.skype_icon},
  --{" Tor",                  "/home/rom/Tools/tor-browser_en-US/start-tor-browser", beautiful.vidalia_icon},
  {" Thunderbird",          "thunderbird", beautiful.thunderbird_icon},
  --{" Weechat",              "lilyterm -x weechat-curses", beautiful.weechat_icon}
}

mysettingsmenu = {
  --{" CUPS Settings",        "sudo system-config-printer", beautiful.cups_icon},
  --{" JDK6 Settings",        "/opt/sun-jdk-1.6.0.37/bin/ControlPanel", beautiful.java_icon},
  --{" JDK7 Settings",        "/opt/oracle-jdk-bin-1.7.0.9/bin/ControlPanel", beautiful.java_icon},
  --{" Nvidia Settings",      "sudo nvidia-settings", beautiful.nvidia_icon},
  --{" Qt Configuration",     "qtconfig", beautiful.qt_icon},    
  --{" WICD",                 terminal .. " -x wicd-curses", beautiful.wicd_icon}
}

mytoolsmenu = {
  {" Gparted",              "sudo gparted", beautiful.gparted_icon},
  {" PeaZip",               "peazip", beautiful.peazip_icon},
  {" TeamViewer",           "teamviewer", beautiful.teamviewer_icon},
  --{" VirtualBox",           "VirtualBox", beautiful.virtualbox_icon},
  --{" Windows XP",           'VirtualBox --startvm "cb226b1a-3e7a-4a5c-b336-fc080ff687d1"', beautiful.windows_icon},
  -- {" Vmware Workstation",   "vmware", beautiful.vmware_icon},
  --{" UNetbootin",           "sudo unetbootin", beautiful.unetbootin_icon},
  --{" Xfburn",               "xfburn", beautiful.xfburn_icon}
}

mymainmenu = awful.menu({ items = { 
  {" awesome",             myawesomemenu, beautiful.awesome_icon },
  {" books",                mybooksmenu, beautiful.books_icon},
  {" development",          mydevmenu, beautiful.mydevmenu_icon},
  {" education",            myedumenu, beautiful.myedu_icon},
  {" graphics",             mygraphicsmenu, beautiful.mygraphicsmenu_icon},
  {" multimedia",           mymultimediamenu, beautiful.mymultimediamenu_icon},	    
  {" office",               myofficemenu, beautiful.myofficemenu_icon},
  {" tools",                mytoolsmenu, beautiful.mytoolsmenu_icon},
  {" web",                  mywebmenu, beautiful.mywebmenu_icon},
  {" settings",             mysettingsmenu, beautiful.mysettingsmenu_icon},
  {" calc",                 "/usr/bin/gcalctool", beautiful.galculator_icon},
  {" htop",                 terminal .. " -x htop", beautiful.htop_icon},
  {" sound",                "qasmixer", beautiful.wmsmixer_icon},
  {" file manager",         "nautilus", beautiful.spacefm_icon},
  {" root terminal",        "sudo " .. terminal, beautiful.terminalroot_icon},
  {" terminal",             terminal, beautiful.terminal_icon} 
}
})

mylauncher = awful.widget.launcher({ image = image(beautiful.clear_icon), menu = mymainmenu })

--{{---| Wibox |------------------------------------------------------------------------------------

mysystray = widget({ type = "systray" })
mywibox = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
                    awful.button({ }, 1, awful.tag.viewonly),
                    awful.button({ modkey }, 1, awful.client.movetotag),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, awful.client.toggletag),
                    awful.button({ }, 4, awful.tag.viewnext),
                    awful.button({ }, 5, awful.tag.viewprev)
                    )
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  if not c:isvisible() then
                                                      awful.tag.viewonly(c:tags()[1])
                                                  end
                                                 client.focus = c
                                                  c:raise()
                                              end
                                          end),
                     awful.button({ }, 3, function ()
                                              if instance then
                                                  instance:hide()
                                                  instance = nil
                                              else
                                                  instance = awful.menu.clients({ width=450 })
                                              end
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                              if client.focus then client.focus:raise() end
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                              if client.focus then client.focus:raise() end
                                          end))
for s = 1, screen.count() do
    mypromptbox[s] = awful.widget.prompt({ layout = awful.widget.layout.horizontal.leftright })
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                           awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.label.all, mytaglist.buttons)
    mytasklist[s] = awful.widget.tasklist(function(c)
                                              return awful.widget.tasklist.label.currenttags(c, s)
                                          end, mytasklist.buttons)

--{{---| Chat widget |------------------------------------------------------------------------------

chaticon = widget ({type = "imagebox" })
chaticon.image = image(beautiful.widget_chat)
chaticon:buttons(awful.util.table.join(awful.button({ }, 1,
function () awful.util.spawn_with_shell(chat) end)))

--{{---| Mail widget |------------------------------------------------------------------------------

mailicon = widget ({type = "imagebox" })
mailicon.image = image(beautiful.widget_mail)
mailicon:buttons(awful.util.table.join(awful.button({ }, 1, 
function () awful.util.spawn_with_shell(mailmutt) end)))

--{{---| Music widget |-----------------------------------------------------------------------------

music = widget ({type = "imagebox" })
music.image = image(beautiful.widget_music)
--{{---| MEM widget |-------------------------------------------------------------------------------

memwidget = widget({ type = "textbox" })
vicious.register(memwidget, vicious.widgets.mem, '<span background="#777E76" font="Terminus 12"> <span font="Terminus 9" color="#EEEEEE" background="#777E76">$2MB </span></span>', 13)
memicon = widget ({type = "imagebox" })
memicon.image = image(beautiful.widget_mem)

--{{---| CPU / sensors widget |---------------------------------------------------------------------

cpuwidget = widget({ type = "textbox" })
vicious.register(cpuwidget, vicious.widgets.cpu,
'<span background="#4B696D" font="Terminus 12"> <span font="Terminus 9" color="#DDDDDD">$2% <span color="#888888">·</span> $3% </span></span>', 3)
cpuicon = widget ({type = "imagebox" })
cpuicon.image = image(beautiful.widget_cpu)
--sensors = widget({ type = "textbox" })
--vicious.register(sensors, vicious.widgets.sensors)
tempicon = widget ({type = "imagebox" })
tempicon.image = image(beautiful.widget_temp)

--{{---| FS's widget / udisks-glue menu |-----------------------------------------------------------

fswidget = widget({ type = "textbox" })
vicious.register(fswidget, vicious.widgets.fs,
'<span background="#D0785D" font="Terminus 12"> <span font="Terminus 9" color="#EEEEEE">${/ avail_gb}GB </span></span>', 8)


--{{---| Battery widget |---------------------------------------------------------------------------  

baticon = widget ({type = "imagebox" })
baticon.image = image(beautiful.widget_battery)
batwidget = widget({ type = "textbox" })
vicious.register( batwidget, vicious.widgets.bat, '<span background="#92B0A0" font="Terminus 12"> <span font="Terminus 9" color="#FFFFFF" background="#92B0A0">$1$2% </span></span>', 1, "BAT1" )

--{{---| Net widget |-------------------------------------------------------------------------------

netwidget = widget({ type = "textbox" })
vicious.register(netwidget, 
vicious.widgets.net,
'<span background="#C2C2A4" font="Terminus 12"> <span font="Terminus 9" color="#FFFFFF">${wlan0 down_kb} ↓↑ ${wlan0 up_kb}</span> </span>', 3)
neticon = widget ({type = "imagebox" })
neticon.image = image(beautiful.widget_net)

-- {{{ Date and time
date_format = "%T"
-- Initialize widget
datewidget = widget({ type = "textbox" })
-- Register widget
vicious.register(datewidget, vicious.widgets.date, '<span background="#777E76" font="Terminus 12"> <span font="Terminus 10" color="#FFFFFF">%T</span> </span>', 1)

calendar.addCalendarToWidget(datewidget, setFg("green", "<b>%s</b>"))
-- }}}


--{{---| Separators widgets |-----------------------------------------------------------------------

spr = widget({ type = "textbox" })
spr.text = ' '
sprd = widget({ type = "textbox" })
sprd.text = '<span background="#313131" font="Terminus 12"> </span>'
spr3f = widget({ type = "textbox" })
spr3f.text = '<span background="#777e76" font="Terminus 12"> </span>'
arr1 = widget ({type = "imagebox" })
arr1.image = image(beautiful.arr1)
arr2 = widget ({type = "imagebox" })
arr2.image = image(beautiful.arr2)
arr3 = widget ({type = "imagebox" })
arr3.image = image(beautiful.arr3)
arr4 = widget ({type = "imagebox" })
arr4.image = image(beautiful.arr4)
arr5 = widget ({type = "imagebox" })
arr5.image = image(beautiful.arr5)
arr6 = widget ({type = "imagebox" })
arr6.image = image(beautiful.arr6)
arr7 = widget ({type = "imagebox" })
arr7.image = image(beautiful.arr7)
arr8 = widget ({type = "imagebox" })
arr8.image = image(beautiful.arr8)
arr9 = widget ({type = "imagebox" })
arr9.image = image(beautiful.arr9)
arr0 = widget ({type = "imagebox" })
arr0.image = image(beautiful.arr0)


--{{---| Panel |------------------------------------------------------------------------------------

mywibox[s] = awful.wibox({ position = "top", screen = s, height = "16" })

mywibox[s].widgets = {
   { mylauncher, mytaglist[s], mypromptbox[s], layout = awful.widget.layout.horizontal.leftright },
     mylayoutbox[s],
     arr1,
     spr3f,
     datewidget,
     spr3f, 
     -- arrl, 
     -- my_cal.widget,
     arr2, 
     netwidget,
     neticon,
     arr3,
     batwidget,
     baticon,
     arr4, 
     fswidget,
     --udisks_glue.widget,
     arr5,
    -- sensors,
 --    tempicon,
     arr6,
     cpuwidget,
     cpuicon,
     arr7,
     memwidget,
     memicon,
     arr8,
     --task_warrior.widget,
     arr9,
     music,
     arr0,
     mailicon, 
     arr9,
     spr,
     s == 1 and mysystray, spr or nil, mytasklist[s], 
     layout = awful.widget.layout.horizontal.rightleft } end

-- {{{ Mouse bindings

root.buttons(awful.util.table.join(
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))



--{{---| Key bindings |-----------------------------------------------------------------------------

-- {{{ Key bindings
globalkeys = awful.util.table.join(
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev       ),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext       ),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore),

    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "w", function () mymainmenu:show({keygrabber=true}) end),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.util.spawn(terminal) end),
    awful.key({ modkey, "Control" }, "r", awesome.restart),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit),

    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)    end),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)    end),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1)      end),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1)      end),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1)         end),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)         end),
    awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end),

    -- Prompt
    awful.key({ modkey },            "r",     function () mypromptbox[mouse.screen]:run() end),
    

    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run({ prompt = "Run Lua code: " },
                  mypromptbox[mouse.screen].widget,
                  awful.util.eval, nil,
                  awful.util.getdir("cache") .. "/history_eval")
              end)    
)

clientkeys = awful.util.table.join(
    awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
    awful.key({ modkey, "Shift"   }, "r",      function (c) c:redraw()                       end),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end),
    awful.key({ modkey,           }, "n",      function (c) c.minimized = not c.minimized    end),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end)
)

-- Compute the maximum number of digit we need, limited to 9
keynumber = 0
for s = 1, screen.count() do
   keynumber = math.min(9, math.max(#tags[s], keynumber));
end

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, keynumber do
    globalkeys = awful.util.table.join(globalkeys,
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = mouse.screen
                        if tags[screen][i] then
                            awful.tag.viewonly(tags[screen][i])
                        end
                  end),
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = mouse.screen
                      if tags[screen][i] then
                          awful.tag.viewtoggle(tags[screen][i])
                      end
                  end),
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.movetotag(tags[client.focus.screen][i])
                      end
                  end),
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.toggletag(tags[client.focus.screen][i])
                      end
                  end))
end

clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = true,
                     keys = clientkeys,
                     buttons = clientbuttons } },
    { rule = { class = "MPlayer" },
      properties = { floating = true } },
    { rule = { class = "pinentry" },
      properties = { floating = true } },
    { rule = { class = "gimp" },
      properties = { floating = false, tag=tags[8] }},
    -- Set Firefox to always map on tags number 2 of screen 1.
    -- { rule = { class = "Firefox" },
    --   properties = { tag = tags[1][2] } },
    { rule = { class = "Clementine" },
       properties = { tag = tags[1][3] } },
    { rule = { class = "Eclipse" },
       properties = { tag = tags[1][4] } },

    { rule = { class = "Pidgin" },
       properties = { tag = tags[1][2] } },
    { rule = { class = "Google-chrome" },
       properties = { tag = tags[1][1] } },
    { rule = { class = "Sakura" },
       properties = { tag = tags[1][5] } },
    { rule = { class = "java-lang-Thread"},
  properties = { tag = tags [1][4]} },
    { rule = { class = "Gitg"},
  properties = {tag = tags [1][4]} },
    { rule = { class = "Qtcreator"},
  properties = { tag = tags [1][4]} },
  { rule = { class = "Skype"},
  properties = { tag = tags [1][2]} },
  { rule = { name = "Simulator"},
  properties = { tag = tags [1][4], floating = true }}

    
}-- }}}

-- {{{ Focus signal handlers
client.add_signal("focus",
   function (c)
    c.border_color = beautiful.border_focus  
    c.opacity = 1
    end)
client.add_signal("unfocus",
 function (c) 
  c.border_color = beautiful.border_normal 
  c.opacity = 0.8
  end)
-- }}}

-- {{{ Arrange signal handler
for s = 1, screen.count() do screen[s]:add_signal("arrange", function ()
    local clients = awful.client.visible(s)
    local layout = awful.layout.getname(awful.layout.get(s))

    for _, c in pairs(clients) do -- Floaters are always on top
        if   awful.client.floating.get(c) or layout == "floating"
        then if not c.fullscreen then c.above       =  true  end
        else                          c.above       =  false end
    end
  end)
end
-- }}}
-- }}}

--{{---| run_once |---------------------------------------------------------------------------------

function run_once(prg)
  awful.util.spawn_with_shell("pgrep -u $USER -x " .. prg .. " || (" .. prg .. ")") end

--{{---| run_once with args |-----------------------------------------------------------------------

function run_oncewa(prg) if not prg then do return nil end end
    awful.util.spawn_with_shell('ps ux | grep -v grep | grep -F ' .. prg .. ' || ' .. prg .. ' &') end

--{{--| Autostart |---------------------------------------------------------------------------------

--os.execute("pkill compton")
--os.execute("setxkbmap -layout 'us,ru' -variant 'winkeys' -option 'grp:caps_toggle,grp_led:caps,compose:ralt' &")
--run_once("udisks-glue")

-- os.execute("sudo /etc/init.d/dcron start &")
--run_once("kbdd")
--run_once("qlipper")
--run_once("compton")
--require('autorun')

--{{Xx----------------------------------------------------------------------------------------------

