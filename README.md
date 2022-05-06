# rbenv for Windows

[![Join the chat at https://gitter.im/rbenv-for-windows/community](https://badges.gitter.im/rbenv-for-windows/community.svg)](https://gitter.im/rbenv-for-windows/community?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

Manage multiple Rubies on Windows.

<br>

## What difficulties we have met?

I need your help guys!

1. We can't have a good prompt using `starship`
2. [Need upstream support for devkit in 7zip archive](https://github.com/ccmywish/rbenv-for-windows/issues/3)


<br>

## NOTE

At early stage, not available for users. But It's portable, be bold to try it first!

<br>

## Install

```PowerShell
mkdir -p "C:\Ruby-on-Windows"
git clone -C "C:\Ruby-on-Windows" "https://github.com/ccmywish/rbenv-for-windows" rbenv
```

In your $profile, you should add theses:

```PowerShell
# rbenv for Windows
$env:RBENV_ROOT = "C:\Ruby-on-Windows"
& "$env:RBENV_ROOT\rbenv\bin\rbenv.ps1" init
```

<br>

## Usage

```PowerShell
# Install Ruby 3.1.2-1
rbenv install 3.1.2

rbenv install 3.0.0-1

# Install devkit
# We need upstream support to implement this!
rbenv install msys

# List all installed versions
rbenv versions

# Set global version
rbenv global 3.0.0-1
# Check global version
rbenv global

rbenv shell 3.1.2-1

# Show current version
rbenv version

rbenv uninstall 3.1.2

# Update rbenv itself!
rbenv update
```

<br>

## How does it work?

We are a little different with how `rbenv` works. Surely, we have shims too, but our shims folder is always pointing to the global version.

 Every time you use `rbenv global x.x.x`, the shims folder location will not change, but the content of it will change wholly (unlike `rbenv` on Linux, there it will stores shell script to delegate).

You are maybe questioning the performance now, we use `junction` in Windows, so there is so little overhead you'll notice, in fact, this leads to about just 10ms delay.

There are three kind 'versions'
1. global version (set by `$env:RBENV_ROOT\global.txt`)
2. local version  (set by `$PWD\.ruby-version`)
3. shell version (set by `$env:RBENV_VERSION`)

### global version

After you setup `rbenv` your `path` will be:
```PowerShell
# for 'rbenv' command itself
$env:RBENV_ROOT\rbenv\bin

# for
# 1. ruby.exe rubyw.exe
# 2. gem.cmd, ...
# 3. bundler.bat irb.bat rdoc.bat rake.bat
#    and other gems bat
$env:RBENV_ROOT\shims\bin

# The default path of yours
$env:PATH
```

So every time you change global version, you will directly get what `$env:RBENV_ROOT\shims\bin` offers you! **No hack in path at all!**

<br>

### shell version

If we execute the command `rbenv shell 3.1.2`, we will get a new environment variable `$env:RBEVN_VERSION = 3.1.2`, and now your path will be:

```PowerShell
$env:
$env:RBENV_ROOT\3.1.2\bin

$env:RBENV_ROOT\rbenv\bin

$env:RBENV_ROOT\shims\bin

$env:PATH
```
So in this shell, your env will not be affected with `global version` or `local version`. **A very simple hack in path!**

<br>

### local version

Like `rbenv` we also don't hook on changing location. We use shims too. Our shims is directly in every ruby `bin` directory. Every ruby-related command has a `PowerShell` script individually, this script is called `shim`. The script will delegate to the correct version's `bin` directory. **No hack in path at all!**

<br>

## Environment Variables

- `RBENV_ROOT`: Ruby-on-Windows

name | default | description
-----|---------|------------
`$env:RBENV_VERSION` | | Specifies the Ruby version to be used in a shell. <br> **This variable is set by command, not yourself!**
`$env:RBENV_ROOT` | `C:\Ruby-on-Windows` | Defines the directory under which MSYS2, Ruby versions, shims and rbenv itself reside.

<br>

## Thanks

1. I reuse a lot of code pieces from [scoop](https://github.com/ScoopInstaller/Scoop)
2. The [RubyInstaller2](https://github.com/oneclick/rubyinstaller2) builds Ruby on Windows day and night
3. The [rbenv](https://github.com/rbenv/rbenv) is our role model

<br>
