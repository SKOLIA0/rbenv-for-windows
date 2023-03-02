# Usage: rbenv rehash [<command>] [<version/gem>]
# Summary: Rehash rbenv shims (run this after installing executables)
# Help: rbenv rehash                => rehash the current version
# rbenv rehash version xxx    => rehash existing commands for a version
# rbenv rehash executable xxx => rehash an executable across versions
#

param($cmd, $argument)

$SHIMS_DIR = "$env:RBENV_ROOT\shims"

$REHASH_TEMPLATE = @'
# Auto generated by 'rbenv rehash'
. $env:RBENV_ROOT\rbenv\lib\version.ps1
$gem = shim_get_gem_executable_location $PSCommandPath
& $gem $args
'@
#
# if exists, $gem is
#   C:\Ruby-on-Windows\correct_version_dir\bin\'gem_name'.bat or
#   C:\Ruby-on-Windows\correct_version_dir\bin\'gem_name'.cmd
#


function ensure_shims_dir() {
    if(Test-Path $SHIMS_DIR) {}
    else { New-Item -Path $SHIMS_DIR -ItemType Directory | Out-Null }
}


# Generate shims for specific name across all versions
#
# Note that $name shouldn't have suffix
#
# This is called after you install a gem
function rehash_single_executable ($name, $echo_or_not=$True) {
    Set-Content "$SHIMS_DIR\$name.ps1" $REHASH_TEMPLATE -NoNewline
    if($echo_or_not){
        success "rbenv: Rehash executable $argument"
    }
}


# Generate shims for a version itself
#
#
# Every time you cd into a dir that has '.ruby-version', you
# want all shims already exists in current global version
# so that you can call it directly as if you have changed the ruby
# version.
#
# So we just need to keep the global version dir, i.e. shims dir
# always have the names that every Ruby has installed to.
#
# How can we achieve this? Via two steps:
# 1. Every time you install a new Ruby version, call 'rehash_version'
# 2. Every time you install a gem, call 'rehash_single_executable'
#
function rehash_version ($version) {

    ensure_shims_dir

    $version = auto_fix_version_for_installed $version

    $where = get_bin_path_for_version $version

    $bats = Get-ChildItem "$where\*.bat" | % { $_.Name}

    # From Ruby 3.1.0-1, all default gems except 'gem.cmd' are xxx.bat
    # So we still should handle cmds before 3.1.0-1 and for 'gem.cmd'
    $cmds = Get-ChildItem "$where\*.cmd" | % { $_.Name}

    # 'setrbvars.cmd' and 'ridk.cmd' shouldn't be rehashed
    $cmds = [Collections.ArrayList]$cmds
    $cmds.Remove('setrbvars.cmd')
    $cmds.Remove('ridk.cmd')


    # remove .bat suffix
    $bats = $bats | % { strip_ext $_}
    # remove .cmd suffix
    $cmds = $cmds | % { strip_ext $_}

    $executables = $bats + $cmds

    # echo $executables

    foreach ($exe in $executables) {
        rehash_single_executable $exe $False
    }
    success "rbenv: Rehash all $($executables.Count) executables in '$version'"
}


if (!$cmd) {
    $version, $_ = get_current_version_with_setmsg_from_fake_ruby
    rehash_version $version

} elseif ($cmd -eq 'version') {
    if (!$argument) { rbenv help rehash; return}
    $version = auto_fix_version_for_installed $argument
    rehash_version $version

} elseif ($cmd -eq 'executable') {
    if (!$argument) { rbenv help rehash; return}
    ensure_shims_dir
    rehash_single_executable $argument

} else {
    rbenv help rehash
}
